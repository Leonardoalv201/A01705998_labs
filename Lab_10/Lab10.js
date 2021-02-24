const http = require('http');
const server=http.createServer((request, response) => {
    if(request.url==="/"){
        response.setHeader('Content-Tyoe','text/html');
        response.write("<html>");
        response.write('<head><meta charset="UTF-8"><title>Inicio</title></head>');
        response.write("<body><header><h1>Nombre: Leonardo Alvarado Menendez</h1><h3>Matricula: A01705998</h3><h3>Correo: A01705998@itesm.mx</h3><hr></header>");
        response.write("</html>");
        response.end();
    }else if(request.url==="/============"){
        response.setHeader('Content-Tyoe','text/html');
        response.write("<html>");
        response.write('<head><meta charset="UTF-8"><title>Texto</title></head>');
        response.write("<body><header><h1>============</h1></header>");
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
            const texto_completo=Buffer.concat(texto).toString();
            var nuevo_texto =texto_completo.split('=')[1];
            //var nuevo_texto =nuevo_texto.split('+')[1];
            let filesystem = require('fs');
            filesystem.writeFileSync('mensaje.txt',nuevo_texto)
            return response.end();
        })
        
    }else if(request.url==="/agrega-texto" && request.method === "GET"){
        response.setHeader('Content-Tyoe','text/html');
        response.write("<html>");
        response.write('<head><meta charset="UTF-8"><title>Texto</title></head>');
        response.write("<body><header><h1>Guarda un texto</h1></header>");
        response.write('<main><form action="agrega-texto" method="POST"><input type="text" name="texto_guardar"><input type="submit" value="Guardar texto"></form>');
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

});

server.listen(3000);