<# Notas:

Autor: Humberto Castellon

Objetivo - Creacion de una maquina virtual y sus componentes asociados.

!!!!!!!!!!
Este script esta diseñado como ejemplos secuenciales de comandos.
Se deben modificar las variables de acuerdo al escenario donde se pretende ejecutar los comandos.
!!!!!!!!!!


#>

#region     Definir variables

$VMName = 'TESTVM'
$vSwitch = 'IntvSwitch'
$InstallMedia = '.ISO'
$VHDPath = 'C:\ProgramData\Microsoft\Windows\Hyper-V'

#endregion

#region     Creacion del switch virtual
#Ejecutar el comando en modo visualizacion
New-VMSwitch -Name $vSwitch -SwitchType Internal -WhatIf

#Ejecutar el comando 
New-VMSwitch -Name $vSwitch -SwitchType Internal -Verbose
#endregion

#region     Creacion de la maquina virtual

New-VM -Name $VMName -MemoryStartupBytes 512MB -Generation 2 -NewVHDPath "$VHDPath\$VMName\$VMName.vhdx" -NewVHDSizeBytes 2000000000 -Path "$VHDPath\$VMName" -SwitchName $vSwitch
#endregion

#region     Agregando componentes a la VM

# Agregar DVD
Add-VMScsiController -VMName $VMName
Add-VMDvdDrive -VMName $VMName -ControllerNumber 1 -ControllerLocation 0 -Path $InstallMedia
#Montar el archivo para la instalacion de el SO
$DVDDrive = Get-VMDvdDrive -VMName $VMName
# Configurar la VM para que arranque desde el DVD
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive
#endregion

#region     Realizando las configuraciones finales

Get-VM $VMName | Format-List *
#Deshabilitar los puntos de control
Get-VM $VMName | Set-VM -CheckpointType Disabled
#Ver los valores para algunas propiedades
Get-VM $VMName | Select-Object -ExpandProperty VMIntegrationService
#Visualizar el tipo de disco asignado a la VM
Get-VM –VMName $VMName | Select-Object VMId | Get-VHD
#endregion


