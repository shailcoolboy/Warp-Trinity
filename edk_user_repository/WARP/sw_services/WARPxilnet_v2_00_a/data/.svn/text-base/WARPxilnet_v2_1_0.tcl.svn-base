###############################################################
# Copyright (c) 2004 Xilinx, Inc. All Rights Reserved.
# You may copy and modify these files for your own internal use solely with
# Xilinx programmable logic devices and  Xilinx EDK system or create IP
# modules solely for Xilinx programmable logic devices and Xilinx EDK system.
# No rights are granted to distribute any files unless they are distributed in
# Xilinx programmable logic devices. 
#
# $Id: xilnet_v2_1_0.tcl,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
# ##############################################################
 

proc net_drc {lib_handle} {
    
    puts "XilNet DRC ..."
    set emac_inst [xget_value $lib_handle "PARAMETER" "emac_instname"]
    if { [string compare -nocase $emac_inst ""] == 0 } {
	error "XilNet needs a valid MAC instance name. Please define \"emac_instname\"." "" "mdt_error"
    }
}

proc net_open_file {filename desc} {
    set config_inc [open $filename w]
    xprint_generated_header $config_inc $desc
    return $config_inc
}

proc net_open_include_file {file_name} {
    set filename [file join "./src/include/net/" $file_name]
    return [net_open_file $filename "XilNet Configuration Parameters"]
}

proc net_open_config_file {file_name} {
    set filename [file join "./src/net/" $file_name]
    return [net_open_file $filename "XilNet MAC Configuration File"]
}

proc generate {lib_handle} {

    set emac_inst [xget_value $lib_handle "PARAMETER" "emac_instname"]
    set sw_prochandle [xget_processor]    
    set emac_handle [xget_sw_ipinst_handle_from_processor $sw_prochandle $emac_inst]

    if {[llength $emac_handle] != 1} {
	error "Invalid MAC isntance $emac_inst specified for \"emac_instname\".  Pleae specify a valid MAC instance for \"emac_instname\"." "" "mdt_error"
	return
    }   
    set ethinst_addr [xget_value $emac_handle "PARAMETER" "C_BASEADDR"]
    set ethinst_ip [xget_value $emac_handle "VALUE"]
    
    set conffile  [net_open_include_file "xilnet_config.h"]

    puts $conffile "#ifndef _XILNET_CONFIG_H" 
    puts $conffile "#define _XILNET_CONFIG_H" 
    puts $conffile ""

    puts $conffile "#ifdef __cplusplus" 
    puts $conffile "extern \"C\" {" 
    puts $conffile "#endif" 
    puts $conffile ""

    if { [string compare -nocase $ethinst_ip "opb_ethernet"] == 0 ||
	 [string compare -nocase $ethinst_ip "plb_ethernet"] == 0} {
	puts $conffile "#define _CONFIG_EMAC_    1 // Use Emac Device"
    } elseif { [string compare -nocase $ethinst_ip "opb_ethernetlite"] == 0 ||
	 [string compare -nocase $ethinst_ip "xps_ethernetlite"] == 0} {
	puts $conffile "#define _CONFIG_EMACLITE_    1 // Use EmacLite Device"
    } else {
	error "\"emac_inst\" is not of type -  OPB_ETHERNET, PLB_ETHERNET and OPB_ETHERNETLITE cores. XilNet can work only with such cores." "" "mdt_error"
    }
    
    puts $conffile ""
    set tcp_conns [xget_value $lib_handle "PARAMETER" "no_of_tcp_conns"]
    set udp_conns [xget_value $lib_handle "PARAMETER" "no_of_tcp_conns"]
    puts $conffile "#define MAX_TCP_CONNS    $tcp_conns  // maximum no of open tcp conns"
    puts $conffile "#define MAX_UDP_CONNS    $udp_conns  // maximum no of open udp conns"
    
    
    puts $conffile ""
    puts $conffile "#endif" 
    close $conffile 
    
    set conffile [net_open_config_file "xilnet_config.c"]
    puts $conffile "unsigned int MYMAC_BASEADDR = $ethinst_addr;"
    puts $conffile ""

    puts $conffile "#ifdef __cplusplus" 
    puts $conffile "}" 
    puts $conffile "#endif" 
    puts $conffile ""

    close $conffile 
    
}
