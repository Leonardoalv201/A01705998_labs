const express = require('express');

const router = express.Router();

router.get('/guardar-texto',(request,response,next)=>{
    response.send('<h1>Guarda tu texto</h1><hr><form action="guardar-texto" method="POST"><input type="text" name="texto_guardar"><input type="submit" value="Guardar texto"></form>');
});

router.post('/guardar-texto',(request,response,next)=>{
    let filesystem = require('fs');
    filesystem.writeFileSync('mensaje.txt',request.body.texto_guardar);
    response.redirect('/texto');
});

router.get('/',(request,response,next)=>{
    let html=request.body.texto_guardar;
    //console.log(html);
    response.send('<h1>Texto guardado</h1><hr><ul><li><h3><a href="http://localhost:3000/">Para ir al inicio da clic aqui</a></h3></li></ul>' + html);
});

module.exports = router;