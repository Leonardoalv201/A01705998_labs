const express = require('express');

const router = express.Router();

const path = require('path');

const agentes=["Sova", "Reyna"];

router.get('/nuevo-agente',(request,response,next)=>{
    response.render('nuevo-agente', {
        Titulo:"Nuevo agente"
    });
});

router.post('/nuevo-agente',(request,response,next)=>{
    agentes.push(request.body.guardar_agente);
    response.redirect('/agentes');
});

router.use('/',(request,response,next)=>{
    response.render('agentes', {
        lista_agentes: agentes,
        Titulo:"Agentes"
    });
});


module.exports = router;