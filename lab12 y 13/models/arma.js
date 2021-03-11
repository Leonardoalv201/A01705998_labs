const armas=[{arma: "Operator", imagen: "https://codigoesports.com/wp-content/uploads/2020/07/operator.jpg"},
 {arma: "Vandal", imagen: "https://esports.eldesmarque.com/wp-content/uploads/2020/04/EWntW8BWsAE_Gpx.jpg"}];

module.exports = class Arma {

    //Constructor de la clase. Sirve para crear un nuevo objeto, y en él se definen las propiedades del modelo
    constructor(arma, imagen) {
        this.arma = arma;
        this.imagen=imagen;
    }

    //Este método servirá para guardar de manera persistente el nuevo objeto. 
    save() {
        armas.push(this)
    }

    //Este método servirá para devolver los objetos del almacenamiento persistente.
    static fetchAll() {
        return armas;
    }

}