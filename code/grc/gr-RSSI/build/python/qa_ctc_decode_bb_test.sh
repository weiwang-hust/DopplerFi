#!/bin/sh
export VOLK_GENERIC=1
export GR_DONT_LOAD_PREFS=1
export srcdir=/home/hesy/GNUradio/gnuradio-3.7.10/gr-RSSI/python
export PATH=/home/hesy/GNUradio/gnuradio-3.7.10/gr-RSSI/build/python:$PATH
export LD_LIBRARY_PATH=/home/hesy/GNUradio/gnuradio-3.7.10/gr-RSSI/build/lib:$LD_LIBRARY_PATH
export PYTHONPATH=/home/hesy/GNUradio/gnuradio-3.7.10/gr-RSSI/build/swig:$PYTHONPATH
/usr/bin/python2 /home/hesy/GNUradio/gnuradio-3.7.10/gr-RSSI/python/qa_ctc_decode_bb.py 
