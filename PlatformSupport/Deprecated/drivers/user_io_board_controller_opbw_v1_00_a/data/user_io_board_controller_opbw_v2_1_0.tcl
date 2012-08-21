#uses "xillib.tcl"

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "user_io_board_controller_opbw" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR"
}