# TCL Server for Azimuth Interaction
#
# Author: Siddharth Gupta

package require Azimuth-Sdk ;# needed to include Azimuth package

puts "Starting TCL server and listening on port 10102"

proc Azimuth_Server {port} {
    set s [socket -server ConnectionAccept $port]
    vwait forever
}

	
proc ConnectionAccept {sock addr port} {
    global connectedClient
    puts "Accept $sock from $addr port $port"
    
    if [info exists connectedClient] {
   		close $connectedClient
	    puts "Closed $connectedClient"
    }
    
    set connectedClient $sock
    
    fconfigure $sock -buffering line

    fileevent $sock readable [list DataAccept $sock]
}


proc DataAccept {sock} {
    global connectedClient

    if {[eof $sock] || [catch {gets $sock line}]} {
	    close $sock
	    puts "Closed $connectedClient"
	    unset connectedClient
    } else {
    	set success 0
    	set reterr 0
    	puts "Executing '$line'"
        if {[catch {eval $line} err]} {
          	set reterr $err
        } else {
           	set success 1
        }
	    if {$success == 0} {
            puts $sock "ace_error: $reterr, command: $line"
        } else {
            puts $sock "ace_success: $line"
        }
    }
}


Azimuth_Server 10102
