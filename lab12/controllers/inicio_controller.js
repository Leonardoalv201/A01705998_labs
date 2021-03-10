exports.use = (request,response,next)=>{
    response.render('inicio',{
        Titulo:"Inicio"}
    );
}