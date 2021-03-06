cmake_minimum_required(VERSION 2.6)

set_source_files_properties(${CMAKE_CURRENT_BINARY_DIR}/_synchro_simulator.c
							${CMAKE_CURRENT_BINARY_DIR}/_synchro_philosopher.c
							PROPERTIES GENERATED true)

set(EXECUTABLE_OUTPUT_PATH "${CMAKE_CURRENT_BINARY_DIR}")

add_executable(synchro_simulator 	${CMAKE_CURRENT_BINARY_DIR}/_synchro_simulator.c
									${CMAKE_CURRENT_SOURCE_DIR}/philosopher.c)
add_executable(synchro_philosopher 	${CMAKE_CURRENT_BINARY_DIR}/_synchro_philosopher.c 
									${CMAKE_CURRENT_SOURCE_DIR}/philosopher.c)

add_custom_command(
  					OUTPUT 	${CMAKE_CURRENT_BINARY_DIR}/_synchro_simulator.c
							${CMAKE_CURRENT_BINARY_DIR}/_synchro_philosopher.c
  					DEPENDS gras_stub_generator ${CMAKE_CURRENT_SOURCE_DIR}/synchro.xml
  					COMMAND ${CMAKE_BINARY_DIR}/bin/gras_stub_generator synchro ${CMAKE_CURRENT_SOURCE_DIR}/synchro.xml
                    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
					)

### Add definitions for compile
if(NOT WIN32)
target_link_libraries(synchro_simulator simgrid pthread m )
target_link_libraries(synchro_philosopher gras pthread m )
else(NOT WIN32)
target_link_libraries(synchro_simulator simgrid)
target_link_libraries(synchro_philosopher gras)
endif(NOT WIN32)

