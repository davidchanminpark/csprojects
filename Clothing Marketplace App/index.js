// if we are in development mode - load in environment variables and set them
if (process.env.NODE_ENV !== 'production') {
	require('dotenv').config();
}
// set up
var express = require('express');
var flash = require('express-flash');
var session = require('express-session');
var mongoose = require('mongoose');
var bodyParser = require('body-parser');
var methodOverride = require('method-override');
var bcrypt = require('bcrypt');
var passport = require('passport');
var initializePassport = require('./passport-config');
var multer = require('multer');
var GridFsStorage = require('multer-gridfs-storage');
var Grid = require('gridfs-stream');

var path = require('path');
// import classes/database connections
var Seller = require('./models/Seller.js');
var Buyer = require('./models/Buyer.js');
var Listing = require('./models/Listing.js');
//
var app = express();
app.set('view engine', 'ejs');
app.use(flash());
app.use(session({secret: 'secret'}));
// set up passport
app.use(passport.initialize());
// store variables to be persistent across all sessions
app.use(passport.session());
app.use(
	bodyParser.json({
		limit: "500mb"
	})
);
app.use(bodyParser.urlencoded({ extended: true }));
app.use(methodOverride('_method'));

// public folder
app.use(express.static('./public'));

// don't resave session if nothing is changed, don't save empty value in session
app.use(session({
	secret: process.env.SESSION_SECRET,
	resave: false,
	saveUnitialized: false
}));

// pass in passport and functions in passport.config file
// still need to specify which buyer or seller
initializePassport(
	passport
);

let gfs;

const conn = mongoose.connection;

conn.once('open', () => {
	// Init stream
	gfs = Grid(conn.db, mongoose.mongo);
	gfs.collection('uploads');
});

// // Create storage engine
// const storage = new GridFsStorage({
//   url: 'mongodb+srv://cis350group25:gFbSgbXLfdKoGjTJ@davidchanminpark-ngn3p.mongodb.net/test?retryWrites=true&w=majority'
//   file: (req, file) => {
//     return new Promise((resolve, reject) => {
//       crypto.randomBytes(16, (err, buf) => {
//         if (err) {
//           return reject(err);
//         }
//         const filename = buf.toString('hex') + path.extname(file.originalname);
//         const fileInfo = {
//           filename: filename,
//           bucketName: 'uploads'
//         };
//         resolve(fileInfo);
//       });
//     });
//   }
// });
// const upload = multer({ storage });

/***************************************/

// app.post('/upload', upload.single('file'), (req, res) => {
// 	res.json({file: req.file});
// })

// check if login is successful, redirect based on if it is, if not, display error
// don't go to login page at all if already authenticated
app.post('/loginpage', checkAlreadyAuthenticated, passport.authenticate('local', {
	successRedirect: '/homepage',
	failureRedirect: '/loginpage',
	failureFlash: true
}));

app.get('/loginpage', checkAlreadyAuthenticated, (req, res) => {
	res.render('loginpage.ejs');
})

app.get('/homepage', checkAuthenticated, async (req, res) => {
	try {
		await Listing.find({storeID: req.user._id}, (err, listings) => {
			if (err) {
				console.log(err);
			} else {
				res.render('homepage.ejs', {name: req.user.username, listings: listings});
			}
		});
	} catch (e) {
		console.log(e);
	}
});

app.get('/addlisting', checkAuthenticated, (req, res) => {
	res.render('addlisting.ejs', {name: req.user.username});
})

app.get('/createseller', checkAlreadyAuthenticated, (req, res) => {
	res.render('createseller.ejs');
})

app.get('/createbuyer', checkAlreadyAuthenticated, (req, res) => {
	res.render('createbuyer.ejs');
})

app.get('/admin', (req, res) => {
	res.render('admin.ejs');
})

app.get('/viewAnalytics', checkAuthenticated, async (req, res) => {
	try {
		var totalProfit = 0;
		var totalCarbonSavedSold = 0;
		var totalCarbonSavedPotential = 0;
		var rank;

		var listings;

		await Listing.find({storeID: req.user._id}, (err, val) => {
			if (err) {
				console.log("err", err);
				return res.redirect('/homepage');
			} else {
				for (var i = 0; i < val.length; i++) {
					if (val[i].sold == 'SOLD') {
						totalProfit += val[i].price;
						totalCarbonSavedSold += val[i].carbon;
						if (val[i].carbon != null) {
							totalCarbonSavedPotential += val[i].carbon;
						}
					} else {
						console.log(val.carbon);
						if (val[i].carbon != null) {
							totalCarbonSavedPotential += val[i].carbon;
						}
					}
				};
			}

		});

		console.log(totalProfit);
		console.log(totalCarbonSavedSold);
		console.log(totalCarbonSavedPotential);
		res.render('selleranalytics.ejs', {name: req.user.username, profit: totalProfit, carbonSavedSold: totalCarbonSavedSold, carbonSavedPotential: totalCarbonSavedPotential});


	} catch (e) {
		console.log(e);
		res.redirect('/homepage');
	}

});


app.post('/delete', (req, res) => {
	var itemToDelete = req.body.title;
	Listing.deleteOne({title: itemToDelete}, (err) => {
		if (err) {
			console.log(err);
		}
	})
})

app.get('/viewAllListings', async (req, res) => {
	try {
		await Listing.find({}, (err, listings) => {
			res.render('allListings.ejs', {listings: listings});
		})
	} catch (e) {
		console.log(e);
		res.redirect('/admin');
	}

});

app.post('/admin', (req, res) => {
	try {
		if (req.body.code == '12345') {
			res.redirect('/admin');
		} else {
			res.render('loginpage.ejs', {message: "Wrong Access Code"});
		}
	} catch {
		console.log("error");
		res.redirect('/loginpage');
	}
});

// this is the action of the "create seller" action on createseller.html
// don't go to page at all if already authenticated
app.post('/createSeller', checkAlreadyAuthenticated, async (req, res) => {
	try {
		// parse preferences
		var prefs = req.body.preferences;
		var prefArr = prefs.split(',');

		// hash password
		const hashedPassword = await bcrypt.hash(req.body.password, 10);
		// construct the Seller instance
		var newSeller = new Seller ({
			name: req.body.name,
			username: req.body.username,
			password: hashedPassword,
			address: {street: req.body.addressStreet, city: req.body.city, state: req.body.state, zipcode: req.body.zipcode},
			payment: {cardNum: req.body.paymentNumber, cardHolderName: req.body.paymentName},
			preferences: prefArr,
			storeName: req.body.storeName,
			bio: req.body.bio
		});

		// save the person to the database
		newSeller.save( (err) => {
			if (err) {
				res.type('html').status(200);
				res.write('error: ' + err);
				console.log(err);
				res.end();
			} else {
				console.log(newSeller);
				res.redirect('/loginpage');

			}
		});

	} catch (err) {
		console.log("error", err);
		res.redirect('/createseller');
	}
});

// this is the action of the "create buyer" action on createBuyer.html
// don't go to page at all if already authenticated
app.post('/createBuyer', checkAlreadyAuthenticated, async (req, res) => {
	try {

		// hash password
		const hashedPassword = await bcrypt.hash(req.body.password, 10);
		// construct the Buyer instance
		var newBuyer = new Buyer ({
			name: req.body.name,
			username: req.body.username,
			password: hashedPassword,
			address: {street: req.body.addressStreet, city: req.body.city, state: req.body.state, zipcode: req.body.zipcode},
			payment: {cardNum: req.body.paymentNumber, cardHolderName: req.body.paymentName},
		});

		// save the person to the database
		newBuyer.save( (err) => {
			if (err) {
				res.type('html').status(200);
				res.write('error: ' + err);
				console.log(err);
				res.end();
			} else {
				console.log('seller creation successful')
				// display the "successfull created" page using EJS
				res.render('/homepage', {name : req.user.username});
			}
		});

		res.redirect('/loginpage');
		console.log(newSeller);
	} catch {
		res.redirect('/createseller');
	}
});

// clear session and log out the user
// can't call delete from html - so need to isntall method methodOverride
// call delete using _method in homepage.html
app.delete('/logout', (req, res) => {
	req.logOut();
	res.redirect('/loginpage');
})

// middleware function that calls next when we are done
function checkAuthenticated(req, res, next) {
	if (req.isAuthenticated()) {
		console.log("authenticated");
		return next();
	} else {
		console.log("not authenticated");
		return res.redirect('/loginpage');
	}
}

function checkAlreadyAuthenticated(req, res, next) {
	if (req.isAuthenticated()) {
		console.log("bruh already authenticated");
		return res.redirect('/homepage');
	} else {
		console.log("not authenticated");
		return next();
	}
}

app.post('/createListing', checkAuthenticated, async (req, res) => {
	try {
		// parse preferences
		var keyws = req.body.keywords;
		var keywords = keyws.split(',');

		// construct the Seller instance
		var newListing = new Listing ({
			title: req.body.title,
			gender: req.body.gender,
			size: req.body.size,
			brand: req.body.brand,
			price: req.body.price,
			keywords: keywords,
			storeID: req.user._id,
			store: req.user.storeName
		});

		//save the listing to the database
		await newListing.save( (err) => {
			if (err) {
				res.type('html').status(200);
				res.write('error: ' + err);
				console.log(err);
				res.end();
			}
		});

		await Seller.findByIdAndUpdate(req.user._id,
			{"$addToSet": {"listings": newListing}},
			{"new": true, "upsert": true},
			(err, val) => {
				if (err) {
					throw err;
				} else {
					console.log(val);
					console.log(newListing);
					res.redirect('/homepage');
				}
			});

		} catch {
			res.redirect('/createseller');
		}
	});

	/*************************************************/

	// check if authenticated, if so continue with the body
	app.get('/', checkAuthenticated, (req, res) => {
		res.render('homepage.ejs', {name: req.user.username})
	});

	//app.use('/', (req, res) => { res.redirect('/public/loginpage.html'); } );

	app.listen(3000, () => {
		console.log('Listening on port 3000');
	});
