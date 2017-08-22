/* -*- c++ -*- */
/* 
 * Copyright 2017 <+YOU OR YOUR COMPANY+>.
 * 
 * This is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3, or (at your option)
 * any later version.
 * 
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this software; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street,
 * Boston, MA 02110-1301, USA.
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <gnuradio/io_signature.h>
#include "ctc_decode_bb_impl.h"

namespace gr {
  namespace RSSI {

    ctc_decode_bb::sptr
    ctc_decode_bb::make()
    {
      return gnuradio::get_initial_sptr
        (new ctc_decode_bb_impl());
    }

    /*
     * The private constructor
     */
    ctc_decode_bb_impl::ctc_decode_bb_impl()
      : gr::block("ctc_decode_bb",
              gr::io_signature::make(1, 1, sizeof(float)),
              gr::io_signature::make(1, 1, sizeof(char)))
    {
	filter_length = 8;
	}

    /*
     * Our virtual destructor.
     */
    ctc_decode_bb_impl::~ctc_decode_bb_impl()
    {
    }

    void
    ctc_decode_bb_impl::forecast (int noutput_items, gr_vector_int &ninput_items_required)
    {
      /* <+forecast+> e.g. ninput_items_required[0] = noutput_items */
	ninput_items_required[0] = noutput_items;
    }

    int
    ctc_decode_bb_impl::general_work (int noutput_items,
                       gr_vector_int &ninput_items,
                       gr_vector_const_void_star &input_items,
                       gr_vector_void_star &output_items)
    {
      const float *in = (const float *) input_items[0];
      char *out = (char *) output_items[0];

	char receive_bit = -1;
	char ctc_slicer = 0;

	int count = 0;
      // Do <+signal processing+>
	for(int i = 0; i < noutput_items - 1; i++)
	{
		if(in[i] < 0) out[i] = -1;
		else if(in[i] > 0) out[i] = 1;
		else out[i] = 0;
	}



      // Tell runtime system how many input items we consumed on
      // each input stream.
      consume_each (noutput_items);

      // Tell runtime system how many output items we produced.
      return noutput_items;
    }

  } /* namespace RSSI */
} /* namespace gr */

