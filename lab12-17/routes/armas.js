const express = require('express');

const isAuth = require('../util/is-auth');

const router = express.Router();

const path = require('path');

const armasController = require('../controllers/armas_controller');

router.get('/nuevo-arma', isAuth, armasController.getNuevoArma);

router.post('/nuevo-arma', isAuth, armasController.postNuevoArma);

router.get('/:arma_id', isAuth, armasController.getArma);

router.use('/', isAuth, armasController.get);

module.exports = router;