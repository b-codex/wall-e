const express = require('express')
const mongoose = require('mongoose')
const fs = require('fs')

const app = express()

const log = console.log
var port = process.env.PORT || 69

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
    secretKey: String
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
    var files = [];
    for (let index = 1; index <= 25; index++) {
        files.push('Pictures/startPage/' + index + '.jpg')

    }
    res.send({
        'files': files
    })
})

app.get('/category', (req, res) => {
    category = req.query.category
    var files = [];
    for (let index = 1; index <= 25; index++) {
        files.push('Pictures/' + category + '/' + index + '.jpg')

    }
    res.send({
        'files': files
    })
})

app.get('/login', (req, res) => {
    var username = req.query.username
    var password = req.query.password
    log("attempting login")
    db.collection('Users').findOne({
        username: username
    }, (err, r) => {
        if (r) {
            if (r.username == username && r.password == password) {
                res.json({
                    'status': ''
                })
                log('trying')
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
        secretKey: req.query.secretKey,
    })
    db.collection('Users').findOne({
        username: newUser.username
    }, (err, r) => {
        if (r) {
            if (r.username == newUser.username) {
                // res.status(200)
                res.json({
                    "status": "Failed"
                })
            }
        } else {
            newUser.save((err, result) => {
                if (err) log(err.message)
                res.send({
                    'status': '',
                })
            })
        }
    })
})

app.post('/resetPassword', (req, res) => {
    username = req.query.username
    password = req.query.password
    secretKey = req.query.secretKey

    db.collection('Users').findOne({
        username: username
    }, (err, r) => {
        if (r) {
            if (r.username == username && r.secretKey == secretKey) {
                log("Account Found")
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
                        log("Password Reset")
                        res.send({
                            'status': ''
                        })
                    }
                })
            } else {
                res.send({
                    'status': 'The Information You Entered Is Incorrect! Please Try Again!'
                })
            }
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
    }, (err, r) => {
        if (r) {
            res.send({
                'status': ''
            })
        } else {
            res.send({
                'status': 'Operation Failed'
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
            res.send(r)
        } else {
            res.send({
                'status': 'Operation Failed'
            })
        }
    })
})

app.post('/addFavorite', (req, res) => {
    username = req.query.username
    imageUrl = req.query.url

    db.collection('Users').findOneAndUpdate({
        username: username
    }, {
        $addToSet: {
            favorites: imageUrl
        }
    }, {
        new: true
    }, (err, r) => {
        if (r) {
            res.send({
                'status': ''
            })
        } else {
            res.send({
                'status': 'Operation Failed'
            })
        }
    })
})

app.post('/deleteFavorite', (req, res) => {
    username = req.query.username
    imageUrl = req.query.url

    db.collection('Users').findOneAndUpdate({
        username: username
    }, {
        $pull: {
            favorites: imageUrl
        }
    }, {
        new: true
    }, (err, r) => {
        if (r) {
            res.send({
                'status': ''
            })
        } else {
            res.send({
                'status': 'Operation Failed'
            })
        }
    })
})

app.get('/getFavorite', (req, res) => {
    username = req.query.username
    db.collection('Users').findOne({
        username: username
    }, (err, r) => {
        if (r) {
            res.send({
                'files': r.favorites
            })
        }
    })
})

app.listen(port, () => {
    console.log("Listening On Port " + port);
})