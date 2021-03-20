const express = require('express');

const router = express.Router();

const path = require('path');

const usersController = require('../controllers/users_controller');

router.get('/login',usersController.getLogin);

router.post('/login',usersController.postLogin);

router.get('/logout', usersController.logout);

module.exports = router;