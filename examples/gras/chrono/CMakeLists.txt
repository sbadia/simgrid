cmake_minimum_required(VERSION 2.6)

set_source_files_properties(${CMAKE_CURRENT_BINARY_DIR}/_chrono_simulator.c
							${CMAKE_CURRENT_BINARY_DIR}/_chrono_multiplier.c
							PROPERTIES GENERATED true)

set(EXECUTABLE_OUTPUT_PATH "${CMAKE_CURRENT_BINARY_DIR}")

add_executable(chrono_simulator ${CMAKE_CURRENT_BINARY_DIR}/_chrono_simulator.c
								${CMAKE_CURRENT_SOURCE_DIR}/chrono.c)
add_executable(chrono_multiplier 	${CMAKE_CURRENT_BINARY_DIR}/_chrono_multiplier.c
									${CMAKE_CURRENT_SOURCE_DIR}/chrono.c)
									
add_custom_command(
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/_chrono_simulator.c
         ${CMAKE_CURRENT_BINARY_DIR}/_chrono_multiplier.c
  DEPENDS gras_stub_generator ${CMAKE_CURRENT_SOURCE_DIR}/chrono.xml
  COMMAND ${CMAKE_BINARY_DIR}/bin/gras_stub_generator chrono ${CMAKE_CURRENT_SOURCE_DIR}/chrono.xml
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

### Add definitions for compile
if(NOT WIN32)
target_link_libraries(chrono_simulator simgrid pthread m )
target_link_libraries(chrono_multiplier gras pthread m )
else(NOT WIN32)
target_link_libraries(chrono_simulator simgrid)
target_link_libraries(chrono_multiplier gras)
endif(NOT WIN32)
