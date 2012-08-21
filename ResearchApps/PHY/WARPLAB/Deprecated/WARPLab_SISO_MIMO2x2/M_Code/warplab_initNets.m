function socketHandles = warplab_initNets(SyncIPAddr, NodeIPAddrs, NodeUDPPorts)

%Prepare the magic SYNC socket
thisSock = pnet('udpsocket', 10000);
pnet(thisSock, 'setreadtimeout', 1);
pnet(thisSock, 'udpconnect', SyncIPAddr, 10000);
%SYNC port should be bigger!

socketHandles = [thisSock];

for n = 1:length(NodeIPAddrs)

	%UDP Connections to individual nodes
	thisSock = pnet('udpsocket', NodeUDPPorts(n));
	if (thisSock == -1),
		errordlg('Could not establish UDP connection.', 'Error');
		pnet('closeall');
		delete(hObject);
	end
	pnet(thisSock, 'udpconnect', warplab_int2IP(NodeIPAddrs(n)), NodeUDPPorts(n));
	pnet(thisSock, 'setreadtimeout', 1);
	socketHandles = [socketHandles thisSock];
end
