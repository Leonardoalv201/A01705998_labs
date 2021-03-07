const express = require('express');

const router = express.Router();

const path = require('path');

router.use('/',(request,response,next)=>{
    response.render('lab1',{Titulo:"Lab 3"});
});

module.exports = router;