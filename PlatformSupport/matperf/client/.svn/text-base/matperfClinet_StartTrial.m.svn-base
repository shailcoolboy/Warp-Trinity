function matperfClient_StartTrial(length, windows, reqband, UdpTcp, mode, time,address,reqport)

address = strcat(num2str(address(1)),{'.'},num2str(address(2)),{'.'},num2str(address(3)),{'.'},num2str(address(4)));
if UdpTcp == 1,
    reqpack = [UdpTcp length reqband time reqport];
elseif UdpTcp ==2,
    reqpack = [UdpTcp windows time reqport];
end
udp = pnet('udpsocket',3333);
pnet(udp,'write', reqpack);
pnet(udp,'writepacket',char(address),3333);

keyboard

pnet(udp,'setreadtimeout',30);
len = pnet(udp,'readpacket');
if len > 0,
    data = pnet(udp,'read',1000,'double');
    if data == 1,
        disp('server acknowledged trial request');
    else
        disp('fix your code StartTrial line 20');
        return;
    end
else
    disp('fix the code')
    return
end
pnet('closeall');    
if data == 1,
    systemcall = 'iperf -c';
    systemcall = strcat(systemcall, {' '}, address);
    if UdpTcp == 1,
        systemcall = strcat(systemcall,{' -u'},{' -b '},reqband,{' -l'},length);
    elseif UdpTcp == 2,
        systemcall = strcat(systemcall,{' -w'},windows);
    end
    if mode == 2,
        systemcall = strcat(systemcall, {' -d'});
    elseif mode == 3,
        systemcall = strcat(systemcall, {' -r'});
    end
end

keyboard

systemcall = strcat(systemcall, '>tmp_result.txt',' &');
system(char(systemcall));
while(1)
    system('ps -a >jobs_l');
    system('python weird');
    jobs_l = load('check_jobs');
    if jobs_l ==1,
        continue;
    elseif jobs_l ==0,
        break;
    end
end

udp = pnet('udpsocket',3333);
sucsfail = 23;
pnet(udp,'write', sucsfail);
pnet(udp,'writepacket',char(address),3333);
pnet(udp,'setreadtimeout',30);
len = pnet(udp,'readpacket');
if( len >0)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % if success server sends 2
    % if fail server sends 3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    data = pnet(udp,'read',1000,'double');
    pnet('closeall');
    if data == 2,
        disp('server succeed');
    elseif data == 3,
        disp('server failed');
        %%% need to do something here
    end
else
    disp('check your code StartTrial.m');
    return;
end








return