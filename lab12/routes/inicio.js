const express = require('express');

const router = express.Router();

const path = require('path');

router.use('/',(request,response,next)=>{
    response.render('inicio',{Titulo:"Inicio"});
});

module.exports = router;