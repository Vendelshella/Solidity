// SPDX-License-Identifier: MIT
// El propósito de este contrato es compilar y desplegar otros contratos
pragma solidity ^0.8.18;

// importamos el contrato que queremos desplegar aquí
/* 
 * En las llaves importamos el nombre del contrato que 
 * queremos dentro del archivo SimpleStorage.sol, porque
 * es posible que dentro de ese archivo existan varios
 * contratos. Esto se llama name import.
*/
import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory{
    /*
    // Variable de tipo SimpleStorage que es un contrato definido en SimpleStorage.sol
    SimpleStorage public simpleStorage;

    // Con la siguiente función podemos desplegar el contrato SimpleStorage
    function createSimpleStorageContract() public {
        // Crea una instancia del contrato SimpleStorage que se guarda en la variable simpleStorage
        // Esta variable nos permite interactuar con el contrato SimpleStorage
        simpleStorage = new SimpleStorage();
    }
    */

    // Desplegar varias veces un contrato y guardar en un array las diferentes direcciones que se nos están generando
    // Array de tipo SimpleStorage
    SimpleStorage[] public simpleStorageContractList;

    // Con la siguiente función podemos desplegar el contrato SimpleStorage
    function createSimpleStorageContract() public {
        // Esta variable nos permite interactuar con el contrato SimpleStorage
        SimpleStorage simpleStorage = new SimpleStorage();
        // Guardamos las direcciones en el array
        simpleStorageContractList.push(simpleStorage);
    }

    // Acceder al contrato SimpleStorage e interactuar con él
    function sfStorage (uint _simpleStorageIndex, uint _simpleStorageNumber) public {
        // Para llevar a cabo esta función necesitamos dos cosas:
        // 1. Address we keep in truck in the array created before
        // 2. ABI - Application Binary Interface
        SimpleStorage mySimpleStorage = simpleStorageContractList[_simpleStorageIndex];
        mySimpleStorage.store(_simpleStorageNumber);
        // Versión corta:
        // simpleStorageContractList[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    function sfGet (uint _simpleStorageIndex) public view returns (uint) {
        SimpleStorage mySimpleStorage = simpleStorageContractList[_simpleStorageIndex];
        return mySimpleStorage.retrieve();
        // Versión corta:
        // return simpleStorageContractList[_simpleStorageIndex].retrieve();
    }

    /*
     * Please note that for this code to work, you should have a SimpleStorage contract 
     * with the functions store and retrieve defined. Additionally, you need to have an 
     * array named simpleStorageList that holds the addresses of deployed SimpleStorage 
     * contracts. The ABI (Application Binary Interface) is required for interacting with 
     * the deployed contracts.
     *
     * En resumen, el contrato SimpleStorage se utiliza como una plantilla, y las instancias
     * de este contrato se despliegan y almacenan en la matriz simpleStorageList.
     */

    /*
     * En el contrato StorageFactory que has proporcionado, la función sfStorage permite
     * almacenar números en una instancia específica de SimpleStorage seleccionada por su
     * índice en el array simpleStorageContractList. Así que, si despliegas dos contratos
     * SimpleStorage y llamas a sfStorage con diferentes índices, estarás almacenando números
     * en instancias diferentes de SimpleStorage.

     * Para ser más específico:

     * Si llamas a sfStorage con el índice 0, estarás almacenando el número en la primera
     * instancia de SimpleStorage en el array simpleStorageContractList.

     * Si llamas a sfStorage con el índice 1, estarás almacenando el número en la segunda
     * instancia de SimpleStorage en el array simpleStorageContractList.

     * Cada instancia de SimpleStorage tiene su propio estado independiente, por lo que los
     * números se guardarán de forma separada en cada instancia.
     */

}
