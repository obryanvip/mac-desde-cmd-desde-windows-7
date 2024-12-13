@echo off
setlocal enabledelayedexpansion

REM Verificar si se ejecuta con privilegios de administrador
>nul 2>&1 "%SystemRoot%\System32\reg.exe" query "HKU\S-1-5-19"
if %errorlevel% neq 0 (
    echo Este script debe ejecutarse como administrador.
    pause
    exit /b 1
)

REM Nueva dirección MAC (ajustable)
set "newMAC=760E8E1526F4"

REM Ruta exacta de la clave del adaptador (ajusta esta ruta según lo que encontraste)
set "regKey=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0012"

REM Cambiar la dirección MAC en el Registro
echo Cambiando la dirección MAC a %newMAC%...
reg add "%regKey%" /v "NetworkAddress" /d "%newMAC%" /f >nul 2>&1

REM Verificar si el cambio en el Registro fue exitoso
if %errorlevel% neq 0 (
    echo Error al cambiar la dirección MAC en el Registro.
    pause
    exit /b 1
)

REM Nombre del adaptador de red (ajustable, debe coincidir con el nombre real del adaptador en el sistema)
set "adapterName=wifi"

REM Deshabilitar el adaptador de red
echo Deshabilitando el adaptador de red "%adapterName%"...
netsh interface set interface name="%adapterName%" admin=disable >nul 2>&1

REM Habilitar el adaptador de red
echo Habilitando el adaptador de red "%adapterName%"...
netsh interface set interface name="%adapterName%" admin=enable >nul