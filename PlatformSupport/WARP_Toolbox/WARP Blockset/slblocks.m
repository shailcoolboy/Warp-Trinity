function blkStruct = slblocks
%SLBLOCKS Defines the Simulink library block representation
%   for the XtremeDSP kit blocks.

blkStruct.Name    = ['WARP'];
blkStruct.OpenFcn = 'WARP_Blockset';
blkStruct.MaskInitialization = '';

blkStruct.MaskDisplay = ['disp(''Rice University WARP'')'];

% Define the library list for the Simulink Library browser.
% Return the name of the library model and the name for it
%
Browser(1).Library = 'WARP_Blockset';
Browser(1).Name    = 'WARP';

blkStruct.Browser = Browser;

% End of slblocks.m
