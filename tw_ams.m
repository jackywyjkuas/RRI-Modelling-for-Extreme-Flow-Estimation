clc
clear
data = xlsread('AMS_qr.xlsx');
data2 = xlsread('sim_gauge.xlsx');

for ii = 1:15
    qr = data(:,ii);
    if ii == 5 | ii == 6 | ii == 7
        qr = data(:,ii)/1.5;
    elseif ii == 12 | ii == 13
        qr = data(:,ii)/2;
    elseif ii == 14
        qr = data(:,ii)/2.5;
    end
    obs = data2(:,ii);
    k = 0;
    for i = 1:50
        for j = 1:30
            k = k + 1;
            ens(j,i) = qr(k);
        end
    end
    d4pdf(:,ii) = qr(:);
    
    %[parmhat2] = fitGEV(qr,'method','Gumbel');
    [parmhat2] = fitGEV(qr,'method','moments');
    %[parmhat3] = fitGEV(meanU,'method','Gringorten');
    %[parmhat2] = fitGEV(x,'method','moments','dataPlot',1,'returnPeriod',2000);
    returnPeriod = 3000;
    x = ([1:numel(qr)])/(numel(qr)+1);
    x1 = ([1:numel(obs)])/(numel(obs)+1);
    x2 = ([1:numel(ens(:,1))])/(numel(ens(:,1))+1);
    r = 1./(1-x); %all 1500-y
    r1 = 1./(1-x1); %obs 21-y
    r2 = 1./(1-x2); %each ensemble 30 y
    X = linspace(min(qr),2*max(qr),1e4);
    
    
    F  = mygevcdf(X,parmhat2(1),parmhat2(2),parmhat2(3)); % for fitted parameters
    R = 1./(1-F);
    
    %figure
    clf
    box on;
    h1 = plot(sort(qr),r,'ko','markerfacecolor','k'); hold on % cdf
    
    for i = 1:50
        h2 = plot(sort(ens(:,i)),r2,'b-','markerfacecolor','b'); hold on % cdf
    end
    h3 = plot(sort(obs),r1,'ro','markerfacecolor','r'); hold on % cdf
    %plot(R,X,'k'); %plot line
    ylabel('Return period (years)');
    xlabel('AMS (m^3/s)');
    set(gca, 'YScale', 'log')
    axis tight
    xlim([0.9*min(X(R<returnPeriod)),1.1*max(qr)])
    ylim([0,returnPeriod])
    legend([h1 h2 h3],'All ensemble','Each ensemble','Gauge','location','SouthEast')
    grid on
    set(gcf,'color','w');
    imgname = sprintf('qr_p%.2d-legend.jpg',ii);
    %print(imgname, '-dpng', '-r300');
    pause
    
  
end
%[parmhat2] = fitGEV(qr,'method','moments','dataPlot',1,'returnPeriod',2000);


%% KS test
% H0: the two samples have no significant difference in CDF
% KS = 1 reject H0 (significant); KS = 0 accept H0 (not significant)
% p-value < 0.05, rejected H0

for ii = 1:15
    d1 = d4pdf(:,ii);
    d2 = data2(:,ii);
    if ii == 1
        [KS01,p_value_01] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 2
        [KS02,p_value_02] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 3
        [KS03,p_value_03] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 4
        [KS04,p_value_04] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 5
        [KS05,p_value_05] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 6
        [KS06,p_value_06] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 7
        [KS07,p_value_07] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 8
        [KS08,p_value_08] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 9
        [KS09,p_value_09] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 10
        [KS10,p_value_10] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 11
        [KS11,p_value_11] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 12
        [KS12,p_value_12] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 13
        [KS13,p_value_13] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 14
        [KS14,p_value_14] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 15
        [KS15,p_value_15] = kstest2(d1,d2,'Alpha',0.01);
    end
end
  
