function MatperfClinet_EndExp(address,lport)

udp = pnet('udpsocket',3333);
done = 4;
pnet(udp,'write',done);
pnet(udp,'writepacket',char(address),lport);
pnet(udp,'setreadtimeout',10);
len = pnet(udp,'readpacket');
if len >0,
    data = pnet(udp,'read',1000,'double');
    if data == 4,
        disp('server awknowledged complete experiment signal');
        disp('Completing the client process');
    else
        disp('fix the code EndExp.m');
    end
else
    disp('fix the code... server is not corresponding');
end

return