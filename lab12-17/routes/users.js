const express = require('express');

const router = express.Router();

const path = require('path');

const usersController = require('../controllers/users_controller');

router.get('/login',usersController.getLogin);

router.post('/login',usersController.postLogin);

router.get('/logout', usersController.logout);

router.get('/register', usersController.getRegister);

router.post('/register', usersController.postRegister);

module.exports = router;