var mongoose = require('mongoose');

var Schema = mongoose.Schema;

const options = {
	useUnifiedTopology: true,
	useNewUrlParser: true
}

mongoose.connect('mongodb+srv://cis350group25:gFbSgbXLfdKoGjTJ@davidchanminpark-ngn3p.mongodb.net/test?retryWrites=true&w=majority', options)
.then(res => console.log("connected to DB")).catch(err => console.log(err));

var buyerSchema = new Schema({
	name: String,
	username: {type: String, lowercase: true, required: true, unique: true},
	password: String,
	picture: {data: Buffer, contentType: String},
	address: {street: String, state: String, zipcode: String},
	payment: {cardNum: String, cardHolderName: String},
	storesFollowing: [{type: Schema.Types.ObjectId, ref: 'Seller'}]
});

module.exports = mongoose.model('Buyer', buyerSchema);
