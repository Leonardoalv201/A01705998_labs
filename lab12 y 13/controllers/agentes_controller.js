const Agente = require('../models/agente');

exports.getNuevoAgente = (request,response,next)=>{
    response.render('nuevo-agente', {
        Titulo:"Nuevo agente"
    });
}

exports.postNuevoAgente = (request,response,next)=>{
    const nuevo_agente=new Agente(request.body.guardar_agente, request.body.imagen_agente)
    nuevo_agente.save();

    response.setHeader('Set-Cookie', ['ultimo_agente='+ nuevo_agente.agente]);

    response.redirect('/agentes');
}

exports.get = (request,response,next)=>{
    
    console.log(request.get('Cookie').split(';')[1].trim().split('=')[1]);
    
    response.render('agentes', {
        lista_agentes: Agente.fetchAll(),
        Titulo:"Agentes"
    });
};

