
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Start of Code to avoid conflict between users, only needed for the 
% workshop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fid = fopen('c:\boards_lock.txt');
% 
% if(fid > -1)
% 	fclose('all');
%     errordlg('Boards already in use - Please try again!');
% 	okToUseBoards = 0;
% 	return;
% end
% 
% !echo > c:\boards_lock.txt
% okToUseBoards = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End of Code to avoid conflict between users, only needed for the 
% workshop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create arp entry for magic sync
!arp -s 10.0.0.244 ff-ff-ff-ff-ff-ff 10.0.0.200

%Close any stale sockets before trying to create new ones
pnet('closeall');

%Load some global definitions (packet types, etc.)
warplab_siso_GUIdefines;

%Initial packet number
warplab_sisoGUI.pktNoTx = 1;

%Define nodes
warplab_sisoGUI.nodes = [1:2];

%Define the nodes' IP addresses & UDP ports
% The IP address and UDP port ranges must match those hardc-coded in the FPGA
warplab_sisoGUI.IPAddrs = warplab_IP2int('10.0.0.0') + warplab_sisoGUI.nodes;
warplab_sisoGUI.UDP_Ports = 9000 + warplab_sisoGUI.nodes-1;

%Define the magic SYNC address; this must match the address hard-coded in the FPGA
warplab_sisoGUI.MagicSyncAddr = '10.0.0.244';

warplab_sisoGUI.socketHandles = warplab_initNets(warplab_sisoGUI.MagicSyncAddr, warplab_sisoGUI.IPAddrs, warplab_sisoGUI.UDP_Ports);

%Initialize the individual nodes
warplab_initNodes(warplab_sisoGUI.socketHandles);

%Separate the socket handles for easier access
% The first socket handle is always the magic SYNC
% The rest can be arranged in any combination of Tx and Rx
warplab_sisoGUI.udp_Sync = warplab_sisoGUI.socketHandles(1);
warplab_sisoGUI.udp_Tx = warplab_sisoGUI.socketHandles(2);
warplab_sisoGUI.udp_RxA = warplab_sisoGUI.socketHandles(3);