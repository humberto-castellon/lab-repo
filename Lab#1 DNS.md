---

Guia de Laboratorio #1: Protocolo de aplicacion DNS
Asignatura: Administracion de Redes

---

# Introduccion

El Sistema de Nombres de Dominio (DNS) principalmente traduce de nombres a direcciones IP, cumpliendo asi un rol imprescindible para la infraestructura de Internet. Vamos a inspeccionar este importante protocolo desde el lado del cliente, lo cual es relativamente simple, el cliente hace una consulta y por ende, recibe una respuesta. Algunos de los aspectos que vamos a examinar son los servidores DNS locales, el cache DNS, registros y mensajes DNS, y el campo TYPE en un registro DNS 👩‍🔬👨‍🔬

# Materiales requeridos

* Equipo donde se ejecutara el protocolo a inspeccionar
* Equipo (con Wireshark instalado) donde se analizaran los protocolos/paquetes.

# Procedimientos
A continuacion se detallan los procedimientos/ejercicios que se van a desarrollar durante el laboratorio.

## Preparacion del escenario

Para llevar a cabo el laboratorio vamos a necesitar dos equipos que puedan comunicarse entre si. Un equipo (perteneciente al cuarto de laboratorio) donde se haran las consultas DNS y el equipo (del grupo que desarrollara el lab) donde se capturara e inspeccionara los paquetes que genere el protocolo de estudio. Este ultimo lo conectaremos a la red local del lab donde le configuraremos (manualmente) una direccion IP y mascara de subred de acuerdo a las definiciones. Una vez que hayamos terminado con esto, entonces haremos una prueba simple de conectividad hacia el otro host. Teniendo un resultado positivo en este paso podemos pasar al siguiente procedimiento.

## NSLOOKUP
Esta es una herramienta que se encuentra presente en la mayoria de plataformas de sistemas operativos. Para ejecutar la herramienta, abrimos el simbolo del sistema (linea de comandos) y ejecutamos `nslookup` (aun no lo haga).

Esta utilidad funciona de tal manera que permite consultar un servidor DNS para un registro DNS. Podemos consultar un servidor DNS de primer nivel (TLD), un servidor DNS autoritativo, o un servidor DNS intermedio. 

Nota: La utilidad puede funcionar en dos modos, no interactivo (el uso mas comun/basico) e interactivo (mas verboso). El primero se hace cuando a la utilidad solo le pasamos el host que queremos consultar mientras que el segundo lo podemos lograr cuando no le pasamos argumento o cuando utilizamos el switch (-).

### Consulta no interactiva

1. Abra el simbolo del sistema.
2. Escriba lo siguiente: `nslookup www.unan.edu.ni`
3. Obtenga la direccion IP del resultado de la consulta y guarde evidencia del trabajo.


### Consulta interactiva

1. Abra el simbolo del sistema.
2. Escriba lo siguiente: `nslookup -Type=NS unan.edu.ni` y `nslookup -Type=NS unan.edu.ni 8.8.8.8` ¿hay alguna diferencia entre ambos comandos?
3. Obtenga la direccion IP del resultado de las consultas y guarde evidencia del trabajo.

## Rastreando DNS con Wireshark (servicio web)

Una vez que hemos iniciado a interactuar con DNS es momento de ponernos serios 👨‍🚀. La navegacion web es uno de los tantos servicios que se apoya en DNS para cumplir su trabajo. De este modo, cuando queremos visitar un sitio web, por ejemplo, el navegador extrae el nombre del servidor (por medio de HTTP) y luego hace la consulta DNS para averiguar la direccion IP para hacer la peticion. Vamos entonces a capturar los paquetes que son generados por dicho servicio.

1. El primer paso implica vaciar el cache DNS del equipo del cuarto de laboratorio. Esto es importante porque si el registro DNS se encuentra en el cache entonces no se hara la consulta DNS, como es de esperarse. Para hacerlo, abrimos el simbolo del sistema y ejecutamos el comando `ipconfig /flushdns`. 
2. Tambien necesitamos limpiar el cache del navegador.
3. Abrir Wireshark en el otro equipo, seleccionar la tarjeta de red adecuada e iniciar la captura de paquetes.
4. De regreso en el navegador vamos a visitar el sitio donde encontramos los documentos del grupo de trabajo de internet 👏, http://www.ietf.org.
5. Una vez que ha cargado la pagina entonces detenemos la captura de paquetes en Wireshark.
6. Consulte la direccion IP asociada con la interfaz de red donde se capturaron los paquetes. Esta direccion IP la utilizaremos para filtrar los paquetes de interes escribiendo en la barra de filtro de visualizacion lo siguiente: `ip.addr == su_direccion_IP`.

### Analisis de resultados

Ahora empieza la parte crucial del procedimiento anterior, el analisis de los resultados generados por medio de respuestas a interrogantes 😉. Para responder las preguntas imprima los mensajes (de interes) capturados. Para ello, en Wireshark debemos marcar los paquetes que queremos imprimir (click en el paquete y luego CTRL + M), luego  vaya a *Archivo>Imprimir*. En la ventana emergente vamos a a elegir las opciones *paquetes marcados unicamente, mostrados* y finalmete *Imprimir*

![Imagen impresion de paquetes](https://github.com/humberto-castellon/lab-repo/blob/images/Lab1.1.JPG)

Responda a las siguientes interrogantes

1. Localice los mensajes de consulta y respuesta DNS, ¿se enviaron estos por UDP o TCP?
2. ¿Cual es el puerto de destino para el mensaje de consulta DNS? ¿Cual es el puerto de origen para el mensaje de respuesta?
3. ¿A que direccion IP es enviado el mensaje de consulta DNS? Utilice ipconfig para determinar la direccion IP del servidor DNS local ¿Coinciden ambas direcciones IP?
4. Inspeccione el mensaje de consulta DNS. ¿Que "tipo" de consulta DNS es? ¿Contiene el mensaje de consulta alguna respuesta?
5. Inspeccione el mensaje de respuesta DNS. ¿Cuantas respuestas son proporcionadas? ¿Que contiene cada una de estas respuestas?
6. Ahora tome en cuenta el paquete TCP SYN subsiguiente enviado por el equipo. ¿Corresponde la direccion IP de destino del paquete SYN con alguna de las direcciones IP que aparecen en el mensaje de respuesta DNS?
7. La pagina web consultada contiene imagenes, antes de recuperar esas imagenes ¿envia el equipo nuevas consultas DNS?

## Rastreando DNS con Wireshark (consulta directa)

Ahora vamos a inspeccionar mensajes DNS de forma directa, es decir, vamos a producirlos con la utilidad *nslookup*.

1. Inicie la captura de paquetes en Wireshark.
2. Vaya al otro equipo, abra el simbolo del sistema y realice la consulta asi: `nslookup www.uab.edu`.
3. Detenga la captura de paquetes en Wireshark.
4. Repita el paso acerca de la filtracion de paquetes tal como se hizo en el apartado anterior.

### Analisis de resultados

Nota: Aplicar el mismo paso de filtro de paquetes que se hizo en el apartado anterior.

Para responder a las siguientes preguntas solo tome en cuenta el paquete de consulta y respuesta. Esto es, porque por lo general, la utilidad genera paquetes adicionales previos que necesita para averiguar por donde "salir" para hacer la consulta.

1. ¿Cual es el puerto de destino para el mensaje de consulta DNS? ¿Cual es el puerto de origen para el mensaje de respuesta?
2. ¿A que direccion IP es enviado el mensaje de consulta DNS? ¿Es esta la direccion IP del servidor DNS local por defecto?
3. Inspeccione el mensaje de consulta DNS. ¿Que "tipo" de consulta DNS es? ¿Contiene el mensaje de consulta alguna respuesta?
4. Inspeccione el mensaje de respuesta DNS. ¿Cuantas respuestas son proporcionadas? ¿Que contiene cada una de estas respuestas?

Ahora repita el procedimiento anterior pero escriba el comando siguiente:
`nslookup -Type=NS uab.edu`. 

Para este procedimiento responda las preguntas 2, 3 (del apartado anterior), y la siguiente:
Inspeccione el mensaje de respuesta DNS. ¿Que servidores de nombre (de UAB) proporciona el mensaje de respuesta? ¿Proporciona tambien el mensaje de respuesta las direcciones IP de los servidores de nombre (de UAB)?




