#Leer valores para las variables 
$VMName = Read-Host "Introduzca el nombre para la maquina virtual, tipo de dato string"

Write-host "El nombre que ha proporcionado es " $VMName
$RutaVHD = 'C:\ProgramData\Microsoft\Windows\Hyper-V'
$vSwitch=Read-Host "Introduzca el nombre del switch virtual al que quiere conectar la VM, tipo de dato string"
[int32]$memoria= Read-Host "Cantidad de memoria RAM de inicio, tipo de dato int32"
[int32]$Generacion= Read-Host "Generacion de VM 1 o 2, tipo de dato int32"
[int32]$TamañoDisco= Read-Host "Tamaño para el disco virtual, tipo de dato int32"

#Crear la tabla hash para los parametros
$ParamsMaquinaVirtual = @{
    Name =$VMName;
    MemoryStartupBytes = $memoria;
    Generation         = $Generacion;
    NewVHDPath         = '$RutaVHD\$VMName\$VMName.vhdx';
    NewVHDSizeBytes    = $TamañoDisco;
    Path               = '$RutaVHD\$VMName';
    SwitchName=$vSwitch  
}

New-VM @ParamsMaquinaVirtual
