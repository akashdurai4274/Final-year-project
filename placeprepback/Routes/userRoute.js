const router = require('express').Router();
const userController = require('../Controllers/userController');
const path = require('path');
router.post('/registration', userController.register);
router.post('/login', userController.login);

router.get('/oops/classobj', (req, res, next) => {
    res.sendFile(path.join(__dirname, '../', 'Tasks', 'oops', 'class&object.json'));
});

router.get('/oops/in', (req, res, next) => {
    res.sendFile(path.join(__dirname, '../', 'Tasks', 'oops', 'inheritance.json'));
});


router.get('/oops/classobj/coding', (req, res, next) => {
    res.sendFile(path.join(__dirname, '../', 'Tasks', 'oops', 'codingtask.json'));
});

module.exports = router;