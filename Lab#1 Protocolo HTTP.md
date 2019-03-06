---

Guia de Laboratorio #1: Protocolo de aplicacion HTTP
Asignatura: Administracion de Redes

---

# Introduccion
En este laboratorio vamos a inspeccionar el funcionamiento del protocolo HTTP, los comandos mas comunes, los aspectos, los formatos de mensajes. 

Como hemos estado estudiando, el protocolo de comunicacion utilizado por los servidores y clientes de la web es HTTP. Asi, un usuario especifica una URL en el navegador (o a traves de un link), este entonces resuelve el nombre de dominio a la direccion IP (como se llama este servicio? 🤔..mmm si, sistemas de nombres de dominio o DNS), abre la conexion, y envia una "peticion" HTTP GET al servidor, especificando la pagina que desea obtener. Tal solicitud sera respondida por el servidor con un HTTP OK y la pagina web. El navegador se encarga de renderizarla utilizando el protocolo HTML.

# Materiales requeridos

* Equipo donde se ejecutara el protocolo a inspeccionar
* Equipo (con Wireshark instalado) donde se analizaran los protocolos/paquetes.



# Procedimientos
A continuacion se detallan los procedimientos/ejercicios que se van a desarrollar durante el laboratorio.

## Preparacion del escenario

Para llevar a cabo el laboratorio vamos a necesitar dos equipos que puedan comunicarse entre si. Un equipo (perteneciente al cuarto de laboratorio) donde se ejecutara el protocolo HTTP y el equipo (del grupo que desarrollara el lab) donde se capturara e inspeccionara los paquetes que genere el protocolo de estudio. Este ultimo lo conectaremos a la red local del lab donde le configuraremos (manualmente) una direccion IP y mascara de subred de acuerdo a las definiciones. Una vez que hayamos terminado con esto, entonces haremos una prueba simple de conectividad hacia el otro host. Teniendo un resultado positivo en este paso podemos pasar al siguiente procedimiento.

## 1. Los mensajes HTTP

Vamos a continuar el laboratorio con la exploracion de los protocolos HTTP y HTML, protocolos de aplicacion. Para lograrlo vamos a realizar los siguientes pasos:

1. Abrimos el navegador donde vamos a hacer la peticion.
2. En el otro equipo iniciamos Wireshark, esperamos que cargue las interfaces disponibles, finalmente elegimos la tarjeta de red para la cual queremos capturar los paquetes.
3. Nos vamos al navegador y escribimos la URL http://netlab.eastus2.cloudapp.azure.com/lab1.1 (ya sabemos que podriamos haber escrito sin `http://` y funcionaria 😁, pero no es el objetivo del lab 👈).
4. Detenemos la captura en el equipo con Wireshark (presionando el boton rojo 🛑).

Deberiamos ver la lista de paquetes capturados y aunque solo hemos realizado una pequeña consulta se han generado una cantidad de paquetes (por servicios que trabajan de manera transparente) considerable. Como queremos observar/analizar un protocolo en particular entonces vamos a filtrar de modo que nos quede unicamente los paquetes de nuestro interes, utilizando un filtro de visualizacion: http contains "www.unan.edu.ni" tal como se muestra en la siguiente imagen: 
![Imagen del display filter](https://github.com/humberto-castellon/lab-repo/blob/images/Lab1.2.JPG)

Los que nos deberia quedar entonces son dos mensajes HTTP: el mensaje GET (desde el navegador hacia el servidor web) y el mensaje de respuesta del servidor al navegador. Para cada paquete Wireshark mostrara detalles importantes como la trama, el datagrama, y el segmento. Esto es como pueden recordar que el mensaje HTTP es enviado dentro un segmento TCP, quien a su vez es enviado dentro de un datagrama IP, quien a su vez es enviado dentro una trama Ethernet 😎. Vamos a seleccionar el primero de los paquetes y en el panel de detalles de los encabezados vamos a expandir el protocolo HTTP.

### Analisis de resultados

Ahora empieza la parte crucial del procedimiento anterior, el analisis de los resultados generados por medio de respuestas a interrogantes 😉. Para responder las preguntas imprima los mensajes (de interes) capturados. Para ello, en Wireshark debemos marcar los paquetes que queremos imprimir (click en el paquete y luego CTRL + M), luego  vaya a *Archivo>Imprimir*. En la ventana emergente vamos a a elegir las opciones *paquetes marcados unicamente, mostrados* y finalmete *Imprimir*

![Imagen impresion de paquetes](https://github.com/humberto-castellon/lab-repo/blob/images/Lab1.1.JPG)

1. ¿Que version HTTP corre en el navegador y que version en el servidor?
2. ¿Que direccion IP tiene el servidor y que direccion tiene el cliente?
3. ¿Cual es el codigo de estado enviado en la respuesta del servidor al cliente?
4. ¿Cuando fue la ultima vez que se modifico el archivo HMTL en el servidor?
5. ¿Cuantos bytes (contenido) son devueltos al navegador en la respuesta?

## 2. El HTTP condicional

Los navegadores para efectos de rendimiento realizan un cache de los objetos y asi entonces cuando se consulta nuevamente un recurso ellos hacen un GET condicional. Para llevar a cabo este procedimiento, es necesario limpiar el cache del navegador. Cuando se haya limpiado el cache entonces se puede proceder con los siguientes pasos:

1. Abrimos el navegador donde vamos a hacer la peticion.
2. En el otro equipo iniciamos Wireshark.
3. De regreso en el navegador, escribimos la URL http://netlab.eastus2.cloudapp.azure.com/lab1.2/
4. Actualizar (F5) la pagina anterior.
5. Detenemos la captura en el equipo con Wireshark (presionando el boton rojo 🛑).

Aplique los mismos pasos (igual que en el apartado anterior) para filtrar la lista de paquetes y visualizar solo el protocolo de interes.

### Analisis de resultados

Responda las siguientes preguntas de acuerdo a los resultados obtenidos:

1. ¿Puede observar en el contenido de la primera solicitud HTTP GET alguna linea con "IF-MODIFIED-SINCE"?
2. En la respuesta del servidor: ¿retorno el servidor (tacitamente) los contenidos del archivo?
3. ¿Puede observar en el contenido de la segunda solicitud HTTP GET alguna linea con "IF-MODIFIED-SINCE"? De ser asi, ¿que informacion se presenta a continuacion del encabezado "IF-MODIFIED-SINCE"?
4. ¿Cual es el codigo de estado HTTP y la frase utilizada en la respuesta a la segunda solicitud HTTP GET? ¿retorno el servidor (tacitamente) los contenidos del archivo?

## 3. Consulta de archivos grandes
En este procedimiento vamos a examinar como HTTP maneja los mensajes cuando se trata de documentos grandes.

1. Abrimos el navegador donde vamos a hacer la peticion y limpiamos cache.
2. En el otro equipo iniciamos Wireshark.
3. De regreso en el navegador, escribimos la URL http://netlab.eastus2.cloudapp.azure.com/lab1.3/
4. Detenemos la captura en el equipo con Wireshark (presionando el boton rojo 🛑).

Aplique los mismos pasos para filtrar la lista de paquetes y visualizar solo el protocolo de interes.

Lo interesante de este apartado es que despues del mensaje HTTP GET se deberia visualizar respuesta multi paquete. El mensaje de respuesta HTTP consiste de una linea de estado, lineas de encabezado, linea en blanco, y finalmente por el cuerpo de entidad. Este ultimo en nuestro caso es el archivo HTML completo solicitado.

### Analisis de resultados

1. ¿Cuantos mensajes de solicitud HTTP GET envio el navegador? 
2. ¿Cual es el codigo de estado y frase en la respuesta?
3. ¿Cuantos segmentos TCP (que contienen datos) fueron necesarios para transportar el texto del archivo HTML?

