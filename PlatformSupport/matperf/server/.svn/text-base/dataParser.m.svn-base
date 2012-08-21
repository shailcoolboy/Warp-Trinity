load temp_matperf_data

close all
bandWidthMatrix = reshape(report.bandwidth,14,1);
figure(1)
plot(report.req_bandwidth(1:14).*1e-6,bandWidthMatrix.*1e-6,'-o','LineWidth',2)
xlabel('Requested Bandwidth (Mbps)');
ylabel('Achieved Bandwidth (Mbps)');
axis tight
%legend('200','400','600','800','1000','1200','1400')
%legend('200','800','1400');
%  figure(2)
%  percentage = 100 * (result.losses./result.totalpackets);
%  new_percentage = reshape(percentage, 20,4);
%  plot(new_percentage)