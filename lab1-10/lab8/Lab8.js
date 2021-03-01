function promedio(arreglo = []){
    let prom=0;
    let n=arreglo.length;
    for (let i=0;i<n;i++){
        prom += arreglo[i];
    }
    return prom/n;
}

function texto(mens){
    let filesystem = require('fs');
    filesystem.writeFileSync('mensaje.txt',mens)
}

function fibo(n){
    let fibo_dos_anterior=1;
    let fibo_previo=1;
    if (n==1 || n==2){
        return 1;
    }
    else{
        let fibo_actual;
        for (let i=2 ; i < n ; i++){
            fibo_actual=fibo_dos_anterior+fibo_previo;
            fibo_dos_anterior=fibo_previo;
            fibo_previo=fibo_actual;
        }
        return fibo_actual;
    }
}

const http = require('http');
const server=http.createServer((request, response) => {
    let proms = [2,4,3,12,45,64];
    let prom=promedio(proms);
    console.log(prom);
    let script = "wenas wenas";
    //texto(script);
    let n_esimo_fibo=11;
    console.log(fibo(n_esimo_fibo));
    response.write('prom');
    response.end();
});


server.listen(3000);