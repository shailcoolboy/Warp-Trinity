clear all;
Fs = 40e6;
n = 1:10240;
FFTpoints = 512;
filterOrder = 256;
f1 = 1e6;
f2 = 2e6;
f3 = 3e6;
f4 = 4e6;
x  = sin(2*pi*f1/Fs*n) + sin(2*pi*f2/Fs*n) + sin(2*pi*f3/Fs*n) + sin(2*pi*f4/Fs*n); % 


ins1 = load('singleToneOut.txt');
ins = ins1(:,1)+j*ins1(:,2);

fff = fir1(filterOrder, [(f1-1e6/4)*2/Fs (f1+1e6/4)*2/Fs]);
%fff = fir1(16, 1.8*f1/Fs);
y = filter(fff, 1, ins);    % 
yo = fft(y, FFTpoints);


figure(112);
for k = 1:FFTpoints
    x_f(k) = (k-FFTpoints/2)/(FFTpoints) * Fs;
end
plot(x_f, abs(fftshift(yo)));
grid minor;
%fo=fopen('singeleToneOut.txt','r');
%fclose(fo);
