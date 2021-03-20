const express = require('express');

const router = express.Router();

const path = require('path');

const agentesController = require('../controllers/agentes_controller');

router.get('/nuevo-agente',agentesController.getNuevoAgente);

router.post('/nuevo-agente',agentesController.postNuevoAgente);

router.get('/:agente_id', agentesController.getAgente);

router.get('/',agentesController.get);

module.exports = router;