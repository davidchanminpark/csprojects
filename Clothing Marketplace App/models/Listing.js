var mongoose = require('mongoose');

var Schema = mongoose.Schema;

const options = {
	useUnifiedTopology: true,
	useNewUrlParser: true
}
mongoose.connect('mongodb+srv://cis350group25:gFbSgbXLfdKoGjTJ@davidchanminpark-ngn3p.mongodb.net/test?retryWrites=true&w=majority', options)
.then(res => console.log("connected to DB")).catch(err => console.log(err));

var listingSchema = new Schema({
	title: String,
	gender: String,
	size: String,
	brand: String,
	price: Number,
	typeClothing: String,
	keywords: [String],
	sold: {type: String, enum: ['SOLD', 'NOTSOLD'], default: 'NOTSOLD'},
	carbon: {type: Number, default: 75},
	storeID: Schema.Types.ObjectId,
	store: String,
	timeCreate: {type: Date, default: Date.now}
});

module.exports = mongoose.model('Listing', listingSchema);
