---

Asignatura: Facultativa de carrera I
Modulo: Administracion
Sesion 6: Fundamentos de PS
Version: Windows 10

---

# Aprende una vez, aplícalo donde sea!
Una vez que aprendes powershell, seras capaz de utilizar/administrar cualquier sistema que soporte Powershell.
A los comandos en Powershell se les conoce como *cmdlets* (pronunciado como commandlets), y es la unidad basica de funcionalidad.

Powershell, por lo general, envia objetos como resultado de sus comandos y no texto, lo que permite la flexibilidad en escenarios de programacion en tan solo unas pocas lineas de codigo. Tiene todos los elementos esenciales para que le podamos reconocer como un lenguaje de sistemas; variables, ciclos, matrices asociativas, estructuras de datos, archivos de entrada/salida. 👌

## Consultar la version de Powershell que estamos utilizando
```PS C:\> $PSVersionTable ```

## Interaccion con la consola

Una vez que hemos lanzado la consola, todo esta listo para usarse con el REPL.

``` PS C:\>"Hola Mundo" ```

## Comandos "No lo se" 🤔
Uno de los comandos principales para obtener informacion acerca del comando que no conocemos es el ```Get-Command``` en el que podemos especificar (entre varios) argumentos como ```-Verb -Noun``` en caso de que no sepamos el verbo o sustantivo de la parte del comando.

### Ejemplo 
El siguiente comando nos permitira obteber una lista de comandos que contienen en la parte del sustantivo las palabras que empiezan con **Ali** y terminan con cualquier combinacion de caracteres. 

```PS C:\>Get-Command -Noun ali* ```

De la misma manera, si no conocemos el verbo entonces lo podemos consultar por dos maneras:

1. Con el comando `Get-Command ` y especificando en el argumento `-Verb` la inicializacion/finalizacion del verbo.
2. Con el comando `Get-Verb`. Si no especificamos parametro alguno nos mostrara todos los verbos disponibles en la version que estamos trabajando.

## Obteniendo ayuda! 🙋‍♀️🙋‍♂️

Cuando hemos averiguado la forma completa como se escribe el comando no necesariamente sabemos como utilizar el comando o que hace el comando. Por ello, es necesario encontrar esa informacion que nos permita obtener el maximo de los comandos. 💡

Es entonces cuando llega el comando `Get-Help` al rescate 🚒. Este nos brinda informacion valiosa tal como la(s) sintaxis, descripcion, uso, ejemplos, entre otros. Los switches mas interesantes que podemos pasarle a este comando (aparte del comando para el cual estamos buscando ayuda) son `-Full -Detailed -Examples -Online`. 

## Objetos, objetos, objetos!
Los objetos son para Powershell lo que ustedes son para la Universidad 👩‍🎓👉🏫, la razon de existir. Los objetos pueden tener miembros (propiedades y metodos), de alli el nombre del comando que vamos a utilizar. La forma para consultar estos es por medio del comando `Get-Member`. La forma mas comun de utilizarlo es pasandole el resultado del comando para el cual queremos consultar (con el |).

#### Nota
No todos los comandos aceptan que se le pueda pasar a `Get-Member`. 🙅‍♀️

### Ejemplo

Vamos a utilizar el comando `Get-Alias`. Para conocer mas informacion acerca de el entonces le pasamos su resultado asi: 

`PS C:\>Get-Alias | Get-Member | Out-GridView`

Una de las caracteristicas de `Get-Member` es que por lo general te muestra una gran cantidad de resultados, por tal razon en la linea de comando anterior hacemos uso de un comando de salida para que los resultados se presenten en una tabla con formato en una vista de cuadricula.

## Las variables y los tipos de datos

El tipo de almacenamiento de informacion elemental que hemos tratado hasta ahora ha sido la variable. Pero como nos aseguramos que la informacion que se guarda en las variables es la correcta? ❓
Cuando definimos una variable y la inicializamos con un valor podemos entonces verificar el tipo de dato que se ha elegido, esto lo hacemos de la siguiente manera:

```
PS C:\>$a=2.1
PS C:\>$a.GetType().Name
```
El ejemplo anterior nos mostrara el tipo de dato que guarda la variable *a*. Si queremos hacer una pre validacion acerca del tipo de dato que vamos a guardar en una variable podemos realizar una operacion booleana (la cual evaluara a verdadero o falso) 👏:

`PS C:\>2.1 -is [int]` 


