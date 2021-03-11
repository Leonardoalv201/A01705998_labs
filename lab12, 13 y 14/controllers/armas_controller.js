const Arma = require('../models/arma');

exports.getNuevoArma = (request,response,next)=>{
    response.render('nuevo-arma', {
        Titulo:"Nueva arma",
        isLoggedIn: request.session.isLoggedIn == true ? true : false
    });
}

exports.postNuevoArma = (request,response,next)=>{
    const nuevo_arma=new Arma(request.body.guardar_arma, request.body.imagen_arma)
    nuevo_arma.save();

    response.setHeader('Set-Cookie', ['ultima_arma='+ nuevo_arma.arma + '; HttpOnly']);

    response.redirect('/armas');
}

exports.get = (request,response,next)=>{

    console.log(request.cookies);
    console.log(request.cookies.ultima_arma);

    response.render('armas', {
        lista_armas: Arma.fetchAll(),
        Titulo:"Armas",
        isLoggedIn: request.session.isLoggedIn == true ? true : false
    });
}