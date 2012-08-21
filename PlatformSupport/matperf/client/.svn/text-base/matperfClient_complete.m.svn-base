% this program terminates the server and return the structs it made.
% it basically sends signal 7 which the serve recognizes as a sign to
% terminate the experiment.
function matperfClient_complete(address)
pnet('closeall');
udp = pnet('udpsocket',3333);
pnet(udp,'write',7);
pnet(udp,'writepacket',char(address),3333);
return
