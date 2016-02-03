add_library (smartcolspp SHARED cell.cc column.cc line.cc symbols.cc table.cc util.cc)
target_link_libraries (smartcolspp ${SCOLS_LIBRARIES})
set_target_properties (smartcolspp PROPERTIES PUBLIC_HEADER smartcolspp.hh)
install(TARGETS smartcolspp
        LIBRARY DESTINATION lib${LIB_SUFFIX}
        PUBLIC_HEADER DESTINATION include)
