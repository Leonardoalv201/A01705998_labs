exports.getLogin = (request, response, next)=>{
    response.render('login',{
        Titulo: "Login",
        isLoggedIn: request.session.isLoggedIn == true ? true : false
    });
}

exports.postLogin = (request, response, next)=>{
    request.session.isLoggedIn = true;
    request.session.usuario=request.body.usuario;

    response.redirect('/');
}

exports.logout = (request, response, next) => {
    request.session.destroy(() => {
        response.redirect('/'); //Este código se ejecuta cuando la sesión se elimina.
    });
};