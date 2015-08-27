@echo off
setlocal

if NOT "%ALEMBIC_ROOT%" == "" if NOT "%ALEMBIC_OUT%" == "" goto AlembicDefined
echo ALEMBIC_ROOT and ALEMBIC_OUT must be defined!!!
goto :eof
:AlembicDefined

if /i "%1" == "db:" (
	set DB=_db
	set config=Debug
	shift
) ELSE (
	set DB=
	set config=Release
)

if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
	set SYS=i64
	set arch=x64
) ELSE (
	set SYS=x86
	set arch=Win32
)

set srcRoot=%ALEMBIC_ROOT%\contrib\%ZLIB_VER%
set srcDir=%srcRoot%
::set outDir=%ALEMBIC_OUT%\%SYS%\%ZLIB_VER%
::set outLib=%outDir%\lib%DB%
::set IncDir=%outDir%\include\OpenEXR

::if NOT exist "%IncDir%"		md %IncDir%
::if NOT exist "%outLib%"		md %outLib%

@echo off
echo srcDir %srcDir%
echo ALEMBIC_ROOT %ALEMBIC_ROOT%
echo srcRoot %srcRoot%

pushd %srcDir%
IF exist build (
	rmdir /S /Q build
) 

md build & cd build
cmake -DCMAKE_INSTALL_PREFIX=%ALEMBIC_OUT%\%ZLIB_VER% -G "Visual Studio 11 Win64" ..

msbuild   %srcDir%\build\zlib.sln /p:Configuration=Release;Platform=x64 /m 
msbuild INSTALL.vcxproj /p:Configuration=Release;Platform=x64

