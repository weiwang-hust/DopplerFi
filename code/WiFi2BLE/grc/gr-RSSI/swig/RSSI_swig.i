/* -*- c++ -*- */

#define RSSI_API

%include "gnuradio.i"			// the common stuff

//load generated python docstrings
%include "RSSI_swig_doc.i"

%{
#include "RSSI/my_RSSI_ccf.h"
#include "RSSI/ctc_decode_bb.h"
%}


%include "RSSI/my_RSSI_ccf.h"
GR_SWIG_BLOCK_MAGIC2(RSSI, my_RSSI_ccf);
%include "RSSI/ctc_decode_bb.h"
GR_SWIG_BLOCK_MAGIC2(RSSI, ctc_decode_bb);
