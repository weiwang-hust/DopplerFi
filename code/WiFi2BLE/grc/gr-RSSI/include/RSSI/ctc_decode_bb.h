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


#ifndef INCLUDED_RSSI_CTC_DECODE_BB_H
#define INCLUDED_RSSI_CTC_DECODE_BB_H

#include <RSSI/api.h>
#include <gnuradio/block.h>

namespace gr {
  namespace RSSI {

    /*!
     * \brief <+description of block+>
     * \ingroup RSSI
     *
     */
    class RSSI_API ctc_decode_bb : virtual public gr::block
    {
     public:
      typedef boost::shared_ptr<ctc_decode_bb> sptr;

      /*!
       * \brief Return a shared_ptr to a new instance of RSSI::ctc_decode_bb.
       *
       * To avoid accidental use of raw pointers, RSSI::ctc_decode_bb's
       * constructor is in a private implementation
       * class. RSSI::ctc_decode_bb::make is the public interface for
       * creating new instances.
       */
      static sptr make();
    };

  } // namespace RSSI
} // namespace gr

#endif /* INCLUDED_RSSI_CTC_DECODE_BB_H */

