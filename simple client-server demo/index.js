var express = require('express');
var app = express();

// This is the definition of the Person class -- DO NOT CHANGE IT!
class Person {
    constructor(id, status, date) {
        this.id = id;
        this.status = status;
        this.date = date;
    }
}

// This is the map of IDs to Person objects -- DO NOT CHANGE IT!
var people = new Map();
people.set('1234', new Person('1234', 'safe', new Date().getTime()));
people.set('5678', new Person('5678', 'missing', new Date().getTime()));
people.set('1111', new Person('1111', 'safe', new Date().getTime()));
people.set('4321', new Person('4321', 'deceased', new Date().getTime()));
people.set('5555', new Person('5555', 'hospitalized', new Date().getTime()));
people.set('3500', new Person('3500', 'safe', new Date().getTime()));

// This is the '/test' endpoint that you can use to check that this works
// Do not change this, as you will want to use it to check the test code in Part 2
app.use('/test', (req, res) => {
    // create a JSON object
    var data = { 'message' : 'It works!' };
    // send it back
    res.json(data);
});

// This is the endpoint you need to implement in Part 1 of this assignment
app.use('/get', (req, res) => {
    var ids = req.query.id;

    // if undefined
    if (!ids) {
        res.send('[]');
    }
    var outputIds = [];
    if (Array.isArray(ids)) {
        // if there are multiple queries
        ids.forEach( (id) => {
            if (people.has(id)) {
                var value = people.get(id);
                var status = value.status;
                var date = value.date;
                var str = {'id': id,'status': status,'date': date};
            } else {
                var str = {'id':id, 'status':'unknown','date':new Date().getTime()};
            }
            outputIds.push(str);
        });
    } else {
        // if only one query
        if (people.has(ids)) {
            var value = people.get(ids);
            var status = value.status;
            var date = value.date;
            var str = {'id': ids,'status': status,'date': date};
        } else {
            var str = {'id':ids, 'status':'unknown','date':new Date().getTime()};
        }
        outputIds.push(str);
    }
    res.send(outputIds);
});

// -------------------------------------------------------------------------
// DO NOT CHANGE ANYTHING BELOW HERE!

// This endpoint allows a caller to add data to the Map of Person objects
// You do not need to do anything with this code; it is only provided
// as an example but will also be used for grading your code
app.use('/set', (req, res) => {
    // read id and status from query parameters
    var id = req.query.id;
    var status = req.query.status;
    // create new Person object
    var person = new Person(id, status, new Date().getTime());
    // add it to Map
    people.set(id, person);
    // send it back to caller
    res.json(person);
});

// This just sends back a message for any URL path not covered above
app.use('/', (req, res) => {
    res.send('Default message.');
});

// This starts the web server on port 3000.
app.listen(3000, () => {
    console.log('Listening on port 3000');
});
