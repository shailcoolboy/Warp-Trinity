function [socketHandles,packetNum] = warplab_initialize(varargin)

% Create arp entry for magic sync
%!arp -s 10.0.0.244 ff:ff:ff:ff:ff:ff 10.0.0.200

%Close any stale sockets before trying to create new ones
pnet('closeall');

% Check length of input argument
leninput = length(varargin);

% Input argument varargin defines the number of nodes
if(0 == leninput)
    % If there is no number of nodes specified then use 2 nodes as default
    nodes = [1:2];
else
    % If there is a number of nodes specified then use that many number of
    % nodes
    nodes = [1:1:varargin{1}];
end
    

%Define the nodes' IP addresses & UDP ports
% The IP address and UDP port ranges must match those hardc-coded in the FPGA
IPAddrs = warplab_IP2int('10.0.0.0') + nodes;
UDP_Ports = 9000 + nodes-1;

%Define the magic SYNC address; this must match the address hard-coded in the FPGA
MagicSyncAddr = '10.0.0.244';

%Define an initial packet number
packetNum = 1;

socketHandles = warplab_initNets(MagicSyncAddr, IPAddrs, UDP_Ports);
warplab_initNodes(socketHandles);