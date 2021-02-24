console.log("wenas wenas");
console.log("c ñoras");

const express = require('express');
const bodyParser = require('body-parser');
const app = express();

//Middleware
app.use(bodyParser.urlencoded({extended: false}));

app.use((request, response, next) => {
    console.log('Middleware!');
    next(); //Le permite a la petición avanzar hacia el siguiente middleware
});

app.use('/personajes', (request, response, next) => {
    response.send('Respuesta de la ruta "/ruta"'); 
});

app.use((request, response, next) => {
    console.log('Otro middleware!');
    response.send('¡Hola mundo!'); //Manda la respuesta
});

app.listen(3000);