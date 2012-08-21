proc generate {lib_handle} {


    set filename [file join "./src/include/" "warp_fpga_board.h"]
    set theFile [open $filename w]

    puts $theFile "#ifndef _WARP_FPGA_BOARD_H" 
    puts $theFile "#define _WARP_FPGA_BOARD_H" 
    puts $theFile ""

    puts $theFile "#define WARP_FPGA_BOARD_V1_2 1"
    puts $theFile ""
    puts $theFile "#endif"

    close $theFile 
    
}
