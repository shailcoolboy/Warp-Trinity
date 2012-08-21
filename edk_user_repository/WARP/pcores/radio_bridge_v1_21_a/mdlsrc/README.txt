To generate the blackbox for the rate change filter:

-Use Sysgen's HDL Netlist export target to create the source files

-In the Sysgen netlist folder, find the file 'xst_radio_bridge_ratechangefilter_4x_2ch.scr'

-In this file, fine the string '-iobuf YES'; change this to '-iobuf NO'. The final contents should look like:

run -ifn xst_radio_bridge_ratechangefilter_4x_2ch.prj -ifmt mixed -ofn radio_bridge_ratechangefilter_4x_2ch_cw.ngc -ofmt NGC -p xc2vp70-6ff1517 -ent radio_bridge_ratechangefilter_4x_2ch_cw -keep_hierarchy NO -iobuf NO -bus_delimiter () -top radio_bridge_ratechangefilter_4x_2ch_cw -hierarchy_separator / -report_timing_constraint_problems warning -register_balancing no -iob Auto -uc radio_bridge_ratechangefilter_4x_2ch_cw.xcf -write_timing_constraints yes

-From the command line, in the Sysgen export directory, run:
	xst -ifn xst_radio_bridge_ratechangefilter_4x_2ch.scr

This will produce a file named 'radio_bridge_ratechangefilter_4x_2ch_cw.ngc'.

-In the same directory, run:
	ngcbuild -i radio_bridge_ratechangefilter_4x_2ch_cw.ngc radio_bridge_ratechangefilter_4x_2ch_cw_full.ngc

-Copy the new file (radio_bridge_ratechangefilter_4x_2ch_cw_full.ngc) to the pcore's netlist folder

-Rename it 'radio_bridge_ratechangefilter_4x_2ch_cw.ngc' (i.e. remove the _full suffix)
