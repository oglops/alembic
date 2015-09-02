##-*****************************************************************************
##
## Copyright (c) 2009-2015,
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
## *       Neither the name of Sony Pictures Imageworks, nor
## Industrial Light & Magic, nor the names of their contributors may be used
## to endorse or promote products derived from this software without specific
## prior written permission.
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

message("========================= in lib/Alembic/CmakeLists.txt =========================")


ADD_SUBDIRECTORY(Util)
ADD_SUBDIRECTORY(AbcCoreAbstract)
ADD_SUBDIRECTORY(AbcCoreOgawa)
IF (USE_HDF5)
    ADD_SUBDIRECTORY(AbcCoreHDF5)
ENDIF()
ADD_SUBDIRECTORY(Abc)
ADD_SUBDIRECTORY(AbcCoreFactory)
ADD_SUBDIRECTORY(AbcGeom)
ADD_SUBDIRECTORY(AbcCollection)
ADD_SUBDIRECTORY(AbcMaterial)
ADD_SUBDIRECTORY(Ogawa)

INCLUDE_DIRECTORIES(${CMAKE_SOURCE_DIR}/lib ${PROJECT_BINARY_DIR}/lib)

# add ilmbase lib dir
link_directories( ${ALEMBIC_ILMBASE_ROOT}/lib )

ADD_LIBRARY(Alembic ${LIB_TYPE} ${CXX_FILES} 
					${ALEMBIC_ILMBASE_HALF_LIB}
           )

IF (ALEMBIC_SHARED_LIBS)
  SET_TARGET_PROPERTIES(Alembic PROPERTIES DEFINE_SYMBOL ALEMBIC_EXPORTS)
ENDIF()

message("ALEMBIC_SHARED_LIBS:${ALEMBIC_SHARED_LIBS}")
message("LIB_TYPE:${LIB_TYPE}")
message("CMAKE_SOURCE_DIR:${CMAKE_SOURCE_DIR}")
message("PROJECT_BINARY_DIR:${PROJECT_BINARY_DIR}")

message("CXX_FILES:${CXX_FILES}")
message("CORE_LIBS:${CORE_LIBS}")
message("ALEMBIC_SHARED_LIBS:${ALEMBIC_SHARED_LIBS}")
message("ALEMBIC_ILMBASE_HALF_LIB:${ALEMBIC_ILMBASE_HALF_LIB}")

# fixes undefined symbols for x86_64
IF (ALEMBIC_SHARED_LIBS AND DARWIN)
    TARGET_LINK_LIBRARIES(${CORE_LIBS})
ELSEIF(ALEMBIC_SHARED_LIBS AND WIN32)
	TARGET_LINK_LIBRARIES(${CORE_LIBS} ${ALEMBIC_ILMBASE_HALF_LIB})
ENDIF()

INSTALL(TARGETS Alembic
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION lib)
