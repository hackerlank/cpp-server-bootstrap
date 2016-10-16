
file(GLOB_RECURSE DIR_HEADER_FILES ${SERVER_PROJECT_SRC_DIR}/*.h)
file(GLOB_RECURSE DIR_SOURCE_FILES ${SERVER_PROJECT_SRC_DIR}/*.cc)

foreach(file_path ${DIR_SOURCE_FILES})
	if (file_path MATCHES "(.*)_unittest.cc")
		list(REMOVE_ITEM DIR_SOURCE_FILES ${file_path})
	endif()
endforeach()


add_library(${TARGET_LIB_NAME} STATIC ${DIR_HEADER_FILES} ${DIR_SOURCE_FILES})
