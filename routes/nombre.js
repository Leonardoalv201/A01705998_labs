const express = require('express');

const router = express.Router();

const nombres=[];

router.get('/guardar-nombre',(request,response,next)=>{
    response.send('<h1>Guarda tu nombre</h1><hr><form action="guardar-nombre" method="POST"><input type="text" name="guardar_nombre"><input type="submit" value="Guardar nombre"></form>');
});

router.post('/guardar-nombre',(request,response,next)=>{
    nombres.push(request.body.guardar_nombre);
    response.redirect('/nombre');
});

router.use('/',(request,response,next)=>{
    let html = '<h1>Nombres</h1><ul>'; 
    for (let nombre of nombres) {
        html = html + '<li>' + nombre + '</li>';
    }
    html = html + '<li><h3><a href="http://localhost:3000/">Para ir al inicio da clic aqui</a></h3></li></ul>'
    response.send(html); 
});


module.exports = router;