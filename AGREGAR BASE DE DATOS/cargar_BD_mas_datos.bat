@echo off
setlocal EnableExtensions
chcp 65001 >nul

title Panaderia Barrios - Crear BD y cargar datos


REM ============================================================
REM CONFIGURACION
REM ============================================================

set "DB_HOST=localhost"
set "DB_PORT=3306"
set "DB_USER=root"
set "DB_NAME=PanaderiaBarriosDB"


REM ============================================================
REM ARCHIVOS SQL
REM ============================================================

set "SCHEMA_FILE=%~dp0panaderiaDB.sql"
set "DATA_FILE=%~dp0datos_panaderia.sql"

REM Archivo temporal para ejecutar ambos SQL en una sola conexion
set "TEMP_SQL=%TEMP%\panaderia_barrios_%RANDOM%_%RANDOM%.sql"


REM ============================================================
REM IMAGENES
REM
REM Estructura esperada junto al BAT:
REM
REM images\
REM   productos\
REM     pan_frances.jpg
REM     pan_ciabatta.jpg
REM     ...
REM
REM Destino:
REM
REM ..\src\main\resources\static\images\productos
REM ============================================================

set "IMAGES_SOURCE=%~dp0images\productos"
set "IMAGES_DEST=%~dp0..\src\main\resources\static\images\productos"
set "IMAGES_TARGET=%~dp0..\target\classes\static\images\productos"


REM ============================================================
REM COMPROBAR ARCHIVO panaderiaDB.sql
REM ============================================================

if not exist "%SCHEMA_FILE%" (
    echo.
    echo ============================================================
    echo ERROR
    echo ============================================================
    echo.
    echo No se encontro el archivo:
    echo.
    echo "%SCHEMA_FILE%"
    echo.
    echo El archivo debe llamarse exactamente:
    echo.
    echo panaderiaDB.sql
    echo.
    echo Y debe estar en la misma carpeta que este BAT.
    echo.
    pause
    exit /b 1
)


REM ============================================================
REM COMPROBAR ARCHIVO datos_panaderia.sql
REM ============================================================

if not exist "%DATA_FILE%" (
    echo.
    echo ============================================================
    echo ERROR
    echo ============================================================
    echo.
    echo No se encontro el archivo:
    echo.
    echo "%DATA_FILE%"
    echo.
    echo El archivo debe llamarse exactamente:
    echo.
    echo datos_panaderia.sql
    echo.
    echo Y debe estar en la misma carpeta que este BAT.
    echo.
    pause
    exit /b 1
)


REM ============================================================
REM LOCALIZAR MYSQL.EXE
REM ============================================================

set "MYSQL_EXE="


REM ------------------------------------------------------------
REM 1. Buscar mysql.exe en PATH
REM ------------------------------------------------------------

where mysql.exe >nul 2>&1

if not errorlevel 1 (
    set "MYSQL_EXE=mysql.exe"
)


REM ------------------------------------------------------------
REM 2. Buscar en XAMPP
REM ------------------------------------------------------------

if not defined MYSQL_EXE (
    if exist "C:\xampp\mysql\bin\mysql.exe" (
        set "MYSQL_EXE=C:\xampp\mysql\bin\mysql.exe"
    )
)


REM ------------------------------------------------------------
REM 3. Buscar en Laragon
REM ------------------------------------------------------------

if not defined MYSQL_EXE (
    for /d %%D in ("C:\laragon\bin\mysql\mysql-*") do (
        if exist "%%D\bin\mysql.exe" (
            set "MYSQL_EXE=%%D\bin\mysql.exe"
        )
    )
)


REM ------------------------------------------------------------
REM 4. Buscar instalacion oficial de MySQL
REM ------------------------------------------------------------

if not defined MYSQL_EXE (
    for /d %%D in ("C:\Program Files\MySQL\MySQL Server *") do (
        if exist "%%D\bin\mysql.exe" (
            set "MYSQL_EXE=%%D\bin\mysql.exe"
        )
    )
)


REM ------------------------------------------------------------
REM 5. Buscar MariaDB
REM ------------------------------------------------------------

if not defined MYSQL_EXE (
    for /d %%D in ("C:\Program Files\MariaDB *") do (
        if exist "%%D\bin\mysql.exe" (
            set "MYSQL_EXE=%%D\bin\mysql.exe"
        )
    )
)


REM ============================================================
REM MYSQL NO ENCONTRADO
REM ============================================================

if not defined MYSQL_EXE (
    echo.
    echo ============================================================
    echo ERROR: mysql.exe no fue encontrado
    echo ============================================================
    echo.
    echo Se comprobaron las siguientes ubicaciones:
    echo.
    echo   PATH de Windows
    echo.
    echo   C:\xampp\mysql\bin\mysql.exe
    echo   C:\laragon\bin\mysql\
    echo   C:\Program Files\MySQL\
    echo   C:\Program Files\MariaDB\
    echo.
    echo Asegurate de tener MySQL o MariaDB instalado.
    echo.
    echo Si conoces la ubicacion de mysql.exe puedes colocarla
    echo manualmente en la variable MYSQL_EXE de este BAT.
    echo.
    pause
    exit /b 1
)


REM ============================================================
REM MOSTRAR INFORMACION
REM ============================================================

cls

echo.
echo ============================================================
echo       PANADERIA BARRIOS
echo       INSTALACION DE BASE DE DATOS
echo ============================================================
echo.
echo MySQL:
echo.
echo   "%MYSQL_EXE%"
echo.
echo Servidor:
echo.
echo   %DB_HOST%:%DB_PORT%
echo.
echo Usuario:
echo.
echo   %DB_USER%
echo.
echo Base de datos:
echo.
echo   %DB_NAME%
echo.
echo ------------------------------------------------------------
echo ARCHIVOS SQL
echo ------------------------------------------------------------
echo.
echo   [1] panaderiaDB.sql
echo       "%SCHEMA_FILE%"
echo.
echo   [2] datos_panaderia.sql
echo       "%DATA_FILE%"
echo.
echo ------------------------------------------------------------
echo IMAGENES
echo ------------------------------------------------------------
echo.
echo Origen:
echo.
echo   "%IMAGES_SOURCE%"
echo.
echo Destino:
echo.
echo   "%IMAGES_DEST%"
echo.
echo ============================================================
echo.


REM ============================================================
REM ADVERTENCIA
REM ============================================================

echo ADVERTENCIA:
echo.
echo panaderiaDB.sql elimina la base de datos existente:
echo.
echo   %DB_NAME%
echo.
echo y la vuelve a crear desde cero.
echo.
echo Si ya existe informacion en esa base de datos,
echo sera eliminada.
echo.
echo ============================================================
echo.


REM ============================================================
REM CONFIRMACION
REM ============================================================

set "CONFIRMAR="

set /p "CONFIRMAR=Escribe S para continuar o cualquier otra tecla para cancelar: "

if /I not "%CONFIRMAR%"=="S" (
    echo.
    echo ============================================================
    echo OPERACION CANCELADA
    echo ============================================================
    echo.
    pause
    exit /b 0
)


REM ============================================================
REM CREAR ARCHIVO SQL TEMPORAL
REM
REM Se combinan:
REM
REM   1. panaderiaDB.sql
REM   2. datos_panaderia.sql
REM
REM Esto permite solicitar la contrasena de MySQL una sola vez.
REM ============================================================

echo.
echo ============================================================
echo PREPARANDO SCRIPTS SQL
echo ============================================================
echo.

if exist "%TEMP_SQL%" (
    del /Q "%TEMP_SQL%" >nul 2>&1
)

(
    type "%SCHEMA_FILE%"
    echo.
    echo.
    type "%DATA_FILE%"
) > "%TEMP_SQL%"


REM ============================================================
REM VERIFICAR ARCHIVO TEMPORAL
REM ============================================================

if not exist "%TEMP_SQL%" (
    echo.
    echo ============================================================
    echo ERROR
    echo ============================================================
    echo.
    echo No se pudo crear el archivo SQL temporal.
    echo.
    echo Ruta:
    echo.
    echo "%TEMP_SQL%"
    echo.
    pause
    exit /b 1
)

echo Scripts SQL preparados correctamente.


REM ============================================================
REM EJECUTAR MYSQL
REM ============================================================

echo.
echo ============================================================
echo EJECUTANDO BASE DE DATOS
echo ============================================================
echo.
echo Orden de ejecucion:
echo.
echo   [1/2] Creando estructura de la base de datos
echo         panaderiaDB.sql
echo.
echo   [2/2] Insertando datos iniciales
echo         datos_panaderia.sql
echo.
echo ------------------------------------------------------------
echo.
echo Se solicitara la contrasena del usuario:
echo.
echo   %DB_USER%
echo.
echo Si root no tiene contrasena, simplemente presiona ENTER.
echo.
echo ------------------------------------------------------------
echo.

REM ============================================================
REM IMPORTANTE
REM
REM NO se indica %DB_NAME% al conectarse porque panaderiaDB.sql
REM contiene:
REM
REM   DROP DATABASE IF EXISTS PanaderiaBarriosDB;
REM   CREATE DATABASE PanaderiaBarriosDB;
REM   USE PanaderiaBarriosDB;
REM
REM Por ello la base puede no existir antes de ejecutar el BAT.
REM ============================================================

"%MYSQL_EXE%" ^
    -h "%DB_HOST%" ^
    -P "%DB_PORT%" ^
    -u "%DB_USER%" ^
    -p ^
    --default-character-set=utf8mb4 ^
    < "%TEMP_SQL%"

set "RESULTADO=%ERRORLEVEL%"


REM ============================================================
REM ELIMINAR ARCHIVO SQL TEMPORAL
REM ============================================================

if exist "%TEMP_SQL%" (
    del /Q "%TEMP_SQL%" >nul 2>&1
)


REM ============================================================
REM COMPROBAR RESULTADO DE MYSQL
REM ============================================================

if not "%RESULTADO%"=="0" (
    echo.
    echo ============================================================
    echo ERROR AL CREAR O CARGAR LA BASE DE DATOS
    echo ============================================================
    echo.
    echo MySQL devolvio el codigo:
    echo.
    echo   %RESULTADO%
    echo.
    echo Revisa el mensaje de error mostrado anteriormente.
    echo.
    echo Posibles causas:
    echo.
    echo   1. MySQL no esta iniciado.
    echo.
    echo   2. La contrasena del usuario %DB_USER% es incorrecta.
    echo.
    echo   3. El usuario no tiene permisos para crear bases de datos.
    echo.
    echo   4. El usuario no tiene permisos para eliminar la BD.
    echo.
    echo   5. Existe un error en panaderiaDB.sql.
    echo.
    echo   6. Existe un error en datos_panaderia.sql.
    echo.
    echo   7. La version de MySQL/MariaDB no es compatible.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b %RESULTADO%
)


REM ============================================================
REM BASE DE DATOS CARGADA
REM ============================================================

echo.
echo ============================================================
echo BASE DE DATOS CARGADA CORRECTAMENTE
echo ============================================================
echo.
echo   [OK] panaderiaDB.sql
echo   [OK] datos_panaderia.sql
echo.


REM ============================================================
REM COPIAR IMAGENES DE PRODUCTOS
REM ============================================================

echo.
echo ============================================================
echo COPIANDO IMAGENES DE PRODUCTOS
echo ============================================================
echo.


REM ------------------------------------------------------------
REM Comprobar carpeta de origen
REM ------------------------------------------------------------

if not exist "%IMAGES_SOURCE%" (
    echo ADVERTENCIA:
    echo.
    echo No se encontro la carpeta:
    echo.
    echo   "%IMAGES_SOURCE%"
    echo.
    echo La base de datos SI fue cargada correctamente,
    echo pero las imagenes NO fueron copiadas.
    echo.
    goto :FIN_IMAGENES
)


REM ------------------------------------------------------------
REM Mostrar origen
REM ------------------------------------------------------------

echo Origen:
echo.
echo   "%IMAGES_SOURCE%"
echo.
echo Destino:
echo.
echo   "%IMAGES_DEST%"
echo.


REM ------------------------------------------------------------
REM Crear carpeta destino si no existe
REM ------------------------------------------------------------

if not exist "%IMAGES_DEST%" (
    echo Creando carpeta de destino...
    echo.

    mkdir "%IMAGES_DEST%" >nul 2>&1

    if errorlevel 1 (
        echo ERROR:
        echo.
        echo No se pudo crear:
        echo.
        echo   "%IMAGES_DEST%"
        echo.
        goto :FIN_IMAGENES
    )
)


REM ------------------------------------------------------------
REM Copiar imagenes a src/main/resources/static
REM
REM Se copian todos los archivos y subcarpetas existentes dentro
REM de images\productos.
REM ------------------------------------------------------------

xcopy ^
    "%IMAGES_SOURCE%\*" ^
    "%IMAGES_DEST%\" ^
    /E /I /Y /Q >nul

set "RESULTADO_IMAGENES=%ERRORLEVEL%"


REM ------------------------------------------------------------
REM Comprobar resultado
REM ------------------------------------------------------------

if %RESULTADO_IMAGENES% GEQ 2 (
    echo.
    echo ADVERTENCIA:
    echo.
    echo Ocurrio un problema al copiar las imagenes.
    echo.
    echo Codigo XCOPY:
    echo.
    echo   %RESULTADO_IMAGENES%
    echo.
    echo La base de datos fue cargada correctamente.
    echo.
    goto :FIN_IMAGENES
)


echo Imagenes copiadas correctamente.
echo.
echo Destino:
echo.
echo   "%IMAGES_DEST%"


REM ============================================================
REM COPIAR TAMBIEN A target/classes
REM
REM Si el proyecto ya fue compilado, Spring Boot puede estar
REM utilizando los recursos existentes en target/classes.
REM
REM Esta copia permite actualizar tambien esa ubicacion.
REM ============================================================

if exist "%~dp0..\target\classes" (

    echo.
    echo Se detecto una compilacion existente en target\classes.
    echo.

    if not exist "%IMAGES_TARGET%" (
        mkdir "%IMAGES_TARGET%" >nul 2>&1
    )

    if exist "%IMAGES_TARGET%" (

        xcopy ^
            "%IMAGES_SOURCE%\*" ^
            "%IMAGES_TARGET%\" ^
            /E /I /Y /Q >nul

        if errorlevel 2 (
            echo ADVERTENCIA:
            echo.
            echo No se pudieron copiar todas las imagenes a:
            echo.
            echo   "%IMAGES_TARGET%"
        ) else (
            echo Imagenes copiadas tambien a:
            echo.
            echo   "%IMAGES_TARGET%"
        )
    )
)


REM ============================================================
REM FIN DE COPIA DE IMAGENES
REM ============================================================

:FIN_IMAGENES


REM ============================================================
REM RESULTADO FINAL
REM ============================================================

echo.
echo ============================================================
echo       INSTALACION COMPLETADA CORRECTAMENTE
echo ============================================================
echo.
echo Base de datos:
echo.
echo   %DB_NAME%
echo.
echo Scripts ejecutados:
echo.
echo   [OK] panaderiaDB.sql
echo   [OK] datos_panaderia.sql
echo.
echo ------------------------------------------------------------
echo.
echo Las rutas guardadas en la base de datos, por ejemplo:
echo.
echo   /images/productos/pan_frances.jpg
echo.
echo corresponden en Spring Boot a:
echo.
echo   src\main\resources\static\images\productos\pan_frances.jpg
echo.
echo ============================================================
echo.

pause

exit /b 0