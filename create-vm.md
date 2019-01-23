---
Asignatura: Facultativa de carrera I
Modulo: Virtualización
Lab I: Creación de una máquina virtual en Hyper-V
Version: Windows 10

---

# Introducción
A como se ha discutido en las primeras dos sesiones, un hipervisor es un monitor de máquina virtual que permite la creación y ejecución
de las mismas. También puede decirse que es un proceso que separa el sistema operativo de un equipo y las aplicaciones del hardware 
subyacente. En este laboratorio se creará una máquina virtual utilizando el shell de linea de comandos y lenguaje de programación Powershell.
**Hyper-V** es el hipervisor nativo disponible en sistemas operativos para servidores desde Windows Server 2008 y en sistemas cliente desde 
Windows 8. Se estará trabajando con un script pre-creado que se encuentra [en la siguiente dirección!](https://github.com/humberto-castellon/lab-repo/blob/humberto-castellon-patch-1/Lab%20%231.ps1 )
## ESTE LABORATORIO CONTIENE LAS SIGUIENTES ACTIVIDADES
1. Creación de un switch virtual al cual se conectará la máquina virtual durante el proceso de creación.
2. Creación de la máquina virtual.
3. Verificacion de creación exitosa de la máquina virtual así como de algunas propiedades.

### Ejercicio 1: Verificar que el hipervisor esta habilitado
```Powershell
get-windowsoptionalfeature -online | Where-Object featurename -like "*hyper*"
```

#### DESCRIPCION
Con el comando anterior consultamos si la funcionalidad de Hyper-V esta instalada en el sistema operativo donde estamos trabajando.
Como resultado, el comando anterior debería mostrar una serie de funcionalidades con estado correspondiente, siendo estos habilitado o 
deshabilitado.

### Ejercicio 2: Definir variables 
```Powershell
$VMName = 'TESTVM'
$vSwitch = 'IntvSwitch'
```
#### DESCRIPCION
La definición de variables es importante porque nos permite la adaptación a diferentes escenarios. Con ello logramos la flexibilidad
en los scripts, de manera que solo necesitamos cambiar valores pero no código.

### Ejercicio 3: Creación de un switch (conmutador) virtual
```Powershell
New-VMSwitch -Name $vSwitch -SwitchType Internal
```
#### DESCRIPCION
El comando previo nos permite crear un switch virtual para que cuando se esté creando la máquina virtual se pueda conectar el adaptador
de red (virtual, conocido como vNIC). En el caso de Hyper-V, existen tres tipos de switches: privado, interno, y externo. El externo permite asociar una tarjeta de red
física de modo que las máquinas virtuales tienen acceso a la red física tal como si fueran otro equipo en la red. En el caso del privado 
e interno la diferencia sustancial es que el privado solo permite la comunicación entre los sistemas operativos invitados mientras que el
interno permite además la comunicación con el host.

### Ejercicio 4: Creación de la máquina virtual
```Powershell
New-VM -Name $VMName -MemoryStartupBytes 512MB -Generation 2
```
#### DESCRIPCION
La creación de la máquina virtual se hace por medio del comando `New-VM` continuando con la definición de parámetros, con los cuales deseamos que 
se cree. Existen parámetros requeridos que estan definidos según el comando, mientras que otros son opcionales. Esta parte del script es
importante y debe estar libre de errores. Para confirmar la creación exitosa de la máquina virtual podemos ir a la consola de administración
*Hyper-V Manager* y visualizarla.

### Ejercicio 5: Agregando componentes a la máquina virtual
`Add-VMScsiController` y `Add-VMDvdDrive`

#### DESCRIPCION
En el paso anterior creamos la máquina virtual, ahora necesitamos agregarle algunos componentes para que podamos instalar un sistema operativo
invitado. Estos componentes son una controladora *SCSI* y una unidad de DVD donde podamos *cargar* la imagen de instalación. Finalmente 
necesitamos 'decirle' a la VM con qué dispositivo debe arrancar.

### Ejercicio 6: Configuraciones varias (finales)
Este ejercicio puede ser completado con la parte final del script. Con esta parte consultamos algunas configuraciones que no se definieron
en la creación de la VM y al mismo tiempo las reconfiguramos de manera que se establezcan las que realmente necesitamos. Entre ellas encontramos
la deshabilitación de puntos de control, visualización de servicios de integración, y el tipo de disco virtual que hemos asignado.

# NOTA: LA COMPLETACION DE CADA UNO DE LOS EJERCICIOS DEBERAN SER ADJUNTADOS EN UN DOCUMENTO.
