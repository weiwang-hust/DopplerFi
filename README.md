# DopplerFi

## Introduction
This is the source code for DopplerFi, which is a Cross-technology Communication project by shifting the sender's carrier frequency.

## Environment

### GNUradio
[Install GNUradio from source](http://gnuradio.org/redmine/projects/gnuradio/wiki/InstallingGRFromSource)

[GNUradio tutial](https://wiki.gnuradio.org/index.php/Guided_Tutorial_GNU_Radio_in_C++)

### [WARP Project](http://warpproject.org/trac)
The basic steps to setup and use the 802.11 Reference Design Experiments Framwork are listed in [this](http://warpproject.org/trac/wiki/802.11/wlan_exp/GettingStarted).

A description of the components of WARPLAB can be found in the [WARPLAB Quick Start](http://warpproject.org/trac/wiki/WARPLab/QuickStart)

### Ubertooth
[Project Ubertooth](https://github.com/greatscottgadgets/ubertooth/wiki)

[How to install Ubertooth](https://github.com/greatscottgadgets/ubertooth/wiki/Build-Guide)

## WiFi2BLE
### transmitter(802.11 reference design)
The DopplerFi sender is based on 802.11 reference design in WARP. The script **log\_capture\_two\_node\_two\_flow.py** in path **Mango\_802.11\_RefDes\_v1.6.2\Python\_Reference\examples\log** is used to transmit Wi-Fi frames.

### receiver(GNUradio + MATLAB)
The DopplerFi receiver in BLE is based on **GMSK loopback** in GNUradio example. 

The RSSI block is used to calculate RSSI for received signal.
1. Copy the gr-RSSI in \WiFi2BLE\gnuradio to the GNUradio path.
2. Build the RSSI block in GNUradio

       cd  /gunradio/build
       make 
       sudo make install
       
3. The GRC project **receiver signal.grc** is used to receive Wi-Fi frame from WARP and decimate.
4. The **GMSK\_receiver.grc** is the receiver chain.

The **CTC\_Slicer\_Decode.m** in path \WiFi2BLE\MATLAB is used to decode and calculate the BER.

## BLE2WiFi
### transmitter(Ubertooth + WARPLAB)
The transmitter in BLE is based on Ubertooth. find the bluetooth file in folder and change the frequency offset in register

### receiver(WARPLAB + MATLAB)
1. For the code in **my\_CSI\_txrx.m** you may need to install WARPLAB Project. This file is used to receive DopplerFi bit using CSI. 
2. The file **main\_WARPLAB.m** is used to demap DopplerFi Bit and calculate BER.
