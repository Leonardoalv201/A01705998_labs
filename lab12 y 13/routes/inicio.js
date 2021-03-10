const express = require('express');

const router = express.Router();

const path = require('path');

const inicioController = require('../controllers/inicio_controller');

router.use('/',inicioController.use);

module.exports = router;