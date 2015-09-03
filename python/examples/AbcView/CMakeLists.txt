##-*****************************************************************************
##
## Copyright (c) 2009-2014,
##  Sony Pictures Imageworks Inc. and
##  Industrial Light & Magic, a division of Lucasfilm Entertainment Company Ltd.
##
## All rights reserved.
##
## Redistribution and use in source and binary forms, with or without
## modification, are permitted provided that the following conditions are
## met:
## *       Redistributions of source code must retain the above copyright
## notice, this list of conditions and the following disclaimer.
## *       Redistributions in binary form must reproduce the above
## copyright notice, this list of conditions and the following disclaimer
## in the documentation and/or other materials provided with the
## distribution.
## *       Neither the name of Industrial Light & Magic nor the names of
## its contributors may be used to endorse or promote products derived
## from this software without specific prior written permission.
##
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
## "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
## LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
## A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
## OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
## SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
## LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
## DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
## THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
## (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
## OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
##
##-*****************************************************************************
message("========================= in python/examples/AbcView/CMakeLists.txt =========================")

message("Boost_PYTHON_LIBRARY: ${Boost_PYTHON_LIBRARY}")
message("ALEMBIC_ILMBASE_IMATH_LIB: ${ALEMBIC_ILMBASE_IMATH_LIB}")
# Boost_PYTHON_LIBRARY = optimized;c:/local/boost_1_55_0/lib64-msvc-11.0/boost_python-vc110-mt-1_55.lib;debug;c:/local/boost_1_55_0/lib64-msvc-11.0/boost_python-vc110-mt-gd-1_55.lib
list(GET ${Boost_PYTHON_LIBRARY} 1 Boost_PYTHON_LIBRARY)

GET_FILENAME_COMPONENT(BOOST_LIBRARY_DIR ${Boost_PYTHON_LIBRARY} PATH)
GET_FILENAME_COMPONENT(ILMBASE_LIBRARY_DIR ${ALEMBIC_ILMBASE_IMATH_LIB} PATH)
set (GLEW_INCLUDE_DIR "$ENV{LOCAL_ROOT}/$ENV{GLEW_VER}/include")

# add pthread getopt unistd header files
include_directories("$ENV{LOCAL_ROOT}/extra/include" "$ENV{LOCAL_ROOT}/$ENV{GLEW_VER}/include")
link_directories("$ENV{LOCAL_ROOT}/extra/lib")


CONFIGURE_FILE(
    "${CMAKE_CURRENT_SOURCE_DIR}/abcview.in"
    "${CMAKE_CURRENT_BINARY_DIR}/abcview"
    @ONLY )
