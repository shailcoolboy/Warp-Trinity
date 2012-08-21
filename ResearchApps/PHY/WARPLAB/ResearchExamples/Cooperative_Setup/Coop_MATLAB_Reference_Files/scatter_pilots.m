function [txout,size_segment] = scatter_pilots(txin, training)

%assume space time code, 2 training symbol per segment
num_pilot = length(training)/2;

% Interleaving pilots with the symbols
size_segment = floor(length(txin)/num_pilot);

txout = [];

for i = 1:1:num_pilot-1
  txout = [txout; training(i); training(num_pilot+i); txin(1+(size_segment*(i-1)):size_segment*i)];
end

i = num_pilot;

txout = [txout; training(i); training(num_pilot+i); txin(1+(size_segment*(i-1)):end)];

