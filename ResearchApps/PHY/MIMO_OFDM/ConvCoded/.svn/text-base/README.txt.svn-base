2009-03-28
I got this model to run without sysgen errors. The PHY doesn't actually work.

The tx init script needs a bunch of coding-related changes:
-Base rate symbol number
-FEC rate -> packet length in symbols, bytes

basically every change Yange made to ofdm_mimo_t(r)x_init.m needs to be incorporated.

I'm punting for now, to get the uncoded version working OTA first.

=============================

2010-12-04
Yang ported forward his FEC blocks and integrate them with the refdes15 PHY. His model
is ofdm_txrx_supermimo_coded.mdl here. I've built XPS 10.1.03 projects for V2P/V4, but 
still need to test them in hardware. If they work, this will become the main PHY model
from now on.