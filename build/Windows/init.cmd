@echo off

set ZLIB_VER=zlib-1.2.8
set ILMBASE_VER=IlmBase-2.2.0
set PYILMBASE_VER=PyIlmBase-2.2.0
set OPENEXR_VER=OpenEXR-2.2.0
set BOOST_VER=boost_1_55_0
set BOOST_LIB_VER=lib64-msvc-11.0
set HDF_VER=hdf5-1.8.5-patch1
set PYTHON_ROOT=c:\python27


set ALEMBIC_OUT=c:\localx

set "MAYA_ROOT=C:\Program Files\Autodesk\Maya2016"


:: get grand parent folder which is also alembic src root folder
for %%i in ("%~dp0..") do set "folder=%%~fi"
for %%i in ("%folder%\..") do set "folder=%%~fi"
echo ALEMBIC_ROOT -^> %folder%

set ALEMBIC_ROOT=%folder%

