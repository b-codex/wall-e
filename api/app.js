const express = require('express')
const mongoose = require('mongoose')
const fs = require('fs')
const url = require('url')
const queryString = require('querystring')

const app = express()

const log = console.log
var port = process.env.PORT || 6969

app.use(express.static(__dirname))
app.use(express.json())
mongoose.connect('mongodb://localhost:27017/test', {
    useNewUrlParser: true,
    useUnifiedTopology: true
}).catch(err => log(err.message))

const db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function () {
    log('we\'re connected')
});

const userSchema = mongoose.Schema({
    fullname: String,
    username: String,
    password: String,
    answer1: String,
    answer2: String,
    answer3: String,
})
const User = mongoose.model('User', userSchema, "Users")

app.get("/", function (req, res) {
    res.send({
        'status': 200
    })
})

app.get('/movies', (req, res) => {
    fs.readFile(__dirname + '/' + 'movies.json', 'utf8', (err, data) => {
        res.end(data)
    })
})

app.get('/getWallpapers', (req, res) => {
    // res.sendFile(__dirname + '\\Pictures\\startPage\\1.jpg')
    // res.sendFile(__dirname + '/Pictures/' + req.query.image + '.jpeg')
    res.json({
        'files': [
            'Pictures/startPage/1.jpg',
            'Pictures/startPage/2.jpg',
            'Pictures/startPage/3.jpg',
            'Pictures/startPage/4.jpg',
            'Pictures/startPage/5.jpg',
            'Pictures/startPage/6.jpg',
            'Pictures/startPage/7.jpg',
            'Pictures/startPage/8.jpg',
            'Pictures/startPage/9.jpg',
            'Pictures/startPage/10.jpg',
        ]
    })
})

app.get('/login', (req, res) => {
    var username = req.query.username
    var password = req.query.password
    db.collection('Users').findOne({
        username: username
    }, (err, r) => {
        if (r) {
            if (r.username == username && r.password == password) {
                res.json({
                    'status': ''
                })
            } else {
                res.json({
                    'status': 'Either Username Or Password Is Incorrect. Try Again.'
                })
            }
        } else {
            res.json({
                'status': 'No Such Account Exists. Please Proceed To Register Page To Create An Account.'
            })
        }
    })
})

app.post('/register', (req, res) => {

    const newUser = new User({
        fullname: req.query.fullname,
        username: req.query.username,
        password: req.query.password,
        answer1: req.query.answer1,
        answer2: req.query.answer2,
        answer3: req.query.answer3
    })
    log(newUser)
    db.collection('Users').findOne({
        username: newUser.username
    }, (err, r) => {
        if (r) {
            if (r.username == newUser.username) {
                // res.status(200)
                res.json({
                    "status": "Username Already Exists. Please Try A Different Username Or Proceed To Login Page."
                })
            }
        } else {
            newUser.save((err, result) => {
                if (err) log(err.message)
                // log('user created')
                res.send({
                    'status': '',
                })
            })
        }
    })
})

app.get('/forgotPassword', (req, res) => {
    fullname = req.query.fullname
    username = req.query.username
    answer1 = req.query.answer1
    answer2 = req.query.answer2
    answer3 = req.query.answer3
    db.collection('Users').findOne({
        username: username
    }, (err, r) => {
        if (r) {
            if (r.fullname == fullname && r.username == username && r.answer1 == answer1 && r.answer2 == answer2 && r.answer3 == answer3) {
                res.send({
                    'status': ''
                })
            } else {
                res.send({
                    'status': 'The Information You Entered Is Incorrect! Please Try Again!'
                })
            }
        }
    })
})

app.post('/resetPassword', (req, res) => {
    username = req.query.username
    password = req.query.password
    db.collection('Users').findOneAndUpdate({
        username: username
    }, {
        $set: {
            password: password
        }
    }, {
        new: true
    }, (err, data) => {
        if (err) {
            res.send({
                'status': 'Operation Failed'
            })
        } else {
            res.send({
                'status': ''
            })
        }
    })
})

app.post('/profile', (req, res) => {
    fullname = req.query.fullname
    username = req.query.username
    password = req.query.password

    db.collection('Users').findOneAndUpdate({
        username: username
    }, {
        $set: {
            fullname: fullname,
            password: password
        }
    }, {
        new: true
    }, (err, data) => {
        if (err) {
            res.send({
                'status': 'Operation Failed'
            })
        } else {
            res.send({
                'status': ''
            })
        }
    })
})

app.get('/profile', (req, res) => {
    username = req.query.username

    db.collection('Users').findOne({
        username: username
    }, (err, r) => {
        if (r) {
            res.send(r.data)
        }
        else{
            res.send({
                'status' : 'Operation Failed'
            })
        }
    })
})

app.listen(port, () => {
    console.log("Listening On Port " + port);
})