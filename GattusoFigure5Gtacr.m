function res = GattusoFigure5Gtacr(data)
% load all data sets and compare effects of GtACR1 activation

if nargin <1
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/vglut_vt0_gtacrfull.mat')
        data(1) = vglut_vt0_gtacrfull;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/LALS1_gtacr.mat')
        data(2) = LALS1_gtacr;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/SS41947_gtacr.mat')
        data(3) = SS41947_gtacr;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/ss38176_gtacr(II).mat')
        data(4) = ss38176_gtacr;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/empty_gtacriii.mat')
        data(5) = empty_gtacriii;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/emptysplit_gtacriii.mat')
        data(6) = emptysplit_gtacriii;
    
end

%% plot effects of light on forward velocity
figure; 
set(gcf,'PaperPositionMode','auto');  
set(gcf,'Position',[369        1640         641         188]);        
              
for n=1:length(data)

    dataset = data(n).resblankalwayson10slightbuff;

    for i=1:length(dataset)
        vbase(i) = nanmean(nanmean(dataset(i).vmove(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        vlight(i) = nanmean(nanmean(dataset(i).vmove(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    vbase = vbase';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
    vlight = vlight';
    
    meanvbase = nanmean(vbase);
    meanvlight = nanmean(vlight);

    [h p] = ttest(vbase,vlight)        % this runs a paired t-test
    
    res(n).vbase = vbase;                  % here I am putting all the outputs into a single structure so its easy to keep track of
    res(n).vlight = vlight;                % you could make a "res" structure like this for each genotype then write plotting code to plot all of the results across genotypes
    res(n).vh = h;
    res(n).vp = p;
    res(n).meanvbase = meanvbase;
    res(n).meanvlight = meanvlight;

    subplot(1,6,n);
    plot([1 2],[vbase vlight],'k-');                    % typing help plot will show you all the symbols you can use with plotting
    axis([0.5 2.5 0 21]);
    box off; set(gca,'TickDir','out');
    hold on; plot([1 2],[nanmean(vbase) nanmean(vlight)],'go-','lineWidth',2,'markerSize',8);
    xticklabels({'OFF','ON'})
    if n==1, ylabel('ground speed (mm/s)'); end
    clear vbase vlight h p
end

%% plot effects of light on angular velocity
figure; 
set(gcf,'PaperPositionMode','auto');  
set(gcf,'Position',[369        1640         641         188]);  

for n=1:length(data)

    dataset = data(n).resblankalwayson10slightbuff;

    for i=1:length(dataset)
        abase(i) = nanmean(nanmean(dataset(i).angvturn(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        alight(i) = nanmean(nanmean(dataset(i).angvturn(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    abase = abase';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
    alight = alight';
    
    meanabase = nanmean(abase);
    meanalight = nanmean(alight);

    [h p] = ttest(abase,alight)        % this runs a paired t-test
    
    res(n).abase = abase;                  % here I am putting all the outputs into a single structure so its easy to keep track of
    res(n).alight = alight;                % you could make a "res" structure like this for each genotype then write plotting code to plot all of the results across genotypes
    res(n).ah = h;
    res(n).ap = p;
    res(n).meanabase = meanabase;
    res(n).meanalight = meanalight;

    subplot(1,6,n);
    plot([1 2],[abase alight],'k-');                    % typing help plot will show you all the symbols you can use with plotting
    axis([0.5 2.5 0 250]);
    box off; set(gca,'TickDir','out');
    hold on; plot([1 2],[nanmean(abase) nanmean(alight)],'go-','lineWidth',2,'markerSize',8);
    xticklabels({'OFF','ON'})
    if n==1, ylabel('ang velocity (deg/s)'); end

    clear abase alight h p
end


%% plot effects of light on odor-evoked path
figure; 
set(gcf,'PaperPositionMode','auto');  
set(gcf,'Position',[369        1640         641         188]);  

for n=1:length(data)
    % analyze only flies for which both light ON and light OFF data exist
    lightON = data(n).res10salwaysonalwayson;
    lightOFF = data(n).res10salwaysonalwaysoff;

    ONlist = [strvcat(lightON.date) strvcat(lightON.fly) strvcat(lightON.experiment)];
    OFFlist = [strvcat(lightOFF.date) strvcat(lightOFF.fly) strvcat(lightOFF.experiment)];

    for i=1:length(ONlist), 
        temp = strmatch(ONlist(i,:), OFFlist, 'exact'); 
        if(~isempty(temp)), 
            idx(i) = temp(1); 
        else
            idx(i) = 0;
        end
        clear temp
    end
    lightON(find(idx==0)) = [];
    idx(find(idx==0)) = []; 
    lightOFF = lightOFF(idx);

    for i=1:length(lightON)
        pathlengthON(i) = nanmean(nansum(lightON(i).v(1501:2000,:)))/50;         
        pathlengthOFF(i) = nanmean(nansum(lightOFF(i).v(1501:2000,:)))/50;         
    end
    
    pathlengthON = pathlengthON';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
    pathlengthOFF = pathlengthOFF';

    meanpathlengthON = nanmean(pathlengthON);
    meanpathlengthOFF = nanmean(pathlengthOFF);
    
    [h p] = ttest(pathlengthON,pathlengthOFF)        % this runs a paired t-test
    
    res(n).pathlengthON = pathlengthON;                  % here I am putting all the outputs into a single structure so its easy to keep track of
    res(n).pathlengthOFF = pathlengthOFF;                % you could make a "res" structure like this for each genotype then write plotting code to plot all of the results across genotypes
    res(n).ph = h;
    res(n).pp = p;
    res(n).meanpathlengthON = meanpathlengthON;
    res(n).meanpathlengthOFF = meanpathlengthOFF;

    subplot(1,6,n);
    plot([1 2],[pathlengthOFF pathlengthON],'k-');                    % typing help plot will show you all the symbols you can use with plotting
    axis([0.5 2.5 0 150]);
    box off; set(gca,'TickDir','out');
    hold on; plot([1 2],[nanmean(pathlengthOFF) nanmean(pathlengthON)],'go-','lineWidth',2,'markerSize',8);
    xticklabels({'OFF','ON'})
    if n==1, ylabel('path length (mm)'); end

    clear pathlengthON pathlengthOFF h p idx

end

%% plot groundspeed distribution
figure; 
set(gcf,'PaperPositionMode','auto');  
set(gcf,'Position',[369        1439         641         389]);        
              
for n=1:length(data)

    dataset = data(n).resblankalwayson10slightbuff;

    for i=1:length(dataset)
        v = dataset(i).v(1001:1500,:);  
        vbasehist(i,:) = histcounts(v(:),[0:1:30],'normalization','probability');
        v = dataset(i).v(1501:2000,:); 
        vlighthist(i,:) = histcounts(v(:),[0:1:30],'normalization','probability');
    end
    

    subplot(2,3,n);
    semilogy([0.5:1:30],mean(vbasehist),'k','lineWidth',2);
    hold on; semilogy([0.5:1:30],mean(vlighthist),'g','lineWidth',2);
    
    hold on; semilogy([0.5:1:30],mean(vbasehist)+std(vbasehist)/sqrt(length(dataset)),'k');
    hold on; semilogy([0.5:1:30],mean(vbasehist)-std(vbasehist)/sqrt(length(dataset)),'k');

    hold on; semilogy([0.5:1:30],mean(vlighthist)+std(vlighthist)/sqrt(length(dataset)),'g');
    hold on; semilogy([0.5:1:30],mean(vlighthist)-std(vlighthist)/sqrt(length(dataset)),'g');

    axis([0 30 10^-5 1]);
    box off; set(gca,'TickDir','out');
    xlabel('ground speed (mm/s)');
    if n==1, ylabel('probability'); end

    clear vbasehist vlighthist 
end

%% plot odor response velocity w/ and w/o light
figure; 
set(gcf,'PaperPositionMode','auto');  
set(gcf,'Position',[369        1140         263         688]);  

for n=1:length(data)
    % analyze all data for this plot
    lightON = data(n).res10salwaysonalwayson;
    lightOFF = data(n).res10salwaysonalwaysoff;

    for i=1:length(lightON)
        vON(:,i) = nanmean(lightON(i).vmove,2);  
    end

    for i=1:length(lightOFF)
        vOFF(:,i) = nanmean(lightOFF(i).vmove,2);         
    end
    
    subplot(length(data),1,n);
    t = [1:size(vON,1)]/50;
    plot(t,nanmean(vOFF,2),'k','lineWidth',2);
    hold on; plot(t,nanmean(vON,2),'g','lineWidth',2);
    
    hold on; semilogy(t,nanmean(vOFF,2)+nanstd(vOFF,0,2)/sqrt(length(lightOFF)),'k');
    hold on; semilogy(t,nanmean(vOFF,2)-nanstd(vOFF,0,2)/sqrt(length(lightOFF)),'k');

    hold on; semilogy(t,nanmean(vON,2)+nanstd(vON,0,2)/sqrt(length(lightON)),'g');
    hold on; semilogy(t,nanmean(vON,2)-nanstd(vON,0,2)/sqrt(length(lightON)),'g');
    axis([0 70 0 11]);
    box off; set(gca,'TickDir','out');
    ylabel('ground speed (mm/s)');
    if n==6, xlabel('time (s)'); end

    clear vON vOFF 

end