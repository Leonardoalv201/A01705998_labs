var bandera=0;

const requestHandler = (request, response) => {

    

    if(request.url==="/"){
        response.setHeader('Content-Tyoe','text/html');
        response.write("<html>");
        response.write('<head><meta charset="UTF-8"><title>Inicio</title></head>');
        response.write("<body><header><h1>Nombre: Leonardo Alvarado Menendez</h1><h3>Matricula: A01705998</h3><h3>Correo: A01705998@itesm.mx</h3><hr></header>");
        response.write('<main><ul><li><h3><a href="http://localhost:3000/agrega-texto">agrega-texto</a></li></h3>');
        response.write('<li><h3><a href="http://localhost:3000/texto-guardado">texto-guardado</a></h3></li></ul>');
        response.write("</main>");
        response.write("</html>");
        response.end();
    }else if(request.url==="/texto-guardado"){
        response.setHeader('Content-Tyoe','text/html');
        response.write("<html>");
        response.write('<head><meta charset="UTF-8"><title>Texto</title></head>');
        if (bandera===0){
            response.write("<body><header><h1>Aun no se ha guardado ningun texto</h1></header>");
            response.write('<ul><li><h3><a href="http://localhost:3000/agrega-texto">Para ir a guardar-texto da clic aqui</a></h3></li>');
            response.write('<li><h3><a href="http://localhost:3000/">Para ir al inicio da clic aqui</a></h3></li></ul>');
        }
        else{
            response.write("<body><header><h1>El texto se guardo con exito</h1></header>");
            response.write('<ul><li><h3><a href="http://localhost:3000/">Para ir al inicio da clic aqui</a></h3></li></ul>');
        }
        response.write('<main>');
        response.write("</main>");
        response.write("</html>");
        response.end();
    }else if(request.url==="/agrega-texto" && request.method === "POST"){
        const texto=[];
        request.on('data',(datos)=>{
            texto.push(datos);
        })
        return request.on('end', ()=>{
            bandera=1;
            const texto_completo=Buffer.concat(texto).toString();
            var nuevo_texto =texto_completo.split('=')[1];
            var txt = nuevo_texto.replace(/[+]/gi, ' ');
            response.statusCode = 302;
            response.setHeader('Location', '/texto-guardado');
            let filesystem = require('fs');
            filesystem.writeFileSync('mensaje.txt',txt);
            return response.end();
        });
        
    }else if(request.url==="/agrega-texto" && request.method === "GET"){
        response.setHeader('Content-Tyoe','text/html');
        response.write("<html>");
        response.write('<head><meta charset="UTF-8"><title>Texto</title></head>');
        response.write("<body><header><h1>Guarda un texto</h1></header>");
        response.write('<main><form action="agrega-texto" method="POST"><input type="text" name="texto_guardar"><input type="submit" value="Guardar texto"></form>');
        response.write('<a href="http://localhost:3000/">Para ir al inicio da clic aqui</a>');
        response.write("</main>");
        response.write("</body>");
        response.write("</html>");
        response.end();
    }else{
        response.statusCode=404;
        response.setHeader('Content-Tyoe','text/html');
        response.write("<html>");
        response.write("<head><title>Page not found</title></head>");
        response.write("<body><header><h1>Page not found</h1></header>");
        response.write("</body>");
        response.write("</html>");
        response.end();
    }

}

module.exports = requestHandler;