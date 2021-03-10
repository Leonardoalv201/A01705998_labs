const express = require('express');

const router = express.Router();

const path = require('path');

const armasController = require('../controllers/armas_controller');

router.get('/nuevo-arma', armasController.getNuevoArma);

router.post('/nuevo-arma',armasController.postNuevoArma);

router.use('/',armasController.get);


module.exports = router;