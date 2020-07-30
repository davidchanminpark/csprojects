var mongoose = require('mongoose');

const options = {
	useUnifiedTopology: true,
	useNewUrlParser: true
}
mongoose.connect('mongodb+srv://cis350group25:gFbSgbXLfdKoGjTJ@davidchanminpark-ngn3p.mongodb.net/test?retryWrites=true&w=majority', options)
.then(res => console.log("connected to DB")).catch(err => console.log(err));


var Schema = mongoose.Schema;

var sellerSchema = new Schema({
	name: String,
	username: {type: String, lowercase: true, required: true, unique: true},
	password: String,
	storeName: String,
	picture: {data: Buffer, contentType: String},
	address: {street: String, city: String, state: String, zipcode: String},
	payment: {cardNum: String, cardHolderName: String},
  preferences: [String],
	totalCarbonSaved: Number,
	listings: [{type: Schema.Types.ObjectId, ref: 'Listing'}],
	bio: String
  });

// export personSchema as a class called Object
module.exports = mongoose.model('Seller', sellerSchema);
