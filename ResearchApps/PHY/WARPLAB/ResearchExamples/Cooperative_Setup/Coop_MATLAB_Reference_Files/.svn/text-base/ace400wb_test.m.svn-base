%SR5500 RCI Test

emulatorHandle = pnet('tcpconnect','10.0.0.5',9094);
pnet(emulatorHandle,'setreadtimeout',1)

pnet(emulatorHandle, 'printf', '00 err\r');
data='';
while (strcmp(data,''))
data=pnet(emulatorHandle,'read');
pause(1)
end
fprintf('\n%s', data);




% If connection is closed using pnet the remote interface on the emulator
% has to be closed manually.