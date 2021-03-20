exports.use = (request,response,next)=>{
    response.render('inicio',{
        Titulo:"Inicio",
        isLoggedIn: request.session.isLoggedIn == true ? true : false
    }
    );
}