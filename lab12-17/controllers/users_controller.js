const User = require('../models/user');
const bcrypt = require('bcryptjs');

exports.getLogin = (request, response, next)=>{
        response.render('login',{
            Titulo: "Login",
            error: request.session.error,
            isLoggedIn: request.session.isLoggedIn == true ? true : false
        });
    }

exports.postLogin = (request, response, next)=>{
    request.session.error = "";
    const username = request.body.usuario;
    User.fetchOne(username)
        .then(([rows, fieldData]) => {
            if(rows.length < 1){
                request.session.error = "El usurio y/o la contraseña no coinciden";
                response.redirect('/users/login');
            }else{
                bcrypt.compare(request.body.password, rows[0].password)
                    .then(doMatch => {
                        if (doMatch) {
                            request.session.isLoggedIn = true;
                            request.session.usuario=request.body.usuario;
                            return request.session.save(err => {
                                response.redirect('/');
                            });
                        }
                        request.session.error = "El usurio y/o la contraseña no coinciden";
                        response.redirect('/users/login');
                    }).catch(err => {
                        request.session.error = "El usurio y/o la contraseña no coinciden";
                        response.redirect('/users/login');
                    });
            }
        })
        .catch(err => {
            console.log(err);
        });

}

exports.logout = (request, response, next) => {
    request.session.destroy((err) => {
        console.log(err);
        console.log('Logout');
        response.redirect('/'); //Este código se ejecuta cuando la sesión se elimina.
    });
};


exports.getRegister = (request, response, next)=>{
    response.render('register',{
        Titulo: "Registro",
        isLoggedIn: request.session.isLoggedIn == true ? true : false
    });
}


exports.postRegister = (request,response,next)=>{
    const nuevo_usuario=new User(request.body.nombre, request.body.username, request.body.password)
    nuevo_usuario.save()
        .then(() => {
            request.session.isLoggedIn = true;
            request.session.usuario=request.body.usuario;
            response.redirect('/');
        })
        .catch(err => console.log(err));

    
}