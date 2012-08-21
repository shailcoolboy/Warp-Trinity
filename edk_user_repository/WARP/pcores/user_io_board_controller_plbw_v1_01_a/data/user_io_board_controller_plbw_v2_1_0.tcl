##############################################################################
##
## ***************************************************************************
## **                                                                       **
## ** Copyright (c) 1995-2006 Xilinx, Inc.  All rights reserved.            **
## **                                                                       **
## ** You may copy and modify these files for your own internal use solely  **
## ** with Xilinx programmable logic devices and Xilinx EDK system or       **
## ** create IP modules solely for Xilinx programmable logic devices and    **
## ** Xilinx EDK system. No rights are granted to distribute any files      **
## ** unless they are distributed in Xilinx programmable logic devices.     **
## **                                                                       **
## ***************************************************************************
##
## Modified:
## June 20 2006: Added html elaboration step
##############################################################################

proc generate {drv_handle} {
    puts "Generating Macros for user_io_board_controller_plbw driver access ... "

    # initialize
    lappend config_table
    lappend addr_config_table
    lappend xparam_config_table

    # hardware version
    lappend config_table "C_XC_VERSION"
    # Low-level function names
    lappend config_table "C_XC_CREATE" "C_XC_RELEASE" "C_XC_OPEN" "C_XC_CLOSE" "C_XC_READ" "C_XC_WRITE" "C_XC_GET_SHMEM"
    # Optional parameters
    # (empty)

    # Memory map information
    sg_lappend config_table addr_config_table "C_MEMMAP_BUTTONS_BIG"
    sg_lappend config_table xparam_config_table "C_MEMMAP_BUTTONS_BIG_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_BUTTONS_BIG_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_BUTTONS_BIG_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_BUTTONS_SMALL"
    sg_lappend config_table xparam_config_table "C_MEMMAP_BUTTONS_SMALL_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_BUTTONS_SMALL_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_BUTTONS_SMALL_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_DIP_SWITCH"
    sg_lappend config_table xparam_config_table "C_MEMMAP_DIP_SWITCH_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_DIP_SWITCH_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_DIP_SWITCH_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_TRACKBALL"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TRACKBALL_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TRACKBALL_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_TRACKBALL_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_BUZZER_DUTYCYCLE"
    sg_lappend config_table xparam_config_table "C_MEMMAP_BUZZER_DUTYCYCLE_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_BUZZER_DUTYCYCLE_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_BUZZER_DUTYCYCLE_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_BUZZER_ENABLE"
    sg_lappend config_table xparam_config_table "C_MEMMAP_BUZZER_ENABLE_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_BUZZER_ENABLE_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_BUZZER_ENABLE_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_BUZZER_PERIOD"
    sg_lappend config_table xparam_config_table "C_MEMMAP_BUZZER_PERIOD_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_BUZZER_PERIOD_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_BUZZER_PERIOD_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_BACKGROUNDCOLOR"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_BACKGROUNDCOLOR_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_BACKGROUNDCOLOR_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_BACKGROUNDCOLOR_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_CHARACTEROFFSET"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_CHARACTEROFFSET_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_CHARACTEROFFSET_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_CHARACTEROFFSET_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_CHARACTERSSELECT"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_CHARACTERSSELECT_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_CHARACTERSSELECT_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_CHARACTERSSELECT_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_COLSET"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_COLSET_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_COLSET_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_COLSET_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_CONFIGLOCATION"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_CONFIGLOCATION_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_CONFIGLOCATION_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_CONFIGLOCATION_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_DIVIDERSELECT"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_DIVIDERSELECT_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_DIVIDERSELECT_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_DIVIDERSELECT_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_FIRSTEND"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_FIRSTEND_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_FIRSTEND_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_FIRSTEND_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_FIRSTSTART"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_FIRSTSTART_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_FIRSTSTART_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_FIRSTSTART_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_LINEOFFSET"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_LINEOFFSET_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_LINEOFFSET_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_LINEOFFSET_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_RAMWRITE"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_RAMWRITE_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_RAMWRITE_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_RAMWRITE_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_RESET"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_RESET_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_RESET_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_RESET_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_RESETLCD"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_RESETLCD_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_RESETLCD_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_RESETLCD_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_ROWSET"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_ROWSET_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_ROWSET_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_ROWSET_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_SECONDEND"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_SECONDEND_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_SECONDEND_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_SECONDEND_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_SECONDSTART"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_SECONDSTART_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_SECONDSTART_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_SECONDSTART_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_SEND"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_SEND_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_SEND_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_SEND_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_TOTALCMDTRANSFER"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_TOTALCMDTRANSFER_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_TOTALCMDTRANSFER_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_TOTALCMDTRANSFER_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LEDS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LEDS_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LEDS_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LEDS_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_CHARACTERMAP"
    # sg_lappend config_table addr_config_table "C_MEMMAP_LCD_CHARACTERMAP_GRANT"
    # sg_lappend config_table addr_config_table "C_MEMMAP_LCD_CHARACTERMAP_REQ"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_CHARACTERMAP_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_CHARACTERMAP_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_CHARACTERMAP_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_CHARACTERS"
    # sg_lappend config_table addr_config_table "C_MEMMAP_LCD_CHARACTERS_GRANT"
    # sg_lappend config_table addr_config_table "C_MEMMAP_LCD_CHARACTERS_REQ"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_CHARACTERS_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_CHARACTERS_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_CHARACTERS_ATTR"

    sg_lappend config_table addr_config_table "C_MEMMAP_LCD_COMMANDS"
    # sg_lappend config_table addr_config_table "C_MEMMAP_LCD_COMMANDS_GRANT"
    # sg_lappend config_table addr_config_table "C_MEMMAP_LCD_COMMANDS_REQ"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_COMMANDS_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_COMMANDS_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LCD_COMMANDS_ATTR"

    # XPS parameters
    sg_lappend config_table xparam_config_table "DEVICE_ID" "C_BASEADDR"

    # generate xparameters.h
    eval xdefine_include_file $drv_handle "xparameters.h" "USER_IO_BOARD_CONTROLLER_PLBW" "NUM_INSTANCES" ${xparam_config_table}
    eval sg_xdefine_include_file $drv_handle "xparameters.h" "USER_IO_BOARD_CONTROLLER_PLBW" ${addr_config_table}
    # generate sg_plbiface_g.c
    eval xdefine_config_file $drv_handle "user_io_board_controller_plbw_g.c" "USER_IO_BOARD_CONTROLLER_PLBW" ${config_table}
}

proc sg_xdefine_include_file {drv_handle file_name drv_string args} {
    # Open include file
    set file_handle [xopen_include_file $file_name]

    # Get all peripherals connected to this driver
    set periphs [xget_periphs $drv_handle] 

    # Print all parameters for all peripherals
    set device_id 0
    foreach periph $periphs {
        # base_addr of the peripheral
        set base_addr [xget_param_value $periph "C_BASEADDR"]

        puts $file_handle ""
        puts $file_handle "/* Definitions (address parameters) for peripheral [string toupper [xget_hw_name $periph]] */"
        foreach arg $args {
            set value [xget_param_value $periph $arg]
            if {[llength $value] == 0} {
                set value 0
            }
            set value [expr ${base_addr} + ${value}]
            set value [xformat_address_string $value]
            puts $file_handle "#define [xget_name $periph $arg] $value"
        }

        puts $file_handle "/* software driver settings for peripheral [string toupper [xget_hw_name $periph]] */"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_VERSION   1"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_CREATE    xc_user_io_board_controller_plbw_create"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_RELEASE   xc_user_io_board_controller_plbw_release"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_OPEN      xc_user_io_board_controller_plbw_open"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_CLOSE     xc_user_io_board_controller_plbw_close"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_READ      xc_user_io_board_controller_plbw_read"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_WRITE     xc_user_io_board_controller_plbw_write"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_GET_SHMEM xc_user_io_board_controller_plbw_getshmem"

        puts $file_handle ""
    }		
    puts $file_handle "\n/******************************************************************/\n"
    close $file_handle
}

proc sg_lappend {required_config_table {extra_config_table ""} args} {
    upvar ${required_config_table} config_table_1
    if {[string length ${extra_config_table}] != 0} {
        upvar ${extra_config_table} config_table_2
    }

    foreach value ${args} {
        eval [list lappend config_table_1 ${value}]
        if {[string length ${extra_config_table}] != 0} {
            lappend config_table_2 ${value}
        }
    }
}
