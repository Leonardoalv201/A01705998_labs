const express = require('express');

const router = express.Router();

const path = require('path');

const agentes=["Sova", "Reyna"];

router.get('/nuevo-agente',(request,response,next)=>{
    response.send('<h1>Guarda el agente</h1><hr><form action="nuevo-agente" method="POST"><input type="text" name="guardar_agente"><input type="submit" value="Guardar agente"></form>');

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