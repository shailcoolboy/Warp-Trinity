##############################################################################
## Filename:          /home/sgupta/edkwork/hex_disp_ise/custom_periph/MyProcessorIPLib/drivers/warp_v4_userio_v1_00_a/data/warp_v4_userio_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Mon Oct  5 10:19:41 2009 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "warp_v4_userio" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
