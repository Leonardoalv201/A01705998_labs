const Arma = require('../models/arma');

exports.getNuevoArma = (request,response,next)=>{
    response.render('nuevo-arma', {
        Titulo:"Nueva arma",
        isLoggedIn: request.session.isLoggedIn == true ? true : false
    });
}

exports.postNuevoArma = (request,response,next)=>{
    const nuevo_arma=new Arma(request.body.guardar_arma, request.body.imagen_arma)
    nuevo_arma.save()
        .then(() => {
            response.setHeader('Set-Cookie', ['ultima_arma='+ nuevo_arma.arma + '; HttpOnly']);

            response.redirect('/armas');
        })
        .catch(err => console.log(err));

    
}

exports.get = (request,response,next)=>{

    console.log(request.cookies);
    console.log(request.cookies.ultima_arma);


    Arma.fetchAll()
        .then(([rows, fieldData]) => {
            const armas = [];
            for (let arm of rows){
                armas.push({
                    arma: arm.nombre_arma,
                    imagen: arm.imagen_arma
                });
            }
            console.log(armas);
            response.render('armas', {
                lista_armas: armas,
                Titulo:"Armas",
                isLoggedIn: request.session.isLoggedIn == true ? true : false
            });
        })
        .catch(err => {
            console.log(err);
        });

    
}


exports.getArma = (request,response,next)=>{

    const id = request.params.arma_id;
    Arma.fetchOne(id)
        .then(([rows, fieldData]) => {
            const armas = [];
            for (let arm of rows){
                armas.push({
                    arma: arm.nombre_arma,
                    imagen: arm.imagen_arma
                });
            }
            console.log(armas);
            response.render('armas', {
                lista_armas: armas,
                Titulo:"Armas",
                isLoggedIn: request.session.isLoggedIn == true ? true : false
            });
        })
        .catch(err => {
            console.log(err);
        });

    
}