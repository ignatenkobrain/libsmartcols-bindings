add_library (smartcolspp SHARED cell.cc column.cc line.cc symbols.cc table.cc util.cc)
target_link_libraries (smartcolspp ${SCOLS_LIBRARIES})
set_target_properties (smartcolspp PROPERTIES PUBLIC_HEADER smartcolspp.hh)
set_property (TARGET smartcolspp PROPERTY CXX_STANDARD 11)
set_property (TARGET smartcolspp PROPERTY CXX_STANDARD_REQUIRED ON)
install(TARGETS smartcolspp
        LIBRARY DESTINATION lib${LIB_SUFFIX}
        PUBLIC_HEADER DESTINATION include)
