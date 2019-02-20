
Get-Help about_ | Get-Random
#version 1
function entrada {
    if ([System.IntPtr]::Size -eq 8) {$size = '64 bit'}
    else {$size = '32 bit'}
    $UsuarioActual = [Security.Principal.WindowsIdentity]::GetCurrent()
    $entidadseguridad = New-Object Security.Principal.WindowsPrincipal $UsuarioActual
    if ($entidadseguridad.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator))
    {$admin = 'Administrador'}
    else {$admin = 'Usuario estandar'}
    $host.ui.RawUI.WindowTitle = "$admin $size $(get-location)"
    "~: "
}

#version 2
$UsuarioActual = [Security.Principal.WindowsIdentity]::GetCurrent()
    $entidadseguridad = New-Object Security.Principal.WindowsPrincipal $UsuarioActual
    if ($entidadseguridad.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator))
    {$admin = 'Administrador'}
    else {$admin = 'Usuario estandar'}
$Notificacion = New-Object -ComObject Wscript.Shell
$Notificacion.Popup("La consola se ha iniciado como $admin", 0, "Advertencia", 0x1)


