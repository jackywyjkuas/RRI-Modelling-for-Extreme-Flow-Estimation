clc
clear
data = xlsread('AMS_qr.xlsx');

for ii = 1:15
    qr = data(:,ii);
    
    %[parmhat2] = fitGEV(qr,'method','Gumbel');
    [parmhat2] = fitGEV(qr,'method','moments');
    %[parmhat3] = fitGEV(meanU,'method','Gringorten');
    %[parmhat2] = fitGEV(x,'method','moments','dataPlot',1,'returnPeriod',2000);
    returnPeriod = 3000;
    x = ([1:numel(qr)])/(numel(qr)+1);

    r = 1./(1-x); %all 1500-y

    X = linspace(min(qr),2*max(qr),1e4);
    
    
    F  = mygevcdf(X,parmhat2(1),parmhat2(2),parmhat2(3)); % for fitted parameters
    R = 1./(1-F);
    
    %figure
    clf
    box on;
    h1 = plot(r,sort(qr),'ko','markerfacecolor','k'); hold on % cdf


    plot(R,X,'k'); %plot line
    ylabel('Return period (years)');
    xlabel('AMS (m^3/s)');
    %set(gca, 'YScale', 'log')
    axis tight
    ylim([0.9*min(X(R<returnPeriod)),1.1*max(qr)])
    xlim([0,returnPeriod])
    %legend([h1 h2 h3],'All ensemble','Each ensemble','Gauge','location','SouthEast')
    
    grid on
    set(gcf,'color','w');
    %imgname = sprintf('qr_p%.2d.jpg',ii);
    %print(imgname, '-dpng', '-r300');
    pause
end
%[parmhat2] = fitGEV(qr,'method','moments','dataPlot',1,'returnPeriod',2000);