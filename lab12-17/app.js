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
app.use(bodyParser.json());

const multer = require('multer');

//fileStorage: Es nuestra constante de configuración para manejar el almacenamiento
const fileStorage = multer.diskStorage({
    destination: (request, file, callback) => {
        //'uploads': Es el directorio del servidor donde se subirán los archivos 
        callback(null, 'uploads');
    },
    filename: (request, file, callback) => {
        //aquí configuramos el nombre que queremos que tenga el archivo en el servidor, 
        //para que no haya problema si se suben 2 archivos con el mismo nombre concatenamos el timestamp
        callback(null, new Date().toISOString().replace(/:/g, '-') + '-' + file.originalname);
    },
});

//En el registro, pasamos la constante de configuración y
//usamos single porque es un sólo archivo el que vamos a subir, 
//pero hay diferentes opciones si se quieren subir varios archivos. 
//'archivo' es el nombre del input tipo file de la forma

app.use(multer(
    { storage: fileStorage }
    ).single('imagen_agente')); 

//app.use(multer(
    //{ storage: fileStorage }
    //).single('imagen_arma')); 

//Para acceder a los recursos de la carpeta public
app.use(express.static(path.join(__dirname, 'public')));

//Para acceder a los recursos de la carpeta uploades
app.use(express.static(path.join(__dirname, 'uploads')));

//Acceder a los datos de las cookies
app.use(cookieParser());

//Trabajar con sesiones
app.use(session({
    secret: 'Secretosecretoso', 
    resave: false, //La sesión no se guardará en cada petición, sino sólo se guardará si algo cambió 
    saveUninitialized: false, //Asegura que no se guarde una sesión para una petición que no lo necesita
}));

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