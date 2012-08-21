function matperfClient_StartTrial(length, windows, reqband, UdpTcp, mode, time,address,reqport)

% initialize the variables
retrying = 0;

% server address received when a udp package was received from the server
address = strcat(num2str(address(1)),{'.'},num2str(address(2)),{'.'},num2str(address(3)),{'.'},num2str(address(4)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% when this function is called, it prepares a packet to send to the server
% that includes Udp/Tcp length, bandwidth, time interval, port #, and
% window size. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if UdpTcp == 1,
    reqpack = [1 UdpTcp length reqband time reqport];
elseif UdpTcp ==2,
    reqpack = [1 UdpTcp windows time reqport];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% below commands set the time the matlab will wait for iperf in order to  %
% check if iperf has completed successfully or not. time set here is the  %
% time the trial takes with 2 more seconds since there are chances        %
% that iperf can run over the set time.                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if mode == 3,
    time = 2 * time + 2;
else
    time = time + 2;
end

udp = pnet('udpsocket',3333);

while 1,
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % in this while loop, it sends the prepared packet with 1 in front so that
    % it tells server that client wants server to awknowledge a trial
    % request.
    % Then it waits for the server to send 1,  which tells a server is ready
    % for a trial run. When the client or server does not somehow recognize the
    % signal, then the client sends a packet again.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    pnet(udp,'write', reqpack); 
    pnet(udp,'writepacket',char(address),3333); % sends a packet carrying signal 1


    pnet(udp,'setreadtimeout',3); % wait to receive a response for signal 1
    len = pnet(udp,'readpacket');
        
    if len > 0,
        data = pnet(udp,'read',1000,'double');
        if data == 1,
            disp('server approved trial request');
        else
            disp('fix your code StartTrial line 46');
            continue
        end
    else
        disp('sending trial request reapproval...');
        pnet('closeall');
        udp = pnet('udpsocket',3333);
        continue
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % when the server approves the trial, the below commands begin to
    % create a command that line calls iperf with given data.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if data == 1,
        systemcall = 'iperf -c';
        if UdpTcp == 1,
            systemcall = strcat(systemcall,{' '}, address, {' -u'},{' -b '},num2str(reqband),{' -l '},num2str(length),{' -t '},num2str(time), {' -p '},num2str(reqport));
        elseif UdpTcp == 2,
            systemcall = strcat(systemcall,{' '}, address, {' -w '},num2str(windows),{' -t '},num2str(time),{' -p '},num2str(reqport));
        end
        if mode == 2,
            systemcall = strcat(systemcall, {' -d'});
        elseif mode == 3,
            systemcall = strcat(systemcall, {' -r'});
        end
        systemcall = strcat(systemcall,' -f B -f b > tempo_result.txt &');
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  calls iperf             
    system(char(systemcall)); 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % use python language to check the output
    % weird.txt is a python script that checks if iperf is still running or
    % not. It is very simple. It loads the file jobs_l and check line by
    % line to see if the word iperf exists or not. Because ps -a checks all
    % programs that are in process, if iperf is terminated, it won't be on
    % the list. And python scripts will output 0. If not, it will output 1. 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % it is also the way to check if iperf client is not acting properly.
    % if it takes more than a few seconds after a given amount of time,
    % matlab will consider the client is not acting properly. 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % delay
    pnet(udp,'setreadtimeout',time); % wait until the iperf finishes its job
    pnet(udp,'readpacket');
    
    system('ps -a >jobs_l'); % dump ps -a result to jobs_l 
    system('python weird');  % run the python scripts to check if iperf is still running.
    jobs_l = load('check_jobs'); % load the result to mamtlab

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % matlab checks whether iperf is running after a given certain time +
    % alpha. Sometimes in wireless, even we set the time to 10 as default,
    % iperf runs over 11 or 12. This program checks if iperf is completed
    % or not. And if not, it checks again if iperf is running after 2sec
    % and if it is it kills the iperf and restarts the trial.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if jobs_l == 1,
        % delay
        pnet(udp,'setreadtimeout',3);
        pnet(udp,'readpacket');

        system('ps -a >jobs_l');
        system('python weird');
        jobs_ll = load('check_jobs');
    else
        jobs_ll = 0;
    end

    if jobs_ll == 1,
        disp('first jobs wrong');
        %delay
        pnet(udp,'setreadtimeout',3);
        pnet(udp,'readpacket');

        system('ps -a >jobs_l');
        system('python weird');
        jobs_lll = load('check_jobs');
    else
        jobs_lll = 0;
    end

    if jobs_lll ==1.
        system('killall iperf');
        disp('second jobs wrong');
        continue;
    end
	
	pnet('closeall');
    
    clear_set; % remove all data-recorded files that are unnecessary
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % this while loop checks the signal received from the server whether
    % the trial has succeeded or failed. When the server sends 3,
    % the clinet will restart again. when it sends 2, then it will proceed 
    % to next while loop.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
udp = pnet('udpsocket',3333);
	while 1,

        pnet(udp,'write',5); 
        pnet(udp,'setwritetimeout',.5); %give a delay so that server can be ready when sending a packet
        pnet(udp,'writepacket',char(address),3333); % sends a signal 5 to see if the server succeed its performance.
		pause(1)
        % now check if server sends 2 or 3
        pnet(udp,'setreadtimeout',10);
        len1 = pnet(udp,'readpacket');
        if len1 > 0,
			disp('got reply');
			data = pnet(udp,'read',1000,'double');
            checking = data; % stores info if trial succeeded or not
            break;
        else
            disp('retrying to send 5');
            retrying = retrying + 1;
            if retrying == 10,
                break;
            end
            continue;
        end
		
    end
    if retrying == 10,
        retrying = 0;
        system('killall iperf');
        pnet('closeall');
        udp = pnet('udpsocket',3333);
        continue;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % this if statement asks server to restart the iperf server and returns
    % to the first while loop in order to restart the process.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if checking == 3, % when server says the trial failed...
        disp('trial failed..restarting the trial');
        system('killall iperf');
        pnet('closeall');
        udp = pnet('udpsocket',3333);
        continue;
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % this while loop sends signal 6 to the server. 6 means the client is
    % approving server to parse the output into result vectors, pick up
    % the numbers it needs and structure them as a report structs.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    while 1,
        !python pint.txt
        pnet(udp,'write',6); 
        pnet(udp,'writepacket',char(address),3333); % sends six to server

        pnet(udp,'setreadtimeout', 1);
        len2 = pnet(udp,'readpacket');
        if len2 > 0,
            data = pnet(udp,'read',1000,'double');
            if data == 1,
                break;
            end
        else
            continue;
        end

    end
    break;
end
pnet('closeall');
return
