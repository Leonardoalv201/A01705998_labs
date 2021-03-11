const Agente = require('../models/agente');

exports.getNuevoAgente = (request,response,next)=>{
    response.render('nuevo-agente', {
        Titulo:"Nuevo agente",
        isLoggedIn: request.session.isLoggedIn == true ? true : false
    });
}

exports.postNuevoAgente = (request,response,next)=>{
    const nuevo_agente=new Agente(request.body.guardar_agente, request.body.imagen_agente)
    nuevo_agente.save();

    response.setHeader('Set-Cookie', ['ultimo_agente='+ nuevo_agente.agente + '; HttpOnly']);

    response.redirect('/agentes');
}

exports.get = (request,response,next)=>{
    
    console.log(request.cookies);
    console.log(request.cookies.ultimo_agente);
    
    response.render('agentes', {
        lista_agentes: Agente.fetchAll(),
        Titulo:"Agentes",
        isLoggedIn: request.session.isLoggedIn == true ? true : false
    });
};

