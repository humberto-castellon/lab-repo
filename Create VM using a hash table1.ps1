#Definir variables 
$VMName = 'TESTVM'
$RutaVHD = 'C:\ProgramData\Microsoft\Windows\Hyper-V'
$vSwitch='IntvSwitch'

#Crear la tabla hash con sus valores (para los parametros)

$ParamsMaquinaVirtual = @{
    Name =$VMName;
    MemoryStartupBytes = 512MB;
    Generation         = 2;
    NewVHDPath         = '$RutaVHD\$VMName\$VMName.vhdx';
    NewVHDSizeBytes    = 2000000000;
    Path               = '$RutaVHD\$VMName';
    SwitchName=$vSwitch  
}


New-VM @ParamsMaquinaVirtual