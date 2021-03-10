const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const path = require('path');


app.set('view engine', 'ejs');
app.set('views', 'views');


const rutasAgentes = require('./routes/agentes');
const rutasArmas = require('./routes/armas');
const rutasInicio = require('./routes/inicio');
const rutaslab3 = require('./routes/lab1');

app.use(bodyParser.urlencoded({extended: false}));

//Para acceder a los recursos de la carpeta public
app.use(express.static(path.join(__dirname, 'public')));

app.use('/agentes', rutasAgentes);

app.use('/armas', rutasArmas);

app.use('/lab-1', rutaslab3);

app.use('/', rutasInicio);

app.use((request, response, next) => {
    response.statusCode = 404;
    response.send('<h1>No se encontro la pagina, la detonacion de la spike destruyo todo aqui</h1>'); //Manda la respuesta
});

app.listen(3000);