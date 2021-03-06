const Agente = require('../models/agente');

exports.getNuevoAgente = (request,response,next)=>{
    
    response.render('nuevo-agente', {
        Titulo:"Nuevo agente",
        csrfToken: request.csrfToken(),
        isLoggedIn: request.session.isLoggedIn == true ? true : false
    });
}

exports.postNuevoAgente = (request,response,next)=>{
    const image=request.file;
    if(!image){
        console.error('Error al subir la imagen');
        return response.status(422).redirect('/');
    }
    const nuevo_agente=new Agente(request.body.guardar_agente, image.filename)
    nuevo_agente.save()
        .then(() => {
            response.setHeader('Set-Cookie', ['ultimo_agente='+ nuevo_agente.agente + '; HttpOnly']);

            response.redirect('/agentes');
        })
        .catch(err => console.log(err));

    
}

exports.getAgente= (request,response,next)=>{

    const id = request.params.agente_id;
    Agente.fetchOne(id)
        .then(([rows, fieldData]) => {
            const agentes = [];
            for (let agent of rows){
                agentes.push({
                    agente: agent.nombre,
                    imagen: agent.imagen
                });
            }
            console.log(agentes);
            response.render('agentes', {
                lista_agentes: agentes,
                Titulo:"Agentes",
                isLoggedIn: request.session.isLoggedIn == true ? true : false
            });
        })
        .catch(err => {
            console.log(err);
        });
}

exports.postBuscar=(request,response,next)=>{
    console.log(request.body);
    const name = request.body.valor_busqueda;
    Agente.fetchByName(name)
        .then(([rows, fieldData]) => {
            response.status(200).json(rows);   
        })
        .catch(err => {
            console.log(err);
        });
}

exports.get = (request,response,next)=>{
    
    console.log(request.cookies);
    console.log(request.cookies.ultimo_agente);
    
    Agente.fetchAll()
        .then(([rows, fieldData]) => {
            const agentes = [];
            for (let agent of rows){
                agentes.push({
                    agente: agent.nombre,
                    imagen: agent.imagen
                });
            }
            console.log(agentes);
            response.render('agentes', {
                lista_agentes: agentes,
                Titulo:"Agentes",
                csrfToken: request.csrfToken(),
                isLoggedIn: request.session.isLoggedIn == true ? true : false
            });
        })
        .catch(err => {
            console.log(err);
        });
};


