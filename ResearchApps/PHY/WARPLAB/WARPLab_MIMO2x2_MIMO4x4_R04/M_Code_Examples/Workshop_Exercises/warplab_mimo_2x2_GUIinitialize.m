
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Start of Code to avoid conflict between users, only needed for the 
% workshop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('c:\boards_lock.txt');

if(fid > -1)
	fclose('all');
    errordlg('Boards already in use - Please try again!');
	okToUseBoards = 0;
	return;
end

!echo > c:\boards_lock.txt
okToUseBoards = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End of Code to avoid conflict between users, only needed for the 
% workshop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create arp entry for magic sync
!arp -s 10.0.0.244 ff-ff-ff-ff-ff-ff 10.0.0.200

%Close any stale sockets before trying to create new ones
pnet('closeall');

%Load some global definitions (packet types, etc.)
warplab_mimo_2x2_GUIdefines;

%Initial packet number
warplab_mimo_2x2_GUI.pktNoTx = 1;

%Define nodes
warplab_mimo_2x2_GUI.nodes = [1:2];

%Define the nodes' IP addresses & UDP ports
% The IP address and UDP port ranges must match those hardc-coded in the FPGA
warplab_mimo_2x2_GUI.IPAddrs = warplab_IP2int('10.0.0.0') + warplab_mimo_2x2_GUI.nodes;
warplab_mimo_2x2_GUI.UDP_Ports = 9000 + warplab_mimo_2x2_GUI.nodes-1;

%Define the magic SYNC address; this must match the address hard-coded in the FPGA
warplab_mimo_2x2_GUI.MagicSyncAddr = '10.0.0.244';

warplab_mimo_2x2_GUI.socketHandles = warplab_initNets(warplab_mimo_2x2_GUI.MagicSyncAddr, warplab_mimo_2x2_GUI.IPAddrs, warplab_mimo_2x2_GUI.UDP_Ports);

%Initialize the individual nodes
warplab_initNodes(warplab_mimo_2x2_GUI.socketHandles);

%Separate the socket handles for easier access
% The first socket handle is always the magic SYNC
% The rest can be arranged in any combination of Tx and Rx
warplab_mimo_2x2_GUI.udp_Sync = warplab_mimo_2x2_GUI.socketHandles(1);
warplab_mimo_2x2_GUI.udp_node1 = warplab_mimo_2x2_GUI.socketHandles(2);
warplab_mimo_2x2_GUI.udp_node2 = warplab_mimo_2x2_GUI.socketHandles(3);
% warplab_mimo_2x2_GUI.CaptOffset = 1000; %Number of noise samples per Rx capture; in [0:2^14]
warplab_mimo_2x2_GUI.TxDelay = 1000; %Number of noise samples per Rx capture; in [0:2^14]
warplab_mimo_2x2_GUI.TxLength = 2^14-1; %Length of transmission; in [0:2^14-CaptOffset]
warplab_mimo_2x2_GUI.CarrierChannel = 8; % Channel in the 2.4 GHz band. In [1:14]
warplab_mimo_2x2_GUI.TxA_BB = 3; %Tx Baseband Gain in [0:3]
warplab_mimo_2x2_GUI.TxA_RF = 40; %Tx RF Gain in [0:63]
warplab_mimo_2x2_GUI.RxA_BB = 13; %Rx Baseband Gain in [0:31]
warplab_mimo_2x2_GUI.RxA_RF = 1; %Rx RF Gain in [1:3]
warplab_mimo_2x2_GUI.TxB_BB = 3; %Tx Baseband Gain in [0:3]
warplab_mimo_2x2_GUI.TxB_RF = 40; %Tx RF Gain in [0:63]
warplab_mimo_2x2_GUI.RxB_BB = 13; %Rx Baseband Gain in [0:31]
warplab_mimo_2x2_GUI.RxB_RF = 1; %Rx RF Gain in [1:3]
warplab_mimo_2x2_GUI.TxSelect = 2;
warplab_mimo_2x2_GUI.RxSelect = 2;