INCLUDE(FindPkgConfig)
PKG_CHECK_MODULES(PC_RSSI RSSI)

FIND_PATH(
    RSSI_INCLUDE_DIRS
    NAMES RSSI/api.h
    HINTS $ENV{RSSI_DIR}/include
        ${PC_RSSI_INCLUDEDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/include
          /usr/local/include
          /usr/include
)

FIND_LIBRARY(
    RSSI_LIBRARIES
    NAMES gnuradio-RSSI
    HINTS $ENV{RSSI_DIR}/lib
        ${PC_RSSI_LIBDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/lib
          ${CMAKE_INSTALL_PREFIX}/lib64
          /usr/local/lib
          /usr/local/lib64
          /usr/lib
          /usr/lib64
)

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(RSSI DEFAULT_MSG RSSI_LIBRARIES RSSI_INCLUDE_DIRS)
MARK_AS_ADVANCED(RSSI_LIBRARIES RSSI_INCLUDE_DIRS)

