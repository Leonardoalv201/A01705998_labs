const Arma = require('../models/arma');

exports.getNuevoArma = (request,response,next)=>{
    response.render('nuevo-arma', {
        Titulo:"Nueva arma"
    });
}

exports.postNuevoArma = (request,response,next)=>{
    const nuevo_arma=new Arma(request.body.guardar_arma, request.body.imagen_arma)
    nuevo_arma.save();
    response.redirect('/armas');
}

exports.get = (request,response,next)=>{
    response.render('armas', {
        lista_armas: Arma.fetchAll(),
        Titulo:"Armas"
    });
}