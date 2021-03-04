const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const path = require('path');


app.set('view engine', 'ejs');
app.set('views', 'views');


const rutasAgentes = require('./routes/agentes');
const rutasArmas = require('./routes/armas');

app.use(bodyParser.urlencoded({extended: false}));

//Para acceder a los recursos de la carpeta public
app.use(express.static(path.join(__dirname, 'public')));

app.use('/agentes', rutasAgentes);

app.use('/armas', rutasArmas);

app.get('/', (request, response, next) => {
    response.sendFile(path.join(__dirname, 'views', 'inicio.html'));
});

app.get('/lab-3', (request, response, next) => {
    response.sendFile(path.join(__dirname, 'views', 'Lab1.html'));
});

app.use((request, response, next) => {
    response.statusCode = 404;
    response.send('<h1>No se encontro la pagina, la detonacion de la spike destruyo todo aqui</h1>'); //Manda la respuesta
});

app.listen(3000);