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

REM ***************************************************************
REM IlmBase SLN & VCPROJ files *must* be modified for static libs
REM ***************************************************************

set srcRoot=%ALEMBIC_ROOT%\contrib\%PYILMBASE_VER%

@echo off
pushd %srcRoot%
IF exist build (
	rmdir /S /Q build
)
md build & cd build

::set BOOST_LIBRARYDIR
set BOOST_LIBRARYDIR=%ALEMBIC_OUT%\%BOOST_VER%\%BOOST_LIB_DIR%

:: need boost lib and unistd.h
cmake -DCMAKE_INSTALL_PREFIX=%ALEMBIC_OUT%\%PYILMBASE_VER%  -G "Visual Studio 11 Win64" -DILMBASE_PACKAGE_PREFIX=%ALEMBIC_OUT%\%ILMBASE_VER% -DCMAKE_INCLUDE_PATH:STRING=%ALEMBIC_OUT%\%BOOST_VER%;%PYTHON_ROOT%\Lib\site-packages\numpy\core\include;%ALEMBIC_OUT%\extra\include -DCMAKE_LIBRARY_PATH:STRING=%ALEMBIC_OUT%\%BOOST_VER%\%BOOST_LIB_DIR%;%PYTHON_ROOT%\Lib\site-packages\numpy\core\lib;%PYTHON_ROOT%\libs;%ALEMBIC_OUT%\extra\lib ..

msbuild %srcRoot%\build\pyilmbase.sln /t:Rebuild /p:Configuration=Release;Platform=x64
msbuild   %srcRoot%\build\INSTALL.vcxproj /p:Configuration=Release;Platform=x64

