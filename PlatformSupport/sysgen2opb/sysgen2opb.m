% Copyright (c) 2006-2008 Rice University
% All Rights Reserved
% This code is covered by the Rice-WARP license
% See http://warp.rice.edu/license/ for details
%
% 'sysgen2opb' is a MATLAB script which converts a model built in Xilinx
% System Generator into an OPB-compliant peripheral for use with the 
% embedded PowerPCs. The script replaces all the model's From/To Registerse
% with memory mapped registers. It also creates the necessary address 
% decode logic and a C header file with the resulting register map. 
% 
% In addition, there is an option that can be turned on/off:
% Shared Memory Extension Script - This script adds in an option to allow
% the usage of Shared Memory. This script requires the usage of Dual Port
% RAM's.
%
% This script is only supported for Xilinx System Generator 8.1 and 8.2
%
% To run the script, type the following on the Matlab command line:
% sysgen2opb('yourModelName', 'yourSMChoice')
%
%   Replace 'yourModelName' with your Simulink model's name 
%   without the .mdl extension. 
%
%   Replace 'yourSMChoice' with one of the following:
%       1. 'smon' which will turn on the Shared Memory Extension Script
%       2. 'smoff' which will turn off the Shared Memory Extension Script 
%
% If you want to run the original script that utilizes From/To Registers
% with no shared memory extension, run: sysgen2opb('yourModelName')

function sysgen2opb(sys, varargin)
warning off;

% Run the model to see if there are any errors in the model
try
	sim(sys, 0)
catch
	display(['Error: Simulating the model resulted in error. Please check your model and initialization script.']);
	return;
end 

% Base Address is always zero due to relocatable memory
base = 0;

appendString = '';

% Look at the length of varargin to determine whether to run default
% scripts
if length(varargin) == 0
	%Defult to no shared memory
	smChoice = 'smoff';
elseif length(varargin) == 1
	smChoice = char(varargin(1));
else
	display('Unrecognized parameters on command line.');
	return;
end

% Find the sample time period from the System Generator block
sysgenblock = find_system(sys, 'block_type', 'sysgen');
if length(sysgenblock) == 0
	display(['Error: Please include a System Generator block.']);
	return;
elseif length(sysgenblock) > 1
	display(['Error: Please only include one System Generator block in model.']);
	return;
else
	sysgenperiod = get_param(sysgenblock, 'simulink_period');
	sysgenperiod = mat2str(cell2mat(sysgenperiod));
end

% Load the model. Inform the user if it fails to load (ie: the model does
% not exist)
try
	load_system(sys);
catch
	display(['Error: System ' sys ' does not exist']);
	return;
end

% Check smChoice
if ~(strcmp(smChoice, 'smon') | strcmp(smChoice, 'smoff'))
	display(['Error smChoice input ''' smChoice ''' does not exist. Please use ''smon'' or ''smoff'' as your inputs.']);
	return;
end


% Find the current sysgen version
try
	version = xlVersion;
catch
	display('Error: Sysgen is not found!');
	return;
end

if length(version) >= 1
	% The latest version is the first one in the cell
	version = version{1};
	% Get the first digit of the string array
	version = str2num(version(1:3)); 
else
	display('Error: Sysgen is not found!');
	return;
end

if ((version == 8.1) | (version == 8.2) | (version == 9.1))
	% Find the From/To Registers
	gatewaysInCheck = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on',   'block_type', 'fromreg');
	gatewaysOutCheck = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on',    'block_type', 'toreg');
else
	display(['Error: Version ' version ' is not supported.']);
	return;
end

% Check how many Gateways we have
numberGateways = length(gatewaysInCheck) + length(gatewaysOutCheck);
if numberGateways > 450
    display('Error: The script only allows a max of 450 From/To Registers');
	return;
elseif numberGateways == 0
    display('Error: The script needs From/To Regs within the model');
	return;
end

% Check to see if we have a converted model by checking if we have the
% Memory Mapped IO
% If we do, inform the user and exit the script
MemoryMappedIO = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on',  'BlockType', 'SubSystem', 'Name', 'Memory Mapped I_O');
if length(MemoryMappedIO) > 0
	display('You already have converted this design to a peripheral.');
	display('Please get rid of the Memory Mapped I_O block and make sure')
	display('your gateways are all still in place before trying again.');
	return;
end

% Try saving an unconverted backup
try
	save_system(sys,[sys '_unconverted_backup']);
catch
	% There's a system with that name that's opened right now
	% Close that system without saving
	close_system([sys '_unconverted_backup'], 0);

	% Save the backup system
	save_system(sys,[sys '_unconverted_backup']);
end
close_system([sys '_unconverted_backup']);

% Load the system
load_system(sys);
save_system(sys, sys, 'BreakLinks');

% Try loading a local copy from the skeleton model
% If it is not there, load it from the toolbox
spm = 'skeleton_periph_model';
try
	load_system(spm);
catch
	load_system([matlabroot '\toolbox\WARP\' spm]);
end

%Find Sybsystems and correct all the names
subsystems = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'SubSystem');
%First we need to look for duplicate names
for c=1:length(subsystems)
	subsysName = subsystems{c};
	shortName = get_param(subsysName, 'Name');
	parent = get_param(subsysName, 'Parent');
	compName = [shortName '                 '];
	% Make sure that we do not edit the name of the System Generator
	if ~strcmp(compName(1:17), ' System Generator')
	    idx=0;  %appended to the end of a duplicate name
	    for d=c+1:length(subsystems)
	        subsysName2 = subsystems{d};
	        shortName2 = get_param(subsysName2,'Name');
	        parent2 = get_param(subsysName2, 'Parent');
	        if strcmp(parent, parent2) & strcmp(cleanName(shortName), cleanName(shortName2))
	            set_param(subsysName2,'Name', [shortName2 '_' int2str(idx)]);
	            idx=idx+1;            
	            subsystems = find_system(sys,'LookUnderMasks','all','BlockType','SubSystem')';
	        end
	    end
	end
end

% Update the Subsystem list
subsystems = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on',  'BlockType', 'SubSystem');
%Now for Subsystems with spaces, we want to clean up the name
for c=length(subsystems):-1:1
	subsysName = subsystems{c};
	shortName = get_param(subsysName, 'Name');
	compName = [shortName '                 '];
	% Make sure that we do not edit the name of the System Generator
	if ~strcmp(compName(1:17), ' System Generator')
	    set_param(subsysName, 'Name', cleanName(shortName));
	end
end

if strcmp(smChoice, 'smon')
	% Define the variables that will be 
	% later used for shared memory extension
	dpramWOAddr={};
	dpramWOAddrIndex = 0;
	dpramWODataI={};
	dpramWODataIIndex = 0;
	dpramWOWE={};
	dpramWOWEIndex = 0;
	dpramROAddr={};
	dpramROAddrIndex = 0;
	dpramRODataO={};
	dpramRODataOIndex = 0;
	
	% dpramROIndex will be used to determine the number of dpram Read-only's
	% This will be used to determine whether we need a delay of one within
	% the mem_if_out
	dpramROIndex = 0;
	
	% maxdpram will be used to determine how many shared memory blocks we
	% can have
	binBaseAddress = dec2bin(base);
	try
	    maxdpram = 15 - bin2dec(binBaseAddress(13:16));
	catch
	    maxdpram = 15;
	end
	
	% dpram will hold the list of all dual port RAM's
	dpram = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'block_type', 'dpram');

	% dpramWORO will hold the list of all WO, RO dual port RAM's
	dpramWORO={};
	dpramWOROidx = 0;
	for c=1:length(dpram)
	    dpramName = dpram{c};
	    compName = [get_param(dpramName, 'Name') '     '];

	    % Delete all broken lines
	    brokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'SrcBlockHandle', -1);
	    delete_line(brokenlines);
	    brokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'DstBlockHandle', -1);
	    delete_line(brokenlines);
	    
	    if strcmp(compName(1:5), 'SMWO_') | strcmp(compName(1:5), 'SMRO_')
	        dpramWOROidx = dpramWOROidx + 1;
	        if dpramWOROidx > maxdpram
	            display(['Error: We are allowed a total of ' num2str(maxdpram) ' dual port RAMS that are read-only/write-only.']);
	            return;
	        end
	        
	        dpramWORO{dpramWOROidx} = [get_param(dpramName, 'Name') '_sm' num2str(dpramWOROidx - 1)] ;
	        
	        DpramPortHandles = get_param(dpramName, 'PortHandles');

	        ports = [DpramPortHandles.Inport(4), DpramPortHandles.Inport(5), DpramPortHandles.Inport(6), DpramPortHandles.Outport(2)];

	        SrcBlockHandleAddr = get_param(get_param(ports(1), 'Line'), 'SrcBlockHandle');
	        SrcBlockHandleDataI = get_param(get_param(ports(2), 'Line'), 'SrcBlockHandle');
	        SrcBlockHandleWE = get_param(get_param(ports(3), 'Line'), 'SrcBlockHandle');
	        

	        AddrName = get_param(SrcBlockHandleAddr, 'Name');
	        CompAddrName = [AddrName '         '];
	        AddrFullName = [get_param(SrcBlockHandleAddr, 'Parent') '/' AddrName];
	        if ~strcmp(get_param(SrcBlockHandleAddr, 'block_type'), 'gatewayin')
	            display(['A GatewayIn is needed in order to connect to the addrb inport of the dpram ' dpramName '.']);
	            return;
	        end
	        if  ~strcmp(get_param(SrcBlockHandleAddr, 'arith_type'), 'Unsigned') | (str2num(get_param(SrcBlockHandleAddr, 'n_bits')) > 14) |  (str2num(get_param(SrcBlockHandleAddr, 'bin_pt')) > 0)
	            display(['The GatewayIn ' AddrFullName ' needs to be UFix, with number of bits <= 14, and binary point at 0.']);
	            return;
	        end
	        orientationAddr = get_param(SrcBlockHandleAddr, 'Orientation');
	        placeAddr = get_param(SrcBlockHandleAddr, 'position');
	        parentAddr = get_param(SrcBlockHandleAddr, 'Parent');
	        fromAddr = [parentAddr '/' cleanName(AddrName) '_sm' int2str(dpramWOROidx)];
	        fromAddrSlice = [parentAddr '/' cleanName(AddrName) '_slice_sm' int2str(dpramWOROidx)];
	        fromAddrSliceBits = get_param(SrcBlockHandleAddr, 'n_bits');
	        
	        DataIName = get_param(SrcBlockHandleDataI, 'Name');
	        CompDataIName = [DataIName '          '];
	        DataIFullName = [get_param(SrcBlockHandleDataI, 'Parent') '/' DataIName];
	        orientationDataI = get_param(SrcBlockHandleDataI, 'Orientation');
	        placeDataI = get_param(SrcBlockHandleDataI, 'position');
	        parentDataI = get_param(SrcBlockHandleDataI, 'Parent');
	        fromDataI = [parentAddr '/' cleanName(DataIName) '_sm' int2str(dpramWOROidx)];
	        
	        WEName = get_param(SrcBlockHandleWE, 'Name');
	        CompWEName = [WEName '       '];
	        WEFullName = [get_param(SrcBlockHandleWE, 'Parent') '/' WEName];
	        orientationWE = get_param(SrcBlockHandleWE, 'Orientation');
	        placeWE = get_param(SrcBlockHandleWE, 'position');
	        parentWE = get_param(SrcBlockHandleWE, 'Parent');
	        fromWE = [parentWE '/' cleanName(WEName) '_sm' int2str(dpramWOROidx)];
	        
	    end

	    if strcmp(compName(1:5), 'SMWO_')
	        if ~strcmp(CompAddrName(1:9), 'SMWOAddr_')
	            display(['The Gateway In ' AddrName ' needs to have the prefix of SMWOAddr_']);
	            return;
	        end
	        
	        %%%%% SMWOAddr %%%%%%
	        % Delete the GatewayIn
	        delete_block(SrcBlockHandleAddr);

	        
	        deleteSource(sys, cleanName(AddrName));
	        
	        % Find the broken lines that starts from the output port of the
	        % deleted GatewayIn
	        brokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'SrcBlockHandle', -1);

	        % Find out the handle of the port and the block
	        % These two handles will be used to extract more information
	        DstPortHandle = get_param(brokenlines, 'DstPortHandle');
	        DstBlockHandle = get_param(brokenlines, 'DstBlockHandle');

	        % From DstPortHandle, we can find out what is
	        % the destination port number
	        if length(DstPortHandle) > 1
	            DstPortNumber = cell2mat(get_param(DstPortHandle{length(DstPortHandle)}, 'PortNumber'));
	        else
	            DstPortNumber = get_param(DstPortHandle, 'PortNumber');
	        end

	        % From DstBlockHandle, we can find out what is the name of the
	        % destination block
	        if length(DstBlockHandle) > 1
	            DstName = get_param(DstBlockHandle{length(DstBlockHandle)}, 'Name');
	            try
	                DstBlockType = get_param(DstBlockHandle{length(DstBlockHandle)}, 'block_type');
	            catch
	                DstBlockType = get_param(DstBlockHandle{length(DstBlockHandle)}, 'BlockType');
	            end
	        else
	            DstName = get_param(DstBlockHandle, 'Name');
	            try
	                DstBlockType = get_param(DstBlockHandle, 'block_type');
	            catch
	                DstBlockType = get_param(DstBlockHandle, 'BlockType');
	            end
	        end

	        % Delete the borken lines
	        delete_line(brokenlines);

	        dpramWOAddrIndex = dpramWOAddrIndex + 1;
	        dpramWOAddr{dpramWOAddrIndex} = fromAddr;
	        %placeAddr(1,1) = placeAddr(1,1) - 60;
	        placeAddr(1,3) = placeAddr(1,1) + 75;
	        placeAddrSlice = placeAddr;
	        placeAddrSlice(1,1) = placeAddrSlice(1,3) + 30;
	        placeAddrSlice(1,3) = placeAddrSlice(1,1) + 50;
	        add_block('built-in/From', fromAddr, 'GotoTag', ['SMWOAddr_' int2str(dpramWOAddrIndex - 1)], 'position', placeAddr);
	        if ((version == 8.1) | (version == 8.2) | (version == 9.1))
	            add_block([spm '/Slice8'], fromAddrSlice, 'position', placeAddrSlice, 'nbits', fromAddrSliceBits);
	        end
	                                
	        FromName = get_param(fromAddr, 'Name');
	        FromSliceName = get_param(fromAddrSlice, 'Name');
	        set_param(fromAddr,'Orientation', orientationAddr);

	        add_line(parentAddr, [FromName '/1' ], [FromSliceName '/1']);
	        if size(DstName, 1) == 1
	            
	            add_line(parentAddr, [FromSliceName '/1'], [DstName '/' int2str(DstPortNumber)]);
	            %add_line(parentAddr, [FromName '/1' ], [DstName '/' int2str(DstPortNumber)]);
	        else
	            for i=1:size(DstName, 1)
	                if ~strcmp(DstName{i}, get_param(dpramName, 'Name'))
	                    add_line(parentAddr, [FromName '/1'], [DstName{i} '/' mat2str(DstPortNumber(i))]);
	                else
	                    add_line(parentAddr, [FromSliceName '/1'], [DstName{i} '/' mat2str(DstPortNumber(i))]);
	                end
	            end
	        end
	        
	        %%%%% SMWODataI %%%%%%
	        if ~strcmp(get_param(SrcBlockHandleDataI, 'block_type'), 'gatewayin')
	            display(['A Gateway In is needed in order to connect to the datb inport of the dpram ' dpramName '.']);
	            return;
	        end
	        if ~strcmp(get_param(SrcBlockHandleDataI, 'n_bits'), '32')
	            display(['The Xilinx block ' DataIFullName ' needs to set the number of bits to 32.']);
	            return;
	        end
	        if ~strcmp(CompDataIName(1:10), 'SMWODataI_')
	            display(['The Xilinx block ' DataIName ' needs to have a prefix of SMWODataI_']);
	            return;
	        end
	        SMWODataIArithType = get_param(SrcBlockHandleDataI, 'arith_type');
	        SMWODataIArithType = [SMWODataIArithType '      '];
	        SMWODataIArithType = SMWODataIArithType(1:8);
	        if strcmp(SMWODataIArithType, 'Unsigned')
	           fromDataIForce = [parentAddr '/' cleanName(DataIName) '_force_sm' int2str(dpramWOROidx)];
	        end
	        
	        % Delete the GatewayIn
	        delete_block(SrcBlockHandleDataI);

	        deleteSource(sys, cleanName(DataIName));
	        
	        % Find the broken lines that starts from the output port of the
	        % deleted GatewayIn
	        brokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'SrcBlockHandle', -1);

	        % Find out the handle of the port and the block
	        % These two handles will be used to extract more information
	        DstPortHandle = get_param(brokenlines, 'DstPortHandle');
	        DstBlockHandle = get_param(brokenlines, 'DstBlockHandle');

	        % From DstPortHandle, we can find out what is
	        % the destination port number
	        if length(DstPortHandle) > 1
	            DstPortNumber = cell2mat(get_param(DstPortHandle{length(DstPortHandle)}, 'PortNumber'));
	        else
	            DstPortNumber = get_param(DstPortHandle, 'PortNumber');
	        end

	        % From DstBlockHandle, we can find otu what is the name of the
	        % destination block
	        if length(DstBlockHandle) > 1
	            DstName = get_param(DstBlockHandle{length(DstBlockHandle)}, 'Name');
	            try
	                DstBlockType = get_param(DstBlockHandle{length(DstBlockHandle)}, 'block_type');
	            catch
	                DstBlockType = get_param(DstBlockHandle{length(DstBlockHandle)}, 'BlockType');
	            end
	        else
	            DstName = get_param(DstBlockHandle, 'Name');
	            try
	                DstBlockType = get_param(DstBlockHandle, 'block_type');
	            catch
	                DstBlockType = get_param(DstBlockHandle, 'BlockType');
	            end
	        end

	        % Delete the borken lines
	        delete_line(brokenlines);
	        
	        dpramWODataIIndex = dpramWODataIIndex + 1;
	        dpramWODataI{dpramWODataIIndex} = fromDataI;
	        
	        if strcmp(SMWODataIArithType, 'Unsigned')
	            %placeDataI(1,1) = placeDataI(1,1) + 75;
	            placeDataIForce = placeDataI;
	            placeDataIForce(1,1) = placeDataIForce(1,3) + 30;
	            placeDataIForce(1,3) = placeDataIForce(1,1) + 50;
	            add_block('built-in/From', fromDataI, 'GotoTag', ['SMWODataI_' int2str(dpramWODataIIndex - 1)], 'position', placeDataI);
	            add_block([spm '/Force8'], fromDataIForce, 'position', placeDataIForce); 
	           
	            FromName = get_param(fromDataI, 'Name');
	            FromForceName = get_param(fromDataIForce, 'Name');
	            set_param(fromDataI, 'Orientation', orientationDataI);
	            
	            add_line(parentAddr, [FromName '/1' ], [FromForceName '/1']);
	            if size(DstName, 1) == 1

	                add_line(parentAddr, [FromForceName '/1'], [DstName '/' int2str(DstPortNumber)]);
	                %add_line(parentAddr, [FromName '/1' ], [DstName '/' int2str(DstPortNumber)]);
	            else
	                for i=1:size(DstName, 1)
	                    if ~strcmp(DstName{i}, get_param(dpramName, 'Name'))
	                        add_line(parentAddr, [FromName '/1'], [DstName{i} '/' mat2str(DstPortNumber(i))]);
	                    else
	                        add_line(parentAddr, [FromForceName '/1'], [DstName{i} '/' mat2str(DstPortNumber(i))]);
	                    end
	                end
	            end
	        else            
	            placeDataI(1,1) = placeDataI(1,1) - 60;
	            add_block('built-in/From', fromDataI, 'GotoTag', ['SMWODataI_' int2str(dpramWODataIIndex - 1)], 'position', placeDataI);

	            FromName = get_param(fromDataI, 'Name');
	            set_param(fromDataI,'Orientation', orientationDataI);

	            if size(DstName, 1) == 1
	                add_line(parentDataI, [FromName '/1' ], [DstName '/' int2str(DstPortNumber)]);
	            else
	                for i=1:size(DstName, 1)
	                    add_line(parentDataI, [FromName '/1'], [DstName{i} '/' mat2str(DstPortNumber(i))]);
	                end
	            end
	        end
	        
	        %%%%% SMWOWE %%%%%
	        if ~strcmp(get_param(SrcBlockHandleWE, 'block_type'), 'gatewayin') 
	            display(['A Gateway In is needed in order to connect to the web inport of the dpram ' dpramName '.']); 
 	            return; 
	 	    end 
	        if ~strcmp(CompWEName(1:7), 'SMWOWE_')
	            display(['The Gateway In ', WEName ' needs to have the prefix SMWOWE_']);
	            return;
	        end
	        if ~strcmp(get_param(SrcBlockHandleWE, 'arith_type'), 'Boolean')
	            display(['The GatewayIn ' WEFullName ' needs to have an Output type of Boolean.']);
	            return;
	        end
	        
	        % Delete the GatewayIn
	        delete_block(SrcBlockHandleWE);

	        deleteSource(sys, cleanName(WEName));
	        
	        % Find the broken lines that starts from the output port of the
	        % deleted GatewayIn
	        brokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'SrcBlockHandle', -1);

	        % Find out the handle of the port and the block
	        % These two handles will be used to extract more information
	        DstPortHandle = get_param(brokenlines, 'DstPortHandle');
	        DstBlockHandle = get_param(brokenlines, 'DstBlockHandle');

	        % From DstPortHandle, we can find out what is
	        % the destination port number
	        if length(DstPortHandle) > 1
	            DstPortNumber = cell2mat(get_param(DstPortHandle{length(DstPortHandle)}, 'PortNumber'));
	        else
	            DstPortNumber = get_param(DstPortHandle, 'PortNumber');
	        end

	        % From DstBlockHandle, we can find out what is the name of the
	        % destination block
	        if length(DstBlockHandle) > 1
	            DstName = get_param(DstBlockHandle{length(DstBlockHandle)}, 'Name');
	            try
	                DstBlockType = get_param(DstBlockHandle{length(DstBlockHandle)}, 'block_type');
	            catch
	                DstBlockType = get_param(DstBlockHandle{length(DstBlockHandle)}, 'BlockType');
	            end
	        else
	            DstName = get_param(DstBlockHandle, 'Name');
	            try
	                DstBlockType = get_param(DstBlockHandle, 'block_type');
	            catch
	                DstBlockType = get_param(DstBlockHandle, 'BlockType');
	            end
	        end

	        % Delete the borken lines
	        delete_line(brokenlines);

	        dpramWOWEIndex = dpramWOWEIndex + 1;
	        dpramWOWE{dpramWOWEIndex} = fromWE;
	        placeWE(1,1) = placeWE(1,1) - 60;
	        add_block('built-in/From', fromWE, 'GotoTag', ['SMWOWE_' int2str(dpramWOWEIndex - 1)], 'position', placeWE);
	        
	        FromName = get_param(fromWE, 'Name');
	        set_param(fromWE,'Orientation', orientationWE);

	        if size(DstName, 1) == 1
	            add_line(parentWE, [FromName '/1' ], [DstName '/' int2str(DstPortNumber)]);
	        else
	            for i=1:size(DstName, 1)
	                add_line(parentWE, [FromName '/1'], [DstName{i} '/' mat2str(DstPortNumber(i))]);
	            end
	        end
	        

	    elseif strcmp(compName(1:5), 'SMRO_')        
	        dpramROIndex = dpramROIndex + 1;
	        
	        DstBlockHandleDataO = get_param(get_param(ports(4), 'Line'), 'DstBlockHandle');
	        
	        
	        %%%%%% SMROAddr %%%%%
	        if ~strcmp(CompAddrName(1:9), 'SMROAddr_')
	            display(['The Gateway In ' AddrName ' needs to have the prefix of SMROAddr_']);
	            return;
	        end
	        
	        % Delete the GatewayIn
	        delete_block(SrcBlockHandleAddr);

	        deleteSource(sys, cleanName(AddrName));
	        
	        % Find the broken lines that starts from the output port of the
	        % deleted GatewayIn
	        brokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'SrcBlockHandle', -1);

	        % Find out the handle of the port and the block
	        % These two handles will be used to extract more information
	        DstPortHandle = get_param(brokenlines, 'DstPortHandle');
	        DstBlockHandle = get_param(brokenlines, 'DstBlockHandle');

	        % From DstPortHandle, we can find out what is
	        % the destination port number
	        if length(DstPortHandle) > 1
	            DstPortNumber = cell2mat(get_param(DstPortHandle{length(DstPortHandle)}, 'PortNumber'));
	        else
	            DstPortNumber = get_param(DstPortHandle, 'PortNumber');
	        end

	        % From DstBlockHandle, we can find out what is the name of the
	        % destination block
	        if length(DstBlockHandle) > 1
	            DstName = get_param(DstBlockHandle{length(DstBlockHandle)}, 'Name');
	            try
	                DstBlockType = get_param(DstBlockHandle{length(DstBlockHandle)}, 'block_type');
	            catch
	                DstBlockType = get_param(DstBlockHandle{length(DstBlockHandle)}, 'BlockType');
	            end
	        else
	            DstName = get_param(DstBlockHandle, 'Name');
	            try
	                DstBlockType = get_param(DstBlockHandle, 'block_type');
	            catch
	                DstBlockType = get_param(DstBlockHandle, 'BlockType');
	            end
	        end

	        % Delete the borken lines
	        delete_line(brokenlines);

	        dpramROAddrIndex = dpramROAddrIndex + 1;
	        dpramROAddr{dpramROAddrIndex} = fromAddr;
	        %placeAddr(1,1) = placeAddr(1,1) - 60;
	        placeAddr(1,3) = placeAddr(1,1) + 75;
	        placeAddrSlice = placeAddr;
	        placeAddrSlice(1,1) = placeAddrSlice(1,3) + 30;
	        placeAddrSlice(1,3) = placeAddrSlice(1,1) + 50;
	        add_block('built-in/From', fromAddr, 'GotoTag', ['SMROAddr_' int2str(dpramROAddrIndex - 1)], 'position', placeAddr);
	        
	        if(( version == 8.1) | (version == 8.2) | (version == 9.1))
	            add_block([spm '/Slice8'], fromAddrSlice, 'position', placeAddrSlice, 'nbits', fromAddrSliceBits);
	        end
	        
	        FromName = get_param(fromAddr, 'Name');
	        FromSliceName = get_param(fromAddrSlice, 'Name');
	        set_param(fromAddr,'Orientation', orientationAddr);

	        add_line(parentAddr, [FromName '/1' ], [FromSliceName '/1']);
	        if size(DstName, 1) == 1
	            
	            add_line(parentAddr, [FromSliceName '/1'], [DstName '/' int2str(DstPortNumber)]);
	            %add_line(parentAddr, [FromName '/1' ], [DstName '/' int2str(DstPortNumber)]);
	        else
	            for i=1:size(DstName, 1)
	                if ~strcmp(DstName{i}, get_param(dpramName, 'Name'))
	                    add_line(parentAddr, [FromName '/1'], [DstName{i} '/' mat2str(DstPortNumber(i))]);
	                else
	                    add_line(parentAddr, [FromSliceName '/1'], [DstName{i} '/' mat2str(DstPortNumber(i))]);
	                end
	            end
	        end

	        if ~strcmp(get_param(SrcBlockHandleDataI, 'block_type'), 'constant')
	            display(['A Xilinx constant is needed in order to connect to the dinb inport of the dpram ' dpramName '.']);
	            return;
	        end
	        if ~strcmp(CompDataIName(1:10), 'SMRODataI_')
	            display(['The Xilinx block ' DataIName ' needs to have a prefix of SMRODataI_']);
	            return;
	        end
	        if (str2num(get_param(SrcBlockHandleDataI, 'const')) ~= 0) | ~strcmp(get_param(SrcBlockHandleDataI, 'n_bits'), '32')
	            display(['The Xilinx constant ' DataIFullName ' needs to have a constant value of zero. Number of bits needs to be 32.']);
	            return;
	        end

	        if ~strcmp(get_param(SrcBlockHandleWE, 'block_type'), 'constant')
	            display(['A Xilinx constant is needed in order to connect to the web inport of the dpram ' dpramName '.']);
	            return;
	        end
	        if ~strcmp(CompWEName(1:7), 'SMROWE_')
	            display(['The Gateway In ', WEName ' needs to have the prefix SMROWE_']);
	            return;
	        end
	        if (str2num(get_param(SrcBlockHandleWE, 'const')) ~=0) | (~strcmp(get_param(SrcBlockHandleWE, 'arith_type'), 'Boolean'))
	            display(['The Xilinx constant ' WEFullName ' needs to be a Boolean constant with a value of zero.']);
	            return;
	        end

	        %%%%% SMRODataO %%%%%
	        DataOName = get_param(DstBlockHandleDataO, 'Name');
	        DataONameIdx = 1;
	        if length(DstBlockHandleDataO) == 1
	            CompDataOName = [DataOName '          '];
	            DataOFullName = [get_param(DstBlockHandleDataO, 'Parent') '/' DataOName];
	        else
	            for i=1:length(DstBlockHandleDataO)
	                CompDataOName{i} = [DataOName{i} '          '];
	                DataOFullName{i} = [get_param(DstBlockHandleDataO(i), 'Parent') '/' DataOName{i}];                           
	            end
	        end
	        
	        IsGatewayOut = false;
	        
	        for d=1:length(DstBlockHandleDataO)
	            if strcmp(get_param(DstBlockHandleDataO(d), 'block_type'), 'gatewayout')
	                IsGatewayOut = true;

	                if length(DstBlockHandleDataO) == 1
	                    currentCompDataOName = CompDataOName;
	                else
	                    currentCompDataOName = CompDataOName{d};
	                end
	                    
	                if ~strcmp(currentCompDataOName(1:10), 'SMRODataO_')
	                    display(['The Gateway Out ', DataOName ' needs to have a prefix of SMRODataO_']);
	                    return;
	                end
	                idxDataO = d;
	            end
	        end
	        if IsGatewayOut == false
	            display(['A GatewayOut is needed in order to connect to the B outport of the dpram ' dpramName '.']);
	            return;
	        end
	        
	        if length(DstBlockHandleDataO) > 1
	            DataOFullName = DataOFullName{idxDataO};
	        end
	        
	        DataOName = get_param(DataOFullName, 'Name');
	        orientationDataO = get_param(DataOFullName, 'Orientation');
	        placeDataO = get_param(DataOFullName, 'position');
	        parentDataO = get_param(DataOFullName, 'Parent');
	        gotoDataO = [parentDataO '/' cleanName(DataOName) '_sm' int2str(dpramWOROidx)];
	        
	        % Delete the block
	        delete_block(DataOFullName);
	        
	        deleteSink(sys, cleanName(DataOName));
	        
	        brokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'DstBlockHandle', -1);

	        % Find out the handle of the port
	        % This will be used to extract the port number
	        SrcPortHandle = get_param(brokenlines, 'SrcPortHandle');
	        SrcPortNumber = get_param(SrcPortHandle, 'PortNumber');

	        % Find out the handle of the block
	        % This will be used to extract the name of the block
	        % This will also be used to extract the block type of the source
	        SrcBlockHandle = get_param(brokenlines, 'SrcBlockHandle');
	        SrcName = get_param(SrcBlockHandle, 'Name');
	        try
	            SrcBlockType = get_param(SrcBlockHandle, 'block_type');
	        catch
	            SrcBlockType = get_param(SrcBlockHandle, 'BlockType');
	        end

	        % Delete the broken line(s)
	        delete_line(brokenlines);
	        
	        dpramRODataOIndex = dpramRODataOIndex + 1;
	        dpramRODataO{dpramRODataOIndex} = gotoDataO;
	        placeDataO(1,3) = placeDataO(1,3) + 60;
	        add_block('built-in/Goto', gotoDataO, 'GotoTag', ['SMRODataO_' int2str(dpramRODataOIndex - 1)], 'TagVisibility', 'global', 'position', placeDataO);
	        
	         % Get the name of the Goto block
	        GotoName = get_param(gotoDataO, 'Name');

	        % Set the orientation
	        set_param(gotoDataO,'Orientation',orientationDataO);

	        % Connect a line from the source to the Goto block
	        add_line(parentDataO, [SrcName '/' int2str(SrcPortNumber)], [GotoName '/1']);
	        
	    end
	end
end

gatewaysIn = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',   'block_type','fromreg');
gatewaysOut = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',   'block_type','toreg');

% Delete all broken lines
brokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'SrcBlockHandle', -1);
delete_line(brokenlines);
brokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'DstBlockHandle', -1);
delete_line(brokenlines);

% gatesIn will hold the final list of all GatewaysIn 
% that are converted to registers
gatesIn={}; 
gatesIn_info = struct('arith_type',{},'nbits',{},'binpt',{},'initvalue',{});
validGates = 0;
fReg={};

% Take every gateway (except the last one) and look at the 
% names after it to see if there is a repeat
for c=1:length(gatewaysIn)  
	% gateName will contain the full path of the gate
	gateName = gatewaysIn{c};
	    
	ftregsmName = get_param(gateName, 'shared_memory_name');
	ftregsmName = ftregsmName(2:length(ftregsmName)-1);
	
	% shortName will contain only the name of the gate
	shortName = get_param(gateName,'Name');
	
	%compName will be used to verify whether there is the prefix no_reg_ 
	compName = [shortName '         '];
	
	if ~strcmp(compName(1:7), 'no_reg_')  %does this need to be a register?

	    % Find the orientation, position, and parent of the GatewayIn
	    orientation = get_param(gateName, 'Orientation');
	    place = get_param(gateName, 'position');
	    parent = get_param(gateName, 'Parent');

	    % Find the arith_type, number of bits, and bin_pt
	    % This will be stored into a struct
	    arithType = get_param(gateName, 'arith_type');
	    nBits = get_param(gateName, 'n_bits');
	    binPt = get_param(gateName, 'bin_pt');
	    initValue = '0';
	   
		initValue = num2str(get_param(gateName, 'init'));

	    % from is the full path name of the From block
	    % from = [get_param(gateName,'Parent') '/' cleanName(get_param(gateName,'Name'))];
	    from = [get_param(gateName,'Parent') '/' cleanName(get_param(gateName,'Name')) '_opb' int2str(validGates)];
	    

		% Delete the GatewayIn
		delete_block(gateName);

		% Find connected sources to the deleted GatewaysIn
		% If there are sources that are connected to the GatewayIn, append
		% the name of the gateway in to the source name
		% Also check if the source block type is a constant
		% If it is a constant, we will want to store the constant value
		% into the struct gatesIn_info.
		srcbrokenlines = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'DstBlockHandle', -1);
		if length(srcbrokenlines) > 0
			% We have a source that was connected to the gateway in
			% Get the handle of the source block
			SrcBlockHandle = get_param(srcbrokenlines, 'SrcBlockHandle');
			% Get the block type of the handle
			SrcBlockType = get_param(SrcBlockHandle, 'BlockType');

			% If the block type is a constant, we will want to store the
			% constant value into initValue
			if strcmp(SrcBlockType, 'Constant')
				initValue = num2str(get_param(SrcBlockHandle, 'Value'));
				%gatesIn_info = setfield(gatesIn_info, {validGates}, 'initvalue', num2str(get_param(SrcBlockHandle, 'Value')));
			end

			% Get the name of the source. The name of the GatewayIn will be
			% appended to the name of the source
			SrcName = get_param(SrcBlockHandle, 'name');
			set_param(SrcBlockHandle, 'name', [SrcName '_' cleanName(shortName)]);
			delete_line(srcbrokenlines);
		end

		% Find the broken lines that starts from the output port of the
		% deleted GatewayIn
		brokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'SrcBlockHandle', -1);

		% Find out the handle of the port and the block
		% These two handles will be used to extract more information
		DstPortHandle = get_param(brokenlines, 'DstPortHandle');
		DstBlockHandle = get_param(brokenlines, 'DstBlockHandle');

		% From DstPortHandle, we can find out what is
		% the destination port number
		if length(DstPortHandle) > 1
			DstPortNumber = cell2mat(get_param(DstPortHandle{length(DstPortHandle)}, 'PortNumber'));
		else
			DstPortNumber = get_param(DstPortHandle, 'PortNumber');
		end

		% From DstBlockHandle, we can find otu what is the name of the
		% destination block
		if length(DstBlockHandle) > 1
			DstName = get_param(DstBlockHandle{length(DstBlockHandle)}, 'Name');
			try
				DstBlockType = get_param(DstBlockHandle{length(DstBlockHandle)}, 'block_type');
			catch
				DstBlockType = get_param(DstBlockHandle{length(DstBlockHandle)}, 'BlockType');
			end
		else
			DstName = get_param(DstBlockHandle, 'Name');
			try
				DstBlockType = get_param(DstBlockHandle, 'block_type');
			catch
				DstBlockType = get_param(DstBlockHandle, 'BlockType');
			end
		end

		% Delete the borken lines
		delete_line(brokenlines);

		validGates = validGates + 1;
		gatesIn_info = setfield(gatesIn_info, {validGates}, 'arith_type', arithType);
		gatesIn_info = setfield(gatesIn_info, {validGates}, 'nbits', nBits);
		gatesIn_info = setfield(gatesIn_info, {validGates}, 'binpt', binPt);
		gatesIn_info = setfield(gatesIn_info, {validGates}, 'initvalue', initValue);
		% gatesIn{validGates} = cleanName(gateName);
		gatesIn{validGates} = cleanName([gateName '_opb' int2str(validGates - 1)]);

		fReg{validGates} = cleanName([ftregsmName '_opb' int2str(validGates - 1)]);

		add_block('built-in/From', from,'GotoTag', ['in_' int2str(validGates-1)], 'position', place);


		FromName = get_param(from, 'Name');
		set_param(from,'Orientation',orientation);

		if size(DstName, 1) == 1
			add_line(parent, [FromName '/1' ], [DstName '/' int2str(DstPortNumber)]);
		else
			for i=1:size(DstName, 1)                    
				add_line(parent, [FromName '/1'], [DstName{i} '/' mat2str(DstPortNumber(i))]);
			end
		end

	    idx=0;  %appended to the end of a duplicate name
	    for d=c+1:length(gatewaysIn)
	        gateName2 = gatewaysIn{d};
	        shortName2 = get_param(gateName2,'Name');
	        if length(shortName2) < 7
	            compName2 = [shortName2 '         '];
	        else
	            compName2 = shortName2;
	        end
	        
	        if strcmp(cleanName(shortName),cleanName(shortName2)) | strcmp(cleanName(shortName), [appendString cleanName(compName2(8 : length(compName2)))])                                
	            set_param(gateName2,'Name', [shortName2 '_' int2str(idx)]);
	            gatewaysIn{d} = [gatewaysIn{d} '_' int2str(idx)];
	            idx=idx+1;
	        end
	    end
	else
	    newGateName = [appendString shortName(8 : length(shortName))];
	    
	    idx=1;  %appended to the end of a duplicate name
	    for d=c+1:length(gatewaysIn)
	        gateName2 = gatewaysIn{d};
	        shortName2 = get_param(gateName2,'Name');
	        if length(shortName2) < 7
	            compName2 = [shortName2 '         '];
	        else
	            compName2 = shortName2;
	        end
	        
	        if strcmp(cleanName(newGateName),cleanName(shortName2)) | strcmp(cleanName(newGateName), [appendString cleanName(compName2(8 : length(compName2)))])                
	            if idx == 1
	                set_param(gateName, 'Name', [newGateName '_' int2str(0)]);
	            end
	            
	            set_param(gateName2, 'Name', [shortName2 '_' int2str(idx)]);
	            gatewaysIn{d} = [gatewaysIn{d} '_' int2str(idx)];
	            idx = idx+1;
	        end
	    end
	    if idx == 1
	        set_param(gateName, 'Name', newGateName);    
	    end
	end
end


% Delete all broken lines
brokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'SrcBlockHandle', -1);
delete_line(brokenlines);
brokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'DstBlockHandle', -1);
delete_line(brokenlines);

gatesOut={}; %will hold final list of all gateways intented to map into registers
validGates = 0;
tReg={};

for c=1:length(gatewaysOut)  %take every gateway (except the last one) and look at the names after it to see if there is a repeat
	gateName = gatewaysOut{c};
	shortName = get_param(gateName,'Name');
	compName = [shortName '          '];
	
	ftregsmName = get_param(gateName, 'shared_memory_name');
	ftregsmName = ftregsmName(2:length(ftregsmName)-1);
	
    hdlPortStatus = 1;
	
	if hdlPortStatus && ~strcmp(compName(1:7), 'no_reg_')  %does this need to be a register?
	    
	    % Get the orientation, position, and parent of the GatewayOut
	    orientation = get_param(gateName, 'Orientation');
	    place = get_param(gateName,'position');
	    parent = get_param(gateName, 'Parent');
	    
	    % goto is the full path name of the Goto block
	    % goto = [get_param(gateName,'Parent')  '/' cleanName(get_param(gateName,'Name'))];
	    goto = [get_param(gateName,'Parent')  '/' cleanName(get_param(gateName,'Name')) '_opb' int2str(validGates)];
	    
		% Delete the block
		delete_block(gateName);

		% Find connected sinks to GatewayOut
		% If there are sinks that are connected to the GatewayOut, append
		% the name of the GatewayOut to the sink name
		dstbrokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'SrcBlockHandle', -1);
		if length(dstbrokenlines) > 0
			% We have a sink that was connected to the GatewayOut
			DstBlockHandle = get_param(dstbrokenlines, 'DstBlockHandle');

			if length(DstBlockHandle) > 1
				for i=1:(length(DstBlockHandle) - 1)
					DstName = get_param(DstBlockHandle{i}, 'Name');
					set_param(DstBlockHandle{i}, 'name', [DstName '_' cleanName(shortName)]);
				end
				delete_line(dstbrokenlines);
			else
				DstName = get_param(DstBlockHandle, 'name');
				set_param(DstBlockHandle, 'name', [DstName '_' cleanName(shortName)]);
				delete_line(dstbrokenlines);
			end 
		end

		brokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'DstBlockHandle', -1);

		validGates=validGates+1;
		% gatesOut{validGates} = cleanName(gateName);
		% reggoto = [parent  '/' cleanName(shortName)];
		% engoto = [parent '/enable_' cleanName(shortName)];

		gatesOut{validGates} = cleanName([gateName '_opb' int2str(validGates-1)]);

		tReg{validGates} = cleanName([ftregsmName '_opb' int2str(validGates - 1)]);

		reggoto = [parent  '/' cleanName([shortName '_opb' int2str(validGates-1)])];
		engoto = [parent '/enable_' cleanName([shortName '_opb' int2str(validGates-1)])]; 

		if length(brokenlines) == 2
			pos1 = get_param(brokenlines(1), 'points');
			pos2 = get_param(brokenlines(2), 'points');

			SrcPortHandle1 = get_param(brokenlines(1), 'SrcPortHandle');
			SrcPortHandle2 = get_param(brokenlines(2), 'SrcPortHandle');

			SrcPortNumber1 = get_param(SrcPortHandle1, 'PortNumber');
			SrcPortNumber2 = get_param(SrcPortHandle2, 'PortNumber');

			SrcBlockHandle1 = get_param(brokenlines(1), 'SrcBlockHandle');
			SrcBlockHandle2 = get_param(brokenlines(2), 'SrcBlockHandle');

			SrcName1 = get_param(SrcBlockHandle1, 'Name');
			SrcName2 = get_param(SrcBlockHandle2, 'Name');

			DstPortHandle1 = get_param(brokenlines(1), 'DstPortHandle');
			DstPortHandle2 = get_param(brokenlines(2), 'DstPortHandle');

			add_block('built-in/Goto', reggoto,'GotoTag', ['out_' int2str(length(gatesIn)+validGates-1)], 'TagVisibility', 'global', 'position', place);
			add_block('built-in/Goto', engoto,'GotoTag', ['en_out_' int2str(length(gatesIn)+validGates-1)], 'TagVisibility', 'global', 'position', place);
			set_param(reggoto,'Orientation', orientation);
			set_param(engoto, 'Orientation', orientation);
			regname = get_param(reggoto, 'Name');
			enname = get_param(engoto, 'Name');

			delete_line(brokenlines(1));
			delete_line(brokenlines(2));

			if strcmp(orientation, 'right') | strcmp(orientation, 'left')
				if pos1(length(pos1),2) < pos2(length(pos2),2)
					add_line(parent, [SrcName1 '/' int2str(SrcPortNumber1)], [regname '/1']);
					add_line(parent, [SrcName2 '/' int2str(SrcPortNumber2)], [enname '/1']);
				else
					add_line(parent, [SrcName2 '/' int2str(SrcPortNumber2)], [regname '/1']);
					add_line(parent, [SrcName1 '/' int2str(SrcPortNumber1)], [enname '/1']);
				end
			else
				if pos1(length(pos1),1) < pos2(length(pos2),1)
					add_line(parent, [SrcName1 '/' int2str(SrcPortNumber1)], [regname '/1']);
					add_line(parent, [SrcName2 '/' int2str(SrcPortNumber2)], [enname '/1']);
				else
					add_line(parent, [SrcName2 '/' int2str(SrcPortNumber2)], [regname '/1']);
					add_line(parent, [SrcName1 '/' int2str(SrcPortNumber1)], [enname '/1']);
				end
			end
		else
			disp('Error: Too many broken lines');
			return;
		end

	    idx=0;  %appended to the end of a duplicate name
	    for d=c+1:length(gatewaysOut)
	        gateName2 = gatewaysOut{d};
	        shortName2 = get_param(gateName2,'Name');
	        if length(shortName2) < 7
	            compName2 = [shortName2 '         '];
	        else
	            compName2 = shortName2;
	        end
	        
	        if strcmp(cleanName(shortName),cleanName(shortName2)) | strcmp(cleanName(shortName), [appendString cleanName(compName2(8 : length(compName2)))])
	            set_param(gateName2,'Name', [shortName2 '_' int2str(idx)]);
	            gatewaysOut{d} = [gatewaysOut{d} '_' int2str(idx)];
	            idx=idx+1;
	        end
	    end
	elseif strcmp(compName(1:7), 'no_reg_')
	    newGateName = [appendString shortName(8 : length(shortName))];
	    
	    idx=1;  %appended to the end of a duplicate name
	    for d=c+1:length(gatewaysOut)
	        gateName2 = gatewaysOut{d};
	        shortName2 = get_param(gateName2,'Name');
	        if length(shortName2) < 7
	            compName2 = [shortName2 '         '];
	        else
	            compName2 = shortName2;
	        end
	        
	        if strcmp(cleanName(newGateName),cleanName(shortName2)) | strcmp(cleanName(newGateName), [appendString cleanName(compName2(8 : length(compName2)))])                
	            if idx == 1
	                set_param(gateName, 'Name', [newGateName '_' int2str(0)]);
	            end
	            
	            set_param(gateName2, 'Name', [shortName2 '_' int2str(idx)]);
	            gatewaysIn{d} = [gatewaysIn{d} '_' int2str(idx)];
	            idx = idx+1;
	        end
	    end
	    if idx == 1
	        set_param(gateName, 'Name', newGateName);    
	    end
	end
end

% Check to make sure that we have at least one GatewayIn and one GatewayOut
% that will convert to registers
if length(gatesIn)==0 | length(gatesOut)==0
	close_system(sys, 0);
	display('Error: We need at least one From Register that will convert to register and one To Register that will convert to register');	
	return;
end

% Delete all broken lines
brokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'SrcBlockHandle', -1);
delete_line(brokenlines);
brokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'DstBlockHandle', -1);
delete_line(brokenlines);

%   now to make the new i/o subsystem
script1 = get_param(sys,'preloadfcn');
script2 = get_param(sys,'initfcn');
script3 = get_param(sys,'startfcn');          %first get all of the information needed from the init scripts for the model
try
	run(script1);
	run(script2);
	run(script3);
catch
end

% Add in the memory mapped IO from the skeleton model
try
	add_block([spm '/main8'], [sys '/Memory Mapped I_O']);
catch
	display('You already have converted this design to a peripheral.');
	display('Please get rid of the Memory Mapped I_O block and make sure')
	display('your gateways are all still in place before trying again.');
	return;
end
add_block([spm '/addr_from'], [sys '/addr_from']);
add_block([spm '/a_valid_from'], [sys '/a_valid_from']);
add_block([spm '/p_select8'], [sys '/p_select'], 'Position', [100 236 160 274]);

add_block([spm '/ps_goto'], [sys '/ps_goto']);
add_line(sys, 'addr_from/1', 'p_select/1');
add_line(sys, 'a_valid_from/1', 'p_select/2');
add_line(sys, 'p_select/1', 'ps_goto/1');
ref = [sys '/Memory Mapped I_O'];

set_param([sys '/p_select'], 'C_BASE', int2str(base)); %sets the base address according to the input parameter
%set_param([sys '/p_select'], 'C_HIGH', int2str(base+4*(length(gatesIn)+length(gatesOut)-1))); %sets the high address given number of inputs and outputs
try
	HighAddress =  base +(length(dpramWORO)+1)*hex2dec('10000') - 1;
catch
	HighAddress = base + hex2dec('FFFF');
end
set_param([sys '/p_select'], 'C_HIGH', int2str(HighAddress));

if strcmp(smChoice, 'smon')
	for c=0:(length(dpramWODataI) - 1)
	   goto = [ref  '/' 'SMWODataI_' int2str(c)];
	   add_block('built-in/Goto', goto, 'GotoTag', ['SMWODataI_' int2str(c)], 'TagVisibility', 'global', 'position', place);
	   add_line(ref, 'OPB2IP_IF/4', ['SMWODataI_' int2str(c) '/1']);
	end
end

%takes care of OPB2IP_IF
subsys = [ref '/OPB2IP_IF'];

if str2num(sysgenperiod) ~= 1
	set_param([subsys '/OPB_ABus'], 'period', sysgenperiod);
	set_param([subsys '/OPB_BE'], 'period', sysgenperiod);
	set_param([subsys '/OPB_DBus'], 'period', sysgenperiod);
	set_param([subsys '/OPB_RNW'], 'period', sysgenperiod);
	set_param([subsys '/OPB_Select'], 'period', sysgenperiod);
	set_param([subsys '/OPB_seqAddr'], 'period', sysgenperiod);
	set_param([subsys '/OPB_rst'], 'period', sysgenperiod);
end

%takes care of the en_gen subsyst
%each subsequent address needs to be 4 bytes apart.
%After concatenating with the ack and rnw bits and slicing off the rest, we have a number that has
%2+log2(number of inputs and outputs) bits.
%the constant to compare with the address will need to be 2^(addr_width+1)
%+2^addr_width + addr  for reads and 2^(addr_width+1)+addr for writes

subsys = [ref '/en_gen'];
addr_width = ceil(log2(length(gatesIn)+length(gatesOut)));
set_param([subsys '/Slice'], 'nbits', int2str(addr_width));
for c=0:length(gatesIn)-1
	writeRel = [subsys '/Write_rel_' int2str(c)];
	writeCon = [subsys '/Write_const_' int2str(c)];
	out = [subsys '/in_' int2str(c) '_we'];                                                %write enable output
	add_block([subsys '/given_relational'], writeRel);                                        %write relational
	add_block('built-in/Outport',out);
	add_block([subsys '/given_constant'], writeCon, 'n_bits', int2str(2+addr_width), 'const', int2str(2^(addr_width+1)+c));    %write constant
	add_line(subsys, 'Concat/1', [get_param(writeRel, 'Name') '/1']);
	add_line(subsys, [get_param(writeCon,'Name') '/1'], [get_param(writeRel,'Name') '/2']);   %attach second constant w/ second relational
	add_line(subsys, [get_param(writeRel,'Name') '/1'], [get_param(out,'Name') '/1']);
end

if strcmp(smChoice, 'smon')
	if (length(dpramROAddr) + length(dpramWOAddr)) > 0
	    add_block([subsys '/Slice'], [subsys '/AddrSlice' ], 'bit0', int2str(2), 'nbits', int2str(14));
	    add_line(subsys, 'addr/1', ['AddrSlice/1']);
	end
	for c=0:(length(dpramROAddr) - 1)
	    goto = [subsys '/' cleanName(get_param(dpramROAddr{c+1}, 'Name'))];
	    add_block('built-in/Goto', goto, 'GotoTag', ['SMROAddr_' int2str(c)], 'TagVisibility', 'global');
	    add_line(subsys, ['AddrSlice/1'], [get_param(goto, 'Name'), '/1']);
	end
	for c=0:(length(dpramWOAddr) - 1)
	    goto = [subsys '/' cleanName(get_param(dpramWOAddr{c+1}, 'Name'))];
	    add_block('built-in/Goto', goto, 'GotoTag', ['SMWOAddr_' int2str(c)], 'TagVisibility', 'global');
	    add_line(subsys, ['AddrSlice/1'], [get_param(goto, 'Name'), '/1']);
	end
	if (length(dpramWOWE) > 0)
	    add_block([subsys '/Slice'], [subsys '/BankSelect_slice'], 'nbits', int2str(4), 'bit0', int2str(16));
	    add_block([subsys '/given_constant'], [subsys '/BaseAddress_const'], 'n_bits', int2str(32), 'bin_pt', int2str(0), 'const', int2str(base));
	    add_block([subsys '/Slice'], [subsys '/BaseAddress_slice'], 'nbits', int2str(4), 'bit0', int2str(16));
	    add_block([subsys '/given_sub'], [subsys '/addr_sub']);
	    add_line(subsys, 'addr/1', 'BankSelect_slice/1');
	    add_line(subsys, 'BaseAddress_const/1', 'BaseAddress_slice/1');
	    add_line(subsys, 'BankSelect_slice/1', 'addr_sub/1');
	    add_line(subsys, 'BaseAddress_slice/1', 'addr_sub/2');

	    add_block([subsys '/given_constant'], [subsys '/addr_const_' int2str(0)], 'n_bits', int2str(4), 'bin_pt', int2str(0), 'const', int2str(0));
	    add_block([subsys '/given_relational'], [subsys '/addr_rel_' int2str(0)]);
	    add_line(subsys, 'addr_sub/1', ['addr_rel_' int2str(0) '/1']);
	    add_line(subsys, ['addr_const_' int2str(0) '/1'], ['addr_rel_' int2str(0) '/2']);

	    add_block([subsys '/given_inverter'], [subsys '/not_reg']);
	    add_line(subsys, 'addr_rel_0/1', 'not_reg/1');
	    delete_line(subsys, 'rnw/1', 'Concat/2');
	    add_block([subsys, '/given_logical'], [subsys, '/or'], 'logical_function', 'OR', 'inputs', int2str(2));
	    add_line(subsys, 'rnw/1', 'or/1');
	    add_line(subsys, 'not_reg/1', 'or/2');
	    add_line(subsys, 'or/1', 'Concat/2');
	end

	for c=1:length(dpramWOWE)
	    add_block([subsys '/given_constant'], [subsys '/addr_const_' int2str(c)], 'n_bits', int2str(4), 'bin_pt', int2str(0), 'const', int2str(length(dpramROAddr) + c));
	    add_block([subsys '/given_relational'], [subsys '/addr_rel_' int2str(c)]);
	    add_line(subsys, 'addr_sub/1', ['addr_rel_' int2str(c) '/1']);
	    add_line(subsys, ['addr_const_' int2str(c) '/1'], ['addr_rel_' int2str(c) '/2']);

	    goto = [subsys '/' cleanName(get_param(dpramWOWE{c}, 'Name'))];
	    add_block([subsys '/given_inverter'], [subsys '/not_SM_' int2str(c)]);
	    add_block([subsys '/given_logical'], [subsys '/and_SM_' int2str(c)]);
	    add_block('built-in/Goto', goto, 'GotoTag', ['SMWOWE_' int2str(c-1)], 'TagVisibility', 'global');
	    add_line(subsys, 'rnw/1', ['not_SM_' int2str(c) '/1']);
	    add_line(subsys, 'ack_in/1', ['and_SM_' int2str(c) '/1']);
	    add_line(subsys, ['not_SM_' int2str(c) '/1'], ['and_SM_' int2str(c) '/2']);
	    add_line(subsys, ['addr_rel_' int2str(c) '/1'], ['and_SM_' int2str(c) '/3']);
	    add_line(subsys, ['and_SM_' int2str(c) '/1'], [get_param(goto, 'Name'), '/1']);
	end
end

delete_block([subsys '/given_sub']);
delete_block([subsys '/given_logical']);
delete_block([subsys '/given_inverter']);
delete_block([subsys '/given_constant']);
delete_block([subsys '/given_relational']);


%takes care of the mem_if_in subsystem
subsys = [ref '/mem_if_in'];
for c=0:length(gatesIn)-1
	force = [subsys '/Reinterpret_' int2str(c)];
	cast = [subsys '/Convert_' int2str(c)];
	
	reg = [subsys '/' get_param(gatesIn{c+1}, 'Name') '_' int2str(c)];
	in = [subsys '/in_' int2str(c) '_we'];
	out = [subsys '/in_' int2str(c) '_data'];
	goto = [subsys '/' cleanName(get_param(gatesIn{c+1},'Name'))];
	atype = getfield(gatesIn_info,{c+1}, 'arith_type');
	nbits = getfield(gatesIn_info,{c+1}, 'nbits');
	binpt = getfield(gatesIn_info,{c+1}, 'binpt');
	initvalue = getfield(gatesIn_info, {c+1}, 'initvalue');
	if ~strcmp(atype, 'Boolean')     %gateway in not a boolean
	    add_block([subsys '/given_reinterpret'], force, 'arith_type', atype, 'bin_pt', binpt);
	    add_block([subsys '/given_convert'], cast, 'arith_type', atype, 'n_bits', nbits, 'bin_pt', binpt);
	    add_line(subsys, [get_param(force, 'Name') '/1'], [get_param(cast, 'Name') '/1']);
	else 
	    %gateway in is a boolean
	    add_block([subsys '/given_reinterpret'], force, 'bin_pt', '0');
	    add_block([subsys '/given_convert'], [subsys '/Conv_' int2str(c)], 'arith_type', 'Unsigned', 'n_bits', '1', 'bin_pt', '0');
	    add_block([subsys '/given_convert'], cast, 'arith_type', 'Boolean');
	    add_line(subsys, [get_param(force, 'Name') '/1'], ['Conv_' int2str(c) '/1']);
	    add_line(subsys, ['Conv_' int2str(c) '/1'], [get_param(cast, 'Name') '/1']);
	end
	add_block([subsys '/given_register'], reg, 'init', initvalue);
	add_block('built-in/Inport', in);
	add_block('built-in/Outport', out);
	add_block('built-in/Goto', goto, 'GotoTag', ['in_' int2str(c)], 'TagVisibility', 'global');
	add_line(subsys, [get_param(reg, 'Name') '/1'], [get_param(goto, 'Name') '/1']);
	add_line(subsys, [get_param(cast,'Name') '/1'], [get_param(reg,'Name') '/1']);
	add_line(subsys, [get_param(reg,'Name') '/1'], [get_param(out,'Name') '/1']);
	add_line(subsys, [get_param(in,'Name') '/1'], [get_param(reg,'Name') '/2']);
	add_line(subsys, 'opb_dbus/1', [get_param(force, 'Name') '/1']);
	
end
delete_block([subsys '/given_convert']);
delete_block([subsys '/given_register']);
delete_block([subsys '/given_reinterpret']);


%takes care of the mem_if_out subsystem
subsys = [ref '/mem_if_out'];

if strcmp(smChoice, 'smon') & dpramROIndex > 0
	set_param([subsys '/Delay'], 'latency', '1');
end

set_param([subsys '/Slice'], 'nbits', int2str(addr_width));
gatesLeft = length(gatesIn)+length(gatesOut);
for c=0:length(gatesIn)-1
	dataIn = [subsys '/in_' int2str(c) '_data'];
	cast = [subsys '/cast_' int2str(c)];
	force = [subsys '/force_' int2str(c)];
	add_block('built-in/Inport', dataIn);
	add_block([subsys '/given_convert'], cast);
	atype = getfield(gatesIn_info,{c+1}, 'arith_type');
	if strcmp(atype, 'Boolean')     %gateway in is a boolean
	    add_line(subsys, [get_param(dataIn, 'Name') '/1'], [get_param(cast, 'Name') '/1']);
	else
	    add_block([subsys '/given_reinterpret'], force);
	    add_line(subsys, [get_param(dataIn, 'Name') '/1'], [get_param(force, 'Name') '/1']);
	    add_line(subsys, [get_param(force, 'Name') '/1'], [get_param(cast, 'Name') '/1']);
	end
end
for c = 0:length(gatesOut)-1
	from = [subsys '/' cleanName(get_param(gatesOut{c+1}, 'Name'))];
	register = [subsys '/' get_param(gatesOut{c+1}, 'Name') '_' int2str(length(gatesIn)+c)];
	cast = [subsys '/cast_' int2str(length(gatesIn)+c)];
	force = [subsys '/force_' int2str(length(gatesIn)+c)];
	enable = [subsys '/enable_' cleanName(get_param(gatesOut{c+1}, 'Name'))];
	
	add_block('built-in/From', from, 'GotoTag', ['out_' int2str(length(gatesIn)+c)]);
	add_block('built-in/From', enable, 'GotoTag', ['en_out_' int2str(length(gatesIn)+c)]);
	add_block([subsys '/given_register'], register, 'en', 'on');

	add_block([subsys '/given_convert'], cast);
	add_block([subsys '/given_reinterpret'], force);
	add_line(subsys, [get_param(from, 'Name') '/1'], [get_param(register, 'Name') '/1']);
	add_line(subsys, [get_param(register, 'Name') '/1'], [get_param(force, 'Name') '/1']);
	add_line(subsys, [get_param(force, 'Name') '/1'], [get_param(cast, 'Name') '/1']);
	add_line(subsys, [get_param(enable, 'Name') '/1'], [get_param(register, 'Name') '/2']);
end
if strcmp(smChoice, 'smon')
	for c = 0:length(dpramRODataO) - 1
	    from = [subsys '/' cleanName(get_param(dpramRODataO{c+1}, 'Name'))];
	    add_block('built-in/From', from, 'GotoTag', ['SMRODataO_' int2str(c)]);
	    if c==0
	        mux = [subsys '/addrmux'];
	        add_block([subsys '/given_mux'], mux, 'inputs', int2str(length(dpramRODataO) + 1), 'position', [10, 10, 55, 85+30*length(dpramRODataO)]);
	        add_block([subsys '/Slice'], [subsys '/sel_slice'], 'bit0', int2str(16), 'nbits', int2str(length(dec2bin(length(dpramRODataO)))));
	        add_block([subsys '/given_constant'], [subsys '/base_address'], 'bin_pt', '0', 'n_bits', int2str(32), 'const', int2str(base));
	        add_block([subsys '/given_addsub'], [subsys '/const_sub'], 'n_bits', int2str(length(dec2bin(length(dpramRODataO)))));
	        add_block([subsys '/Slice'], [subsys '/const_slice'], 'bit0', int2str(16), 'nbits', int2str(4));
	        add_line(subsys, 'addr/1', 'sel_slice/1');
	        add_line(subsys, 'base_address/1', 'const_slice/1');
	        add_line(subsys, 'sel_slice/1', 'const_sub/1');
	        add_line(subsys, 'const_slice/1', 'const_sub/2');
	        add_line(subsys, 'const_sub/1', 'addrmux/1');
	        add_line(subsys, 'Slice/1', 'addrmux/2');
	    end

	    constant = [subsys '/SMconstant_' int2str(c)];
	    add_block([subsys '/given_constant'], constant, 'const', int2str(c + length(gatesIn) + length(gatesOut)), 'bin_pt', '0', 'n_bits', int2str(length(dec2bin(c+length(gatesIn)+length(gatesOut)))));
	        
	    add_line(subsys, [get_param(constant, 'Name') '/1'], [get_param(mux, 'Name') '/' int2str(c+3)]);
	end
end

%now we have all of the inputs and outputs going to a cast block, and we
%need to hook them up to the mux, sometimes requiring more than one layer
%of muxes

if strcmp(smChoice, 'smon')
	outsInCurrentLayer = length(gatesIn)+length(gatesOut) + length(dpramRODataO);
	gwLeft = length(gatesIn) + length(gatesOut);
	dpramIndex = 0;
else
   outsInCurrentLayer = length(gatesIn)+length(gatesOut); 
end

numberMuxes = ceil(outsInCurrentLayer / 32);
if numberMuxes > 1
	delay = get_param([subsys '/Delay'], 'latency');
	delay = str2num(delay) + 1;
	delay = set_param([subsys '/Delay'], 'latency', num2str(delay));
end

outsLeft = outsInCurrentLayer;
muxNames = [];
nextIdx = 1;  %the index of the next cast block to be connected
begIdx = 0;  %the index of the first cast block in the current mux
while(outsLeft>0 & outsLeft~=33)
	mux = [subsys '/mux_' int2str(begIdx) '_' int2str(begIdx+min([outsLeft, 32])-1)];
	muxNames(nextIdx, 1:2) = [begIdx, begIdx+min([outsLeft, 32])-1];
	nextIdx = nextIdx+1;
	add_block([subsys '/given_mux'], mux, 'inputs',int2str(min([outsLeft, 32])), 'position', [10, 10, 55, 85+30*min([outsLeft, 32])]);
	for c=0:min([outsLeft, 32])-1
	    if strcmp(smChoice, 'smon')
	        if gwLeft > 0
	            add_line(subsys, ['cast_' int2str(begIdx+c) '/1'], [get_param(mux,'Name') '/' int2str(c+2)]);
	            gwLeft = gwLeft - 1;
	        else
	            dpramIndex = dpramIndex + 1;
	            add_line(subsys, [get_param(dpramRODataO{dpramIndex}, 'Name') '/1'], [get_param(mux,'Name') '/' int2str(c+2)]);
	            %add_line(subsys, ['SMconstant_' int2str(dpramIndex - 1) '/1'], ['addrmux/' int2str(dpramIndex+2)]);
	        end
	    else
	        add_line(subsys, ['cast_' int2str(begIdx+c) '/1'], [get_param(mux,'Name') '/' int2str(c+2)]);
	    end
	end
	addsub = [subsys '/a_correction_' int2str(muxNames(nextIdx-1,1))];
	const = [subsys '/const_' int2str(muxNames(nextIdx-1,1))];
	add_block([subsys '/given_constant'], const, 'const', int2str(muxNames(nextIdx-1,1)), 'n_bits', int2str(ceil(log2(2+muxNames(nextIdx-1,1)))));
	add_block([subsys '/given_addsub'], addsub, 'n_bits', int2str(ceil(log2(min([outsLeft,32])))));
	if strcmp(smChoice, 'smon')
	    if (length(dpramRODataO) == 0)
	        add_line(subsys, 'Slice/1', [get_param(addsub,'Name') '/1']);
	    else
	        add_line(subsys, 'addrmux/1', [get_param(addsub,'Name') '/1']);
	    end
	else
	    add_line(subsys, 'Slice/1', [get_param(addsub,'Name') '/1']);
	end
	add_line(subsys, [get_param(const,'Name') '/1'], [get_param(addsub,'Name') '/2']);
	add_line(subsys, [get_param(addsub,'Name') '/1'], [get_param(mux, 'Name') '/1']);
	begIdx = begIdx + min([outsLeft, 32]);
	outsLeft = outsLeft - min([outsLeft, 32]);
end
if outsLeft==33  %break it up into two last muxes
	mux1 = [subsys '/mux_' int2str(begIdx) '_' int2str(begIdx+15)];  %16 inputs
	muxNames(nextIdx, 1:2) = [begIdx, begIdx+15];
	mux2 = [subsys '/mux_' int2str(begIdx+16) '_' int2str(begIdx+32)];  %17 inputs
	muxNames(nextIdx+1, 1:2) = [begIdx+16, begIdx+32];
	nextIdx = nextIdx+2;
	add_block([subsys '/given_mux'], mux1, 'inputs',int2str(16), 'position', [10, 10, 55, 565]);
	add_block([subsys '/given_mux'], mux2, 'inputs',int2str(17), 'position', [10, 10, 55, 595]);
	for c=0:15
	    if strcmp(smChoice, 'smon')
	      if gwLeft > 0
	            add_line(subsys, ['cast_' int2str(begIdx+c) '/1'], [get_param(mux1,'Name') '/' int2str(c+2)]);
	            try
	                add_line(subsys, ['cast_' int2str(begIdx+16+c) '/1'], [get_param(mux2,'Name') '/' int2str(c+2)]);
	            catch
	                dpramIndex = dpramIndex + 1;
	                add_line(subsys, [get_param(dpramRODataO{dpramIndex}, 'Name') '/1'], [get_param(mux2,'Name') '/' int2str(c+2)]);
	            end
	        else
	            dpramIndex = dpramIndex + 1;
	            add_line(subsys, [get_param(dpramRODataO{dpramIndex}, 'Name') '/1'], [get_param(mux2,'Name') '/' int2str(c+2)]);
	        end
	    else
	        add_line(subsys, ['cast_' int2str(begIdx+c) '/1'], [get_param(mux1,'Name') '/' int2str(c+2)]);
	        add_line(subsys, ['cast_' int2str(begIdx+16+c) '/1'], [get_param(mux2,'Name') '/' int2str(c+2)]);
	    end
	end

	if strcmp(smChoice, 'smon')
	    if (gwLeft ==0)
	        add_line(subsys, ['cast_' int2str(begIdx+32) '/1'], [get_param(mux2,'Name') '/' int2str(18)]);
	    else
	        dpramIndex = dpramIndex + 1;
	        add_line(subsys, [get_param(dpramRODataO{dpramIndex}, 'Name') '/1'], [get_param(mux2,'Name') '/' int2str(18)]);
	    end
	else
	    add_line(subsys, ['cast_' int2str(begIdx+32) '/1'], [get_param(mux2,'Name') '/' int2str(18)]);
	end
	
	%connect first set of blocks to first mux
	addsub1 = [subsys '/a_correction_' int2str(muxNames(nextIdx-2,1))];
	const1 = [subsys '/const_' int2str(muxNames(nextIdx-2,1))];
	add_block([subsys '/given_constant'], const1, 'const', int2str(muxNames(nextIdx-2,1)), 'n_bits', int2str(ceil(log2(2+muxNames(nextIdx-2,1)))));
	add_block([subsys '/given_addsub'], addsub1, 'n_bits', '4');
	if strcmp(smChoice, 'smon')
	    if (length(dpramRODataO) == 0)
	        add_line(subsys, 'Slice/1', [get_param(addsub1,'Name') '/1']);
	    else
	        add_line(subsys, 'addrmux/1', [get_param(addsub1,'Name') '/1']);
	    end
	else
	    add_line(subsys, 'Slice/1', [get_param(addsub1,'Name') '/1']);
	end
	add_line(subsys, [get_param(const1,'Name') '/1'], [get_param(addsub1,'Name') '/2']);
	add_line(subsys, [get_param(addsub1,'Name') '/1'], [get_param(mux1, 'Name') '/1']);
	%connect second set of blocks to second mux
	addsub2 = [subsys '/a_correction_' int2str(muxNames(nextIdx-1,1))];
	const2 = [subsys '/const_' int2str(muxNames(nextIdx-1,1))];
	add_block([subsys '/given_constant'], const2, 'const', int2str(muxNames(nextIdx-1,1)), 'n_bits', int2str(ceil(log2(2+muxNames(nextIdx-1,1)))));
	add_block([subsys '/given_addsub'], addsub2, 'n_bits', '5');
	if strcmp(smChoice, 'smon')
	    if (length(dpramRODataO) == 0)
	        add_line(subsys, 'Slice/1', [get_param(addsub2,'Name') '/1']);
	    else
	        add_line(subsys, 'addrmux/1', [get_param(addsub2,'Name') '/1']);
	    end
	else
	    add_line(subsys, 'Slice/1', [get_param(addsub2,'Name') '/1']);
	end
	add_line(subsys, [get_param(const2,'Name') '/1'], [get_param(addsub2,'Name') '/2']);
	add_line(subsys, [get_param(addsub2,'Name') '/1'], [get_param(mux2, 'Name') '/1']);
	begIdx = begIdx + 33;
	outsLeft = outsLeft - 33;
end
%first layer is done
begIdx = 0;
outsInCurrentLayer = ceil(outsInCurrentLayer/32);
if outsInCurrentLayer>1  %do second layer
	set_param([subsys '/Delay'], 'latency', '1');     %delays the ack bit when there are two layers of muxes
	rom = [subsys '/addr_conv'];   %the rom converts the addr into proper select value for the new mux
	initValues = [];
	muxSelect = 0;
	for block = 1:nextIdx-1
	    initValues = [initValues; muxSelect*ones(muxNames(block,2)-muxNames(block,1)+1,1)];     %creates the initial values of the rom
	    muxSelect = muxSelect+1;
	    set_param([subsys '/mux_' int2str(muxNames(block,1)) '_' int2str(muxNames(block,2))], 'latency', '1');   %goes back and sets latency = 1 for all of the first layer muxes
	end
	
	initValuesString = ['['];
	for c=1:length(initValues)
	    initValuesString = [initValuesString int2str(initValues(c)) ' '];       %converts initial values into a string representing the vector
	end
	initValuesString(length(initValuesString)) = ']';
	set_param(rom, 'depth', int2str(length(gatesIn)+length(gatesOut)), 'initVector', initValuesString, 'n_bits', int2str(ceil(log2(initValues(length(initValues))+1))));
	if strcmp(smChoice, 'smon')
	    if (length(dpramRODataO) == 0)
	        add_line(subsys, 'Slice/1', 'addr_conv/1');
	    else
	        add_line(subsys, 'addrmux/1', 'addr_conv/1');
	    end
	else
	    add_line(subsys, 'Slice/1', 'addr_conv/1');
	end
	outsLeft = outsInCurrentLayer;
	mux = [subsys '/mux_' int2str(muxNames(begIdx+1,1)) '_' int2str(muxNames(begIdx+outsLeft,2))];
	add_block([subsys '/given_mux'], mux, 'inputs',int2str(outsLeft), 'position', [10, 10, 55, 85+30*outsLeft]);
	muxNames(nextIdx, 1:2) = [muxNames(begIdx+1,1), muxNames(begIdx+outsLeft,2)];
	nextIdx = nextIdx+1;
	for c=0:outsLeft-1
	    add_line(subsys, ['mux_' int2str(muxNames(begIdx+1+c,1)) '_' int2str(muxNames(begIdx+1+c,2)) '/1'], [get_param(mux,'Name') '/' int2str(2+c)]);
	end
	add_line(subsys, 'addr_conv/1', [get_param(mux,'Name') '/1']);
else
	delete_block([subsys '/addr_conv']);
end
add_line(subsys, ['mux_' int2str(muxNames(nextIdx-1,1)) '_' int2str(muxNames(nextIdx-1,2)) '/1'], 'valid_data/1');


delete_block([subsys '/given_register']);
delete_block([subsys '/given_convert']);
delete_block([subsys '/given_addsub']);
delete_block([subsys '/given_constant']);
delete_block([subsys '/given_mux']);
delete_block([subsys '/given_reinterpret']);


%now attach all of the subsystems appropriately
for c=1:length(gatesIn)
	add_line(ref, ['en_gen/' int2str(c+2)], ['mem_if_in/' int2str(c+1)]);
	add_line(ref, ['mem_if_in/' int2str(c)], ['mem_if_out/' int2str(2+c)]);
end

%makes text log of gateways that were removed
fid = fopen([sys '.h'],'w');

fprintf(fid, '%s\n', ['#include "xbasic_types.h"']);
fprintf(fid, '%s\n', ['#include "xstatus.h"']);
fprintf(fid, '%s\n\n\n', ['#include "xio.h"']);

fprintf(fid, '%s\n', ['#define ' upper(sys) '_OFFSET (0x00000000)']);

fprintf(fid, '%s\n\n', '//Gateways In');
for c = 0:length(gatesIn)-1
	varName = cleanName(fReg{c+1});

	opbLocation = findstr(varName, '_opb');
	if length(opbLocation) == 1
	    varName = varName(1:opbLocation-1);
	else
	    varName = varName(1:opbLocation(length(opbLocation))-1);
	end
	
	fprintf(fid, '%s\n', ['#define ' sys '_' varName '_OFFSET (' upper(sys) '_OFFSET+0x' dec2hex(4*c) ')']);
	%fprintf(fid, '%s\n', ['#define ' sys '_' varName ' (' upper(sys) '_BASEADDR+0x' dec2hex(4*c) ')']);
	fprintf(fid, '%s\n', ['//tag name: in_' int2str(c)]);
	fprintf(fid, '%s\n', ['//arith_type = ' getfield(gatesIn_info, {c+1}, 'arith_type')]);
	fprintf(fid, '%s\n', ['//num_bits = ' getfield(gatesIn_info, {c+1}, 'nbits')]);
	fprintf(fid, '%s\n', ['//bin_pt = ' getfield(gatesIn_info, {c+1}, 'binpt')]);
end
fprintf(fid, '\n%s\n\n', '//Gateways Out');
for c = 0:length(gatesOut)-1
	varName = cleanName(tReg{c+1});

	opbLocation = findstr(varName, '_opb');
	if length(opbLocation) == 1
	    varName = varName(1:opbLocation-1);
	elseif length(opbLocation) > 1
	    varName = varName(1:opbLocation(length(opbLocation))-1);
	end
	
	fprintf(fid, '%s\n', ['#define ' sys '_' varName '_OFFSET (' upper(sys) '_OFFSET+0x' dec2hex(4*(length(gatesIn) + c)) ')']);
	%fprintf(fid, '%s\n', ['#define ' sys '_' varName ' (' upper(sys) '_BASEADDR+0x' dec2hex(4*(length(gatesIn) + c)) ')']);
	fprintf(fid, '%s\n', ['//tag name: out_' int2str(length(gatesIn)+c)]);
	%fprintf(fid, '%s\n', ['//arith_type = ' arith_type{1}]);
	%fprintf(fid, '%s\n', ['//num_bits = ' n_bits{1}]);
	%fprintf(fid, '%s\n', ['//bin_pt = ' bin_pt{1}]);
end

if strcmp(smChoice, 'smon')
	fprintf(fid, '\n%s\n\n', '//Shared Memory Address');
	for c=0:length(dpramWORO) - 1
	    
	    varName = cleanName(dpramWORO{c+1});
	    smLocation = findstr(varName, '_sm');
	    if length(smLocation) == 1
	        varName = varName(1:smLocation-1);
	    elseif length(smLocation) > 1
	        varName = varName(1:smLocation(length(smLocation))-1);
	    end
	    
	    fprintf(fid, '%s\n', ['#define ' sys '_' varName '_OFFSET (' upper(sys) '_OFFSET+0x' dec2hex(c+1) '0000)']);
	    %fprintf(fid, '%s\n\n', ['#define ' sys '_' varName ' (' upper(sys) '_BASEADDR+0x' dec2hex(c+1) '0000)']); 
	end
end



fprintf(fid, '\n\n%s', ['#define ' sys '_WriteReg(BaseAddress, RegOffset, Data) \']);
fprintf(fid, '\n\tXIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))');


fprintf(fid, '\n\n%s', ['#define ' sys '_ReadReg(BaseAddress, RegOffset) \']);
fprintf(fid, '\n\tXIo_In32((BaseAddress) + (RegOffset))');

fprintf(fid, '\n\n%s\n\n', '//Write Reg Macro');
for c = 0:length(gatesIn)-1
	varName = cleanName(fReg{c+1});

	opbLocation = findstr(varName, '_opb');
	if length(opbLocation) == 1
	    varName = varName(1:opbLocation-1);
	else
	    varName = varName(1:opbLocation(length(opbLocation))-1);
	end
	
	fprintf(fid, '%s\n', ['#define ' sys '_WriteReg_' varName '(BaseAddress, Value) \']);
	fprintf(fid, '\t%s\n', ['XIo_Out32((BaseAddress) + (' sys '_' varName '_OFFSET), (Xuint32)(Value))']);
end
for c = 0:length(gatesOut)-1
	varName = cleanName(tReg{c+1});

	opbLocation = findstr(varName, '_opb');
	if length(opbLocation) == 1
	    varName = varName(1:opbLocation-1);
	elseif length(opbLocation) > 1
	    varName = varName(1:opbLocation(length(opbLocation))-1);
	end

	
	fprintf(fid, '%s\n', ['#define ' sys '_WriteReg_' varName '(BaseAddress, Value) \']);
	fprintf(fid, '\t%s\n', ['XIo_Out32((BaseAddress) + (' sys '_' varName '_OFFSET), (Xuint32)(Value))']);
end
if strcmp(smChoice, 'smon')
	for c=0:length(dpramWORO) - 1
	    
	    varName = cleanName(dpramWORO{c+1});
	    smLocation = findstr(varName, '_sm');
	    if length(smLocation) == 1
	        varName = varName(1:smLocation-1);
	    elseif length(smLocation) > 1
	        varName = varName(1:smLocation(length(smLocation))-1);
	    end
	    
	    fprintf(fid, '%s\n', ['#define ' sys '_WriteReg_' varName '(BaseAddress, Value) \']);
	    fprintf(fid, '\t%s\n', ['XIo_Out32((BaseAddress) + (' sys '_' varName '_OFFSET), (Xuint32)(Value))']);
	end
end

fprintf(fid, '\n\n%s\n\n', '//Read Reg Macro');
for c = 0:length(gatesIn)-1
	varName = cleanName(fReg{c+1});

	opbLocation = findstr(varName, '_opb');
	if length(opbLocation) == 1
	    varName = varName(1:opbLocation-1);
	else
	    varName = varName(1:opbLocation(length(opbLocation))-1);
	end
	
	fprintf(fid, '%s\n', ['#define ' sys '_ReadReg_' varName '(BaseAddress) \']);
	fprintf(fid, '\t%s\n', ['XIo_In32((BaseAddress) + (' sys '_' varName '_OFFSET))']);
end
for c = 0:length(gatesOut)-1
	varName = cleanName(tReg{c+1});

	opbLocation = findstr(varName, '_opb');
	if length(opbLocation) == 1
	    varName = varName(1:opbLocation-1);
	elseif length(opbLocation) > 1
	    varName = varName(1:opbLocation(length(opbLocation))-1);
	end
	
	fprintf(fid, '%s\n', ['#define ' sys '_ReadReg_' varName '(BaseAddress) \']);
	fprintf(fid, '\t%s\n', ['XIo_In32((BaseAddress) + (' sys '_' varName '_OFFSET))']);
end
if strcmp(smChoice, 'smon')
	for c=0:length(dpramWORO) - 1
	    
	    varName = cleanName(dpramWORO{c+1});
	    smLocation = findstr(varName, '_sm');
	    if length(smLocation) == 1
	        varName = varName(1:smLocation-1);
	    elseif length(smLocation) > 1
	        varName = varName(1:smLocation(length(smLocation))-1);
	    end
	    
	    fprintf(fid, '%s\n', ['#define ' sys '_ReadReg_' varName '(BaseAddress) \']);
	fprintf(fid, '\t%s\n', ['XIo_In32((BaseAddress) + (' sys '_' varName '_OFFSET))']);
	end
end

fclose(fid);


%clean up models
set_param([ref '/en_gen'], 'position', [10, 10, 100, 70+40*length(gatesIn)]);
set_param([ref '/mem_if_out'], 'position', [10, 10, 120, 70+40*length(gatesIn)]);
set_param([ref '/mem_if_in'], 'position', [10, 10, 120, 70+40*length(gatesIn)]);
xlTBUtils('Layout', struct('x_pitch',150,'sys',ref));
xlTBUtils('Layout',struct('sys',[ref '/en_gen']));
xlTBUtils('Layout', struct('sys', [ref '/mem_if_in']));
xlTBUtils('Layout', struct('x_pitch', 150, 'sys', [ref '/mem_if_out']));

save_system(sys);
close_system(sys);

function name = cleanName(name)
for c = 1:length(name)
	if name(c)==' '
	    name(c)='_';
	end
end

function deleteSink(sys, shortName)
	% Find connected sinks to GatewayOut
	% If there are sinks that are connected to the GatewayOut, append
	% the name of the GatewayOut to the sink name
	dstbrokenlines = find_system(sys,'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'SrcBlockHandle', -1);
	if length(dstbrokenlines) > 0
		% We have a sink that was connected to the GatewayOut
		DstBlockHandle = get_param(dstbrokenlines, 'DstBlockHandle');

		if length(DstBlockHandle) > 1
			for i=1:(length(DstBlockHandle) - 1)
				DstName = get_param(DstBlockHandle{i}, 'Name');
				set_param(DstBlockHandle{i}, 'name', [DstName '_' cleanName(shortName)]);
			end
			delete_line(dstbrokenlines);
		else
			DstName = get_param(DstBlockHandle, 'name');
			set_param(DstBlockHandle, 'name', [DstName '_' cleanName(shortName)]);
			delete_line(dstbrokenlines);
		end

	end
   

function deleteSource(sys, shortName)
	% Find connected sources to the deleted GatewaysIn
	% If there are sources that are connected to the GatewayIn, append
	% the name of the gateway in to the source name
	% Also check if the source block type is a constant
	% If it is a constant, we will want to store the constant value
	% into the struct gatesIn_info.
	srcbrokenlines = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on',  'FindAll', 'on', 'type', 'line', 'DstBlockHandle', -1);
	if length(srcbrokenlines) > 0
		% We have a source that was connected to the gateway in
		% Get the handle of the source block
		SrcBlockHandle = get_param(srcbrokenlines, 'SrcBlockHandle');
		% Get the block type of the handle
		SrcBlockType = get_param(SrcBlockHandle, 'BlockType');

		% If the block type is a constant, we will want to store the
		% constant value into initValue
		if strcmp(SrcBlockType, 'Constant')
			initValue = num2str(get_param(SrcBlockHandle, 'Value'));
			%gatesIn_info = setfield(gatesIn_info, {validGates}, 'initvalue', num2str(get_param(SrcBlockHandle, 'Value')));
		end

		% Get the name of the source. The name of the GatewayIn will be
		% appended to the name of the source
		SrcName = get_param(SrcBlockHandle, 'name');
		set_param(SrcBlockHandle, 'name', [SrcName '_' cleanName(shortName)]);
		delete_line(srcbrokenlines);
	end
