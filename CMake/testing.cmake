##
# @file testing.cmake
#
# @copyright Copyright (C) 2013-2014 srcML, LLC. (www.srcML.org)
#
# The srcML Toolkit is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# The srcML Toolkit is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with the srcML Toolkit; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA


#
# Testing macros/functions and additional variables. These functions will also allow
# for the specification of additional resource locations.
#

#
# addUnitTest
# Creates a unit test from a given file with a given name.
# - TEST_NAME the name of the test.
# - FILE_NAME the name of the unit test file.
# All arguments after the file name are considered to be linker arguments.
# By default all tests are linked against the srcml_static library.
#
#
macro(addUnitTest TEST_NAME FILE_NAME)
    add_executable(${TEST_NAME} ${FILE_NAME})
    target_link_libraries(${TEST_NAME} srcml_shared ${ARGN})
    add_test(NAME ${TEST_NAME} COMMAND $<TARGET_FILE:${TEST_NAME}>)
    set_target_properties(${TEST_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
    set_tests_properties(${TEST_NAME} PROPERTIES TIMEOUT 15)
endmacro()

#
# addPythonTest
# - TEST_NAME the name of the python file.
# Adds a test that executes the given python file.
# additional arguments are dependent files that need to be copied.
#
#
macro(addPythonTest TEST_NAME)

    add_test(NAME ${TEST_NAME} COMMAND ${PYTHON_EXECUTABLE} ${TEST_NAME})
    set_tests_properties(${TEST_NAME} PROPERTIES TIMEOUT 10)

if(NOT ${CMAKE_SOURCE_DIR} MATCHES ${CMAKE_BINARY_DIR})

    copyDependentFile(${TEST_NAME})

foreach(FILE ${ARGN})

    copyDependentFile(${FILE})

endforeach()

endif()

endmacro()

#
# copyDependentFile
# This copies a file given as TARGET_NAME to the current binary directory
# of the build.
#
macro(copyDependentFile TARGET_NAME)
    file(COPY ${TARGET_NAME} DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
endmacro()

#
# Creates a temporary target which is used
# for debugging the build system.
#
#
macro(tempTarget TARGET)
    string(REPLACE ";" " " DISPLAYED_ARGN "${ARGN}")
    add_custom_target(${TARGET}
        COMMAND echo "Build ${TARGET}: dpenedencies: ${DISPLAYED_ARGN}"
        DEPENDS ${ARGN}
    )
endmacro()


#
# This function assists with the creation of dependencies with targets being built
# by other functions within this file. This allows individual targets to be invoked
# with make using the file name as the target name.
#
macro(createProbDep PROBLEM_TYPE LANGUAGE_EXT)
    add_custom_target(problem.${PROBLEM_TYPE}.${LANGUAGE_EXT}.xml
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/problem.${PROBLEM_TYPE}.${LANGUAGE_EXT}.xml
        COMMAND echo "Built problem.${PROBLEM_TYPE}.${LANGUAGE_EXT}.xml"
    )
endmacro()
