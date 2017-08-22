# DopplerFi

## Introduction

This is the source code for DopplerFi, which is a cross-technology communication project.

## Environment

### GNUradio
[Install GNUradio from source](http://gnuradio.org/redmine/projects/gnuradio/wiki/InstallingGRFromSource)

[GNUradio tutial](https://wiki.gnuradio.org/index.php/Guided_Tutorial_GNU_Radio_in_C++)

### WARP
[WARP Project](http://warpproject.org/trac)

802.11 reference design

WAPRLAB


### Ubertooth

[Project Ubertooth](https://github.com/greatscottgadgets/ubertooth/wiki)

## WiFi2BLE
### transmitter(802.11 reference design)
The DopplerFi sender is based on 802.11 reference design in WARP. The frequency offset cannot be shifted so the DopplerFi in WiFi sender is not be modified. 

### receiver(GNUradio + MATLAB)
The DopplerFi receiver in BLE is built on GMSK loopback. The RSSI block is used to calculate RSSI for received signal.
1.Copy the RSSI folder into the path.
2.Build the RSSI block in GNUradio
    cd  /gunradio/build
    make 
    sudo make install

The GRC project **receiver signal.grc** is used to receive Wi-Fi frame from WARP and decimate.
The **GMSK\_receiver.grc** is the receiver chain.

the output of GMSK receiver is used to demap in MATLAB.

## BLE2WiFi
### transmitter(Ubertooth + WARPLAB)
The DopplerFi sender in BLE is based on Ubertooth. 

### receiver(WARPLAB + MATLAB)
