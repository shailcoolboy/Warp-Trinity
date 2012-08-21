function replyPkt = warplab_pktSend(udpSock, pktData)
replyPkt = 0;
try
    %Write the packet to the write buffer and then send
    pnet(udpSock, 'write', int32(pktData));
    pnet(udpSock, 'writepacket');
    
    %Wait to receive reply from the board
    len = 0;
    timeout = 0;
    while (len <= 0),
        len = pnet(udpSock, 'readpacket');
        timeout = timeout + 1;
        if (timeout == 10),
            errordlg('No ACK received - Connection has timed out.', 'Timeout');
            pnet('closeall');
            returnStatus = 1;
            return;
        end
    end

    replyPkt = pnet(udpSock, 'read', len, 'uint32');
end

