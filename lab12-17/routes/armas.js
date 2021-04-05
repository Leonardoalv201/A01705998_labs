const express = require('express');

const isAuth = require('../util/is-auth');

const router = express.Router();

const path = require('path');

const multer = require('multer');

const armasController = require('../controllers/armas_controller');

router.get('/nuevo-arma', isAuth, armasController.getNuevoArma);

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

router.use(multer(
    { storage: fileStorage }
    ).single('imagen_arma'));

router.post('/nuevo-arma', isAuth, armasController.postNuevoArma);

router.get('/:arma_id', isAuth, armasController.getArma);

router.use('/', isAuth, armasController.get);

module.exports = router;