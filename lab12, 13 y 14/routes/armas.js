const express = require('express');

const router = express.Router();

const path = require('path');

const armasController = require('../controllers/armas_controller');

router.get('/nuevo-arma', armasController.getNuevoArma);

router.post('/nuevo-arma',armasController.postNuevoArma);

router.get('/:arma_id', armasController.getArma);

router.use('/',armasController.get);


module.exports = router;