function confirmar_contrasena(){
    let p = document.getElementById("p");
    let password_conf = document.getElementById("password_conf");
    if(p.value===password_conf.value){
        let mensaje = document.getElementById("mensaje");
        mensaje.innerHTML ="Contraseña correcta";
    }
    else{
        let mensaje = document.getElementById("mensaje");
        mensaje.innerHTML ="Contraseña incorrecta";
        let boton = document.getElementById("contrasena");
        boton.innerHTML="Vuelve a intentar";
    }
}

function confirmar_compra(){
    let f1 = document.getElementById("funko1");
    let f2 = document.getElementById("funko2");
    let f3 = document.getElementById("funko3");
    const precio_f1 = 300;
    const precio_f2 = 350;
    const precio_f3 = 250;
    if (f1.value>5 || f2.value>5 || f3.value>5){
        alert ("Has excedido la cantidad en almacenamiento del funkos, vuelve a intentar")
    }
    else if(f1.value<0 || f2.value<0 || f3.value<0){
        alert ("Has escogido una cantidad invalida de funkos, vuelve a intentar")

    }
    else{
        let precio=(precio_f1*f1.value)+(precio_f2*f2.value)+(precio_f3*f3.value);
        let iva=precio*.16;
        let compra=precio+iva;
        let mensaje_precio = document.getElementById("mensaje_precio");
        mensaje_precio.innerHTML = precio;
        let mensaje_iva = document.getElementById("mensaje_iva");
        mensaje_iva.innerHTML = iva;
        let mensaje_compra = document.getElementById("mensaje_compra");
        mensaje_compra.innerHTML = compra;
    }
}

