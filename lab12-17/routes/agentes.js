const express = require('express');

const isAuth = require('../util/is-auth');

const router = express.Router();

const path = require('path');

const agentesController = require('../controllers/agentes_controller');

router.get('/nuevo-agente', isAuth, agentesController.getNuevoAgente);

router.post('/nuevo-agente', isAuth, agentesController.postNuevoAgente);

router.get('/:agente_id', isAuth, agentesController.getAgente);

router.get('/', isAuth, agentesController.get);

module.exports = router;