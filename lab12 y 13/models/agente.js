const agentes=["Sova", "Reyna"];

module.exports = class Agente {

    //Constructor de la clase. Sirve para crear un nuevo objeto, y en él se definen las propiedades del modelo
    constructor(agente) {
        this.agente = agente;
    }

    //Este método servirá para guardar de manera persistente el nuevo objeto. 
    save() {
        agentes.push(this.agente)
    }

    //Este método servirá para devolver los objetos del almacenamiento persistente.
    static fetchAll() {
        return agentes;
    }

}