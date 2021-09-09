const express = require('express')
const mongoose = require('mongoose')

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

app.get('/walls', (req, res) => {
    var start = req.query.start
    var end = req.query.end

    var files = [];

    for (let index = start; index <= end; index++) {
        files.push('/Pictures/wallpapers/' + index + '.jpg')
    }

    res.send({
        'status': "",
        'files': files
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
        secretKey: req.query.secretKey,
    })
    db.collection('Users').findOne({
        username: newUser.username
    }, (err, r) => {
        if (r) {
            if (r.username == newUser.username) {
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

app.put('/resetPassword', (req, res) => {
    username = req.query.username
    password = req.query.password
    secretKey = req.query.secretKey

    db.collection('Users').findOne({
        username: username
    }, (err, r) => {
        if (r) {
            if (r.username == username && r.secretKey == secretKey) {
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
            } else {
                res.send({
                    'status': 'The Information You Entered Is Incorrect! Please Try Again!'
                })
            }
        }
    })
})

app.put('/profile', (req, res) => {
    fullname = req.query.fullname
    username = req.query.username
    oldUsername = req.query.oldUsername

    db.collection('Users').findOneAndUpdate({
        username: oldUsername
    }, {
        $set: {
            fullname: fullname,
            username: username,
        }
    }, {
        new: true
    }, (err, r) => {
        if (r) {
            log(r)
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

app.put('/addFavorite', (req, res) => {
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

app.put('/deleteFavorite', (req, res) => {
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
                'status': '',
                'files': r.favorites
            })
        }
    })
})

app.delete('/deleteAccount', (req, res) => {
    username = req.query.username
    db.collection('Users').findOneAndDelete({
        username: username
    }, (err, r) => {
        if (r.value != null) {
            res.send({
                'status': ''
            })
        } else {
            res.send({
                'status': 'Account Deletion Failed'
            })
        }
    })
})

app.listen(port, () => {
    console.log("Listening On Port " + port);
})