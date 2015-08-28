@echo off

set ZLIB_VER=zlib-1.2.8
set ILMBASE_VER=IlmBase-2.2.0
:: this is for libs names such as Imath-2_2.lib, used in init_Alembic.cmd
:: also note that there is set(ILMBASE_VERSION_API "2_2") in findilmbase.cmake, in case it also needs changing
set ILMBASE_LIB_SUFFIX=2_2
set PYILMBASE_VER=PyIlmBase-2.2.0
set OPENEXR_VER=OpenEXR-2.2.0

set BOOST_VER=boost_1_55_0
:: to be used in init_alembic.cmd
set BOOST_VER_NUM=1_55
:: this is used in init_alembic.cmd to construct name such as libboost_python-vc110-mt-1_55.lib
set BOOST_VC_VER=vc110
set BOOST_LIB_VER=lib64-msvc-11.0

set HDF_VER=hdf5-1.8.5-patch1
set PYTHON_ROOT=c:\python27


:: include and lib for dependencies such as boost and hdf and extra header files
set LOCAL_ROOT=c:\localx

set ALEMBIC_OUT=%LOCAL_ROOT%

set "MAYA_ROOT=C:\Program Files\Autodesk\Maya2016"

:: get grand parent folder which is also alembic src root folder
for %%i in ("%~dp0..") do set "folder=%%~fi"
for %%i in ("%folder%\..") do set "folder=%%~fi"
echo ALEMBIC_ROOT -^> %folder%

set ALEMBIC_ROOT=%folder%

:: set build generator
if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
	set SYS=i64
	set ARCH=x64
	set BUILD_GENERATOR="Visual Studio 11 Win64"
) ELSE (
	set SYS=x86
	set ARCH=x86
	set BUILD_GENERATOR="Visual Studio 11"
)



