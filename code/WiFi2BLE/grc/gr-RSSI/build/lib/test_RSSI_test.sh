#!/bin/sh
export VOLK_GENERIC=1
export GR_DONT_LOAD_PREFS=1
export srcdir=/home/hesy/GNUradio/gnuradio-3.7.10/gr-RSSI/lib
export PATH=/home/hesy/GNUradio/gnuradio-3.7.10/gr-RSSI/build/lib:$PATH
export LD_LIBRARY_PATH=/home/hesy/GNUradio/gnuradio-3.7.10/gr-RSSI/build/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$PYTHONPATH
test-RSSI 
