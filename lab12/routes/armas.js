const express = require('express');

const router = express.Router();

const path = require('path');

const armas=["Operator", "Vandal"];

router.get('/nuevo-arma',(request,response,next)=>{
    response.send('<h1>Guarda el arma</h1><hr><form action="nuevo-arma" method="POST"><input type="text" name="guardar_arma"><input type="submit" value="Guardar arma"></form>');

});

router.post('/nuevo-arma',(request,response,next)=>{
    armas.push(request.body.guardar_arma);
    response.redirect('/armas');
});

router.use('/',(request,response,next)=>{
    response.render('armas', {
        lista_armas: armas,
        Titulo:"Armas"
    });
});


module.exports = router;