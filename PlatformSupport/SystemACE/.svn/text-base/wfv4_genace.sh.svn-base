#!/bin/bash

GENACE_TCL_FILE = "./warp_genace.tcl"
BIT_FILE = "./implementation/download.bit"

make -f system.make init_bram && xmd -tcl GENACE_TCL_FILE -hw BIT_FILE -ace system.ace -board wfv4

