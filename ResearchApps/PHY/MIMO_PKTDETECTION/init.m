
load goodcap1.mat
load goodcap2.mat
avgLen=16;
diffLen=40;
diffMode_diffThresh=4000;
diffMode_avgThresh=2000;
avgMode_avgThresh=4000;
modeSel=1;
successWindow=48;
resetDuration=32;

maxPacketSize = 50000;
histLength = 2048; %512

eventCounterNumBits = 32;

simTime=length(rssiraw1)*3;
timeVec = (0:(simTime-1)).';

rssiInput=[timeVec,[rssiraw1;rssiraw2;rssiraw1]];
xmitInput=[timeVec,[pkt_det_xmit1;pkt_det_xmit2;pkt_det_xmit1]];




