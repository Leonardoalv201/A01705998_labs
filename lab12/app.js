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

//app.use('/',(request,response,next)=>{
    //response.send('<h1>Nombre: Leonardo Alvarado Menendez</h1><h3>Matricula: A01705998</h3><h3>Correo: A01705998@itesm.mx</h3><hr><ul><li><h3><a href="http://localhost:3000/texto/guardar-texto">Para ir a guardar-texto da clic aqui</a></h3></li><li><h3><a href="http://localhost:3000/nombre/guardar-nombre">Para ir a guardar-nombre da clic aqui</a></h3></li></ul><h3>Pregunta lab 11</h3>Describe el archivo package.json.<br><br> En este archivo se registran/guardan las versiones utilizadas para la elavoracion de un proyecto, gracias a esto es mas sencillo trabajar en un proyecto en equipo ya que todos contaran con las mismas versiones');
//});

app.use((request, response, next) => {
    response.statusCode = 404;
    response.send('<h1>No se encontro la pagina, la detonacion de la spike destruyo todo aqui</h1>'); //Manda la respuesta
});

app.listen(3000);