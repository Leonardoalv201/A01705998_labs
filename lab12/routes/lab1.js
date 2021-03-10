const express = require('express');

const router = express.Router();

const path = require('path');

const lab1Controller = require('../controllers/lab1_controller');

router.use('/',lab1Controller.use);

module.exports = router;