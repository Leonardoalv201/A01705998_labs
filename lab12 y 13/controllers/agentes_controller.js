const Agente = require('../models/agente');

exports.getNuevoAgente = (request,response,next)=>{
    response.render('nuevo-agente', {
        Titulo:"Nuevo agente"
    });
}

exports.postNuevoAgente = (request,response,next)=>{
    const nuevo_agente=new Agente(request.body.guardar_agente)
    nuevo_agente.save();
    response.redirect('/agentes');
}

exports.get = (request,response,next)=>{
    response.render('agentes', {
        lista_agentes: Agente.fetchAll(),
        Titulo:"Agentes"
    });
};

