const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const path = require('path');

var cookieParser = require ('cookie-parser');

const session = require('express-session');

//proteccion a clonacion de la pagina web para extraccion de datos
const csrf = require('csurf');
const csrfProtection = csrf();

app.set('view engine', 'ejs');
app.set('views', 'views');


const rutasAgentes = require('./routes/agentes');
const rutasArmas = require('./routes/armas');
const rutaslab3 = require('./routes/lab1');
const rutasUsers = require('./routes/users');
const rutasInicio = require('./routes/inicio');

//Acceder a los datos de las formas
app.use(bodyParser.urlencoded({extended: false}));
//Acceder a los datos de las cookies
app.use(cookieParser());
//Trabajar con sesiones
app.use(session({
    secret: 'Secretosecretoso', 
    resave: false, //La sesión no se guardará en cada petición, sino sólo se guardará si algo cambió 
    saveUninitialized: false, //Asegura que no se guarde una sesión para una petición que no lo necesita
}));


//Para acceder a los recursos de la carpeta public
app.use(express.static(path.join(__dirname, 'public')));

app.use(csrfProtection); 

app.use('/agentes', rutasAgentes);

app.use('/armas', rutasArmas);

app.use('/lab-1', rutaslab3);

app.use('/users', rutasUsers);

app.get('/', rutasInicio);

app.use((request, response, next) => {
    response.statusCode = 404;
    response.send('<h1>No se encontro la pagina, la detonacion de la spike destruyo todo aqui</h1>'); //Manda la respuesta
});

app.listen(3000);