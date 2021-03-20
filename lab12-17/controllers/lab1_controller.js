exports.use = (request,response,next)=>{
    response.render('lab1',{
        Titulo:"Lab 3",
        isLoggedIn: request.session.isLoggedIn == true ? true : false
    }
    );
}