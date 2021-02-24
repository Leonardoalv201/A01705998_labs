let numero=prompt("Dame un numero y te mostrate los cuadrados y cubos del 1 hasta este numero", "Ingresa el numero aqui")
document.write("Problema 1 <br>")
for (let i = 1; i <= numero; i++){
    document.write(i +" " + i*i+ " " + i*i*i + "<br>")
}
document.write("<br>")

document.write("Problema 2 <br>")
const n=Math.floor(Math.random() * 10)
const m=Math.floor(Math.random() * 10)
var d = new Date();
var t1 = d.getTime();
const resultado=prompt("¿cuanto es " + n + " + " + m + "?", "Ingresa tu respuesta")
var d = new Date();
var t2 = d.getTime();
var t_total=(t2-t1) / 1000;
if (resultado == n+m){
    document.write("Correcto, "+ n + " + " + m + "=" + resultado + "<br>")
    document.write("Tardaste " + t_total + "s en responder <br>")
}
else{
    document.write("Incorrecto, "+ n + " + " + m + "=" + resultado + "<br>")
    document.write("Tardaste " + t_total + "s en responder <br>")
}
document.write("<br>")

function problema_3(){
    var f=prompt("Tamaño del arreglo");
    let titulo_prob_3 = document.getElementById("T_Prob3")
    titulo_prob_3.innerHTML="Problema 3 <br>"
    alert("solo podras ingresar" + f + " numeros")
    var numeros = [];
    var positivos=0;
    var negativos=0;
    var ceros=0;
    var h=1;
    for (let i = 0; i < f; i++) {
        var x = prompt("Ingresa tu " + h +"° numero:");
        numeros[i] = x;
        if(numeros[i]>0){
            positivos++;
        }
        else if(numeros[i]==0){
            ceros++;
        }
        else{
            negativos++;
        }
        h++;
    }
    let res_prob_3 = document.getElementById("Res_Prob3")
    res_prob_3.innerHTML="Hay " + positivos + " numeros positivos <br>" + "Hay " + negativos + " numeros negativos <br>" + "Hay " + ceros + " numeros ceros <br><br>" 
}

function problema_4(){
    var numero_de_promedios = prompt("Cuantos promedios quieres obtener (En consola se motraran las matrices)");
    var numero_de_datos = prompt("Datos por promedio")
    var matriz = []

    for(let r=0; r<numero_de_datos; r++){
        var prom_ind = [];

        for (let i = 0; i < numero_de_promedios; i++){
            var datos =  Math.round(Math.random() * (100 - 50) + 50);
            prom_ind.push(datos);
        }
        console.log(prom_ind)

        matriz.push(prom_ind);
    }

    for (var i = 1; i <= numero_de_datos; i++){
        var suma = 0;
        for (var j = 0; j < matriz[i-1].length; j++){

            var d = matriz[i-1][j];
            suma += d;
        }
        suma = suma / numero_de_promedios;
        alert("El " + i + "° promedio es = " + suma + "\n");
        console.log(matriz);
    }
}

function problema_5(){
    let titulo_prob_5 = document.getElementById("T_Prob5")
    titulo_prob_5.innerHTML="Problema 5 <br>"
    var problema5=prompt("Inserta un numero y lo regresare con sus digitos invertidos");
    var i=1;
    var num_digitos=0;
    var digitos=[];
    while(i > 0){
        i=Math.floor(problema5/10);
        digitos[num_digitos]=(problema5 - i*10);
        problema5=i;
        num_digitos++;
    }
    var invertido=0;
    var q=0;
    for(let t=num_digitos-1; t>=0; t--){
        invertido=invertido + digitos[t]*10**q;
        q++;
    }
    let res_prob_5 = document.getElementById("Res_Prob5")
    res_prob_5.innerHTML=invertido 
}




