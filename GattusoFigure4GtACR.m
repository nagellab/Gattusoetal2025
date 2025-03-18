function res = GattusoFigure4GtACR(data)
% load all data sets and compare effects of Chrimson activation

if nargin <1
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/vglutad_31a11db_gtacrfull.mat')
        data(1) = vglutad_31a11db_gtacrfull;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/ss49952_gtacr(III).mat')
        data(2) = ss49952_gtacrIII;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/empty_gtacriii.mat')
        data(3) = empty_gtacriii
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/emptysplit_gtacriii.mat')
        data(4) = emptysplit_gtacriii;
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
    
    [h p] = ttest(vbase,vlight)        % this runs a paired t-test
    
    res(n).vbase = vbase;                  % here I am putting all the outputs into a single structure so its easy to keep track of
    res(n).vlight = vlight;                % you could make a "res" structure like this for each genotype then write plotting code to plot all of the results across genotypes
    res(n).vh = h;
    res(n).vp = p;

    subplot(1,length(data),n);
    plot([1 2],[vbase vlight],'k-');                    % typing help plot will show you all the symbols you can use with plotting
    xticks([1 2])
    axis([0.5 2.5 0 12]);

    xticklabels({'OFF','ON'})
    box off; set(gca,'TickDir','out');
    hold on; plot([1 2],[nanmean(vbase) nanmean(vlight)],'go-','lineWidth',2,'markerSize',8);
    if n==1, ylabel('velocity (mm/s)'); end

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
    
    [h p] = ttest(abase,alight)        % this runs a paired t-test
    
    res(n).abase = abase;                  % here I am putting all the outputs into a single structure so its easy to keep track of
    res(n).alight = alight;                % you could make a "res" structure like this for each genotype then write plotting code to plot all of the results across genotypes
    res(n).ah = h;
    res(n).ap = p;

    subplot(1,length(data),n);
    plot([1 2],[abase alight],'k-');                    % typing help plot will show you all the symbols you can use with plotting
    xticks([1 2])
    axis([0.5 2.5 0 250]);
    xticklabels({'OFF','ON'})
    box off; set(gca,'TickDir','out');
    hold on; plot([1 2],[nanmean(abase) nanmean(alight)],'go-','lineWidth',2,'markerSize',8);
    if n==1, ylabel('ang velocity (deg/s)'); end

    clear abase alight h p
end

%% plot effects of light on curvature
figure; 
set(gcf,'PaperPositionMode','auto');  
set(gcf,'Position',[369        1640         641         188]);  

for n=1:length(data)

    dataset = data(n).resblankalwayson10slightbuff;

    for i=1:length(dataset)
        cbase(i) = nanmean(nanmean(dataset(i).curvature(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        clight(i) = nanmean(nanmean(dataset(i).curvature(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    cbase = cbase';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
    clight = clight';
    
    [h p] = ttest(cbase,clight)        % this runs a paired t-test
    
    res(n).cbase = cbase;                  % here I am putting all the outputs into a single structure so its easy to keep track of
    res(n).clight = clight;                % you could make a "res" structure like this for each genotype then write plotting code to plot all of the results across genotypes
    res(n).ch = h;
    res(n).cp = p;

    subplot(1,length(data),n);
    plot([1 2],[cbase clight],'k-');                    % typing help plot will show you all the symbols you can use with plotting
    axis([0.5 2.5 0 150]);
    xticklabels({'OFF','ON'})
    box off; set(gca,'TickDir','out');
    hold on; plot([1 2],[nanmean(cbase) nanmean(clight)],'go-','lineWidth',2,'markerSize',8);
    if n==1, ylabel('curvature (deg/mm)'); end

    clear cbase clight h p
end

%% plot groundspeed distribution
figure; 
set(gcf,'PaperPositionMode','auto');  
set(gcf,'Position',[369        1439         641         389]);        
              
for n=1:length(data)

    dataset = data(n).resblankalwayson10slightbuff;

    for i=1:length(dataset)
        v = dataset(i).v(1001:1500,:);  v = v(:);
        v = v(~isnan(v));
        vbasehist(i,:) = histcounts(v,[0:1:30],'normalization','probability');
        v = dataset(i).v(1501:2000,:); v = v(:);
        v = v(~isnan(v));
        vlighthist(i,:) = histcounts(v,[0:1:30],'normalization','probability');
    end
    

    subplot(2,3,n);
    semilogy([0.5:1:30],nanmean(vbasehist),'k','lineWidth',2);
    hold on; semilogy([0.5:1:30],nanmean(vlighthist),'g','lineWidth',2);
    
    hold on; semilogy([0.5:1:30],nanmean(vbasehist)+nanstd(vbasehist)/sqrt(length(dataset)),'k');
    hold on; semilogy([0.5:1:30],nanmean(vbasehist)-nanstd(vbasehist)/sqrt(length(dataset)),'k');

    hold on; semilogy([0.5:1:30],nanmean(vlighthist)+nanstd(vlighthist)/sqrt(length(dataset)),'g');
    hold on; semilogy([0.5:1:30],nanmean(vlighthist)-nanstd(vlighthist)/sqrt(length(dataset)),'g');

    axis([0 30 10^-5 1]);
    box off; set(gca,'TickDir','out');
    xlabel('velocity (mm/s)');
    if n==1, ylabel('probability'); end

    clear vbasehist vlighthist 
end

%% plot ang velocity distribution
figure; 
set(gcf,'PaperPositionMode','auto');  
set(gcf,'Position',[369        1439         641         389]);        
              
for n=1:length(data)

    dataset = data(n).resblankalwayson10slightbuff;

    for i=1:length(dataset)
        a = dataset(i).angvturn(1001:1500,:);  a = a(:);
        a = a(~isnan(a));
        abasehist(i,:) = histcounts(a,[0:50:600],'normalization','probability');

        a = dataset(i).angvturn(1501:2000,:); a = a(:);
        a = a(~isnan(a));
        alighthist(i,:) = histcounts(a,[0:50:600],'normalization','probability');
    end
    

    subplot(2,3,n);
    semilogy([25:50:600],nanmean(abasehist),'k','lineWidth',2);
    hold on; semilogy([25:50:600],nanmean(alighthist),'g','lineWidth',2);
    
    hold on; semilogy([25:50:600],nanmean(abasehist)+nanstd(abasehist)/sqrt(length(dataset)),'k');
    hold on; semilogy([25:50:600],nanmean(abasehist)-nanstd(abasehist)/sqrt(length(dataset)),'k');

    hold on; semilogy([25:50:600],nanmean(alighthist)+nanstd(alighthist)/sqrt(length(dataset)),'g');
    hold on; semilogy([25:50:600],nanmean(alighthist)-nanstd(alighthist)/sqrt(length(dataset)),'g');

    axis([0 600 10^-5 1]);
    box off; set(gca,'TickDir','out');
    xlabel('ang vel (deg/s)');
    if n==1, ylabel('probability'); end

    clear abasehist alighthist 
end

%% plot odor response curvature w/ and w/o light
figure; 
set(gcf,'PaperPositionMode','auto');  
set(gcf,'Position',[369        1140         263         688]);  

for n=1:length(data)
    % analyze all data for this plot
    lightON = data(n).res10salwaysonalwayson;
    lightOFF = data(n).res10salwaysonalwaysoff;

    for i=1:length(lightON)
        vON(:,i) = nanmean(lightON(i).curvature,2);  
    end

    for i=1:length(lightOFF)
        vOFF(:,i) = nanmean(lightOFF(i).curvature,2);         
    end
    
    subplot(length(data),1,n);
    t = [1:size(vON,1)]/50;
    plot(t,nanmean(vOFF,2),'k','lineWidth',2);
    hold on; plot(t,nanmean(vON,2),'g','lineWidth',2);
    
    hold on; semilogy(t,nanmean(vOFF,2)+nanstd(vOFF,0,2)/sqrt(length(lightOFF)),'k');
    hold on; semilogy(t,nanmean(vOFF,2)-nanstd(vOFF,0,2)/sqrt(length(lightOFF)),'k');

    hold on; semilogy(t,nanmean(vON,2)+nanstd(vON,0,2)/sqrt(length(lightON)),'g');
    hold on; semilogy(t,nanmean(vON,2)-nanstd(vON,0,2)/sqrt(length(lightON)),'g');
    axis([0 70 0 100]);
    box off; set(gca,'TickDir','out');
    ylabel('vel (mm/s)');
    if n==6, xlabel('time (s)'); end

    clear vON vOFF 

end

%% plot effects of light on odor-evoked offset curvature
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
        curvON(i) = nanmean(nanmean(lightON(i).curvature(2001:2250,:)));         
        curvOFF(i) = nanmean(nanmean(lightOFF(i).curvature(2001:2250,:)));         
    end
    
    curvON = curvON';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
    curvOFF = curvOFF';
    
    [h p] = ttest(curvON,curvOFF)        % this runs a paired t-test
    
    res(n).curvON = curvON;                  % here I am putting all the outputs into a single structure so its easy to keep track of
    res(n).curvOFF = curvOFF;                % you could make a "res" structure like this for each genotype then write plotting code to plot all of the results across genotypes
    res(n).coffh = h;
    res(n).coffp = p;

    subplot(1,length(data),n);
    plot([1 2],[curvOFF curvON],'k-');                    % typing help plot will show you all the symbols you can use with plotting
    xticks([1 2])
    axis([0.5 2.5 0 70]);
    xticklabels({'OFF','ON'})
    box off; set(gca,'TickDir','out');
    hold on; plot([1 2],[nanmean(curvOFF) nanmean(curvON)],'go-','lineWidth',2,'markerSize',8);
    if n==1, ylabel('off curvature (deg/mm)'); end

    clear curvON curvOFF h p idx

end

%% plot effects of light on odor-evoked offset angular velocity
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
        angvON(i) = nanmean(nanmean(lightON(i).angvturn(2001:2250,:)));         
        angvOFF(i) = nanmean(nanmean(lightOFF(i).angvturn(2001:2250,:)));         
    end
    
    angvON = angvON';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
    angvOFF = angvOFF';
    
    [h p] = ttest(angvON,angvOFF)        % this runs a paired t-test
    
    res(n).angvON = angvON;                  % here I am putting all the outputs into a single structure so its easy to keep track of
    res(n).angvOFF = angvOFF;                % you could make a "res" structure like this for each genotype then write plotting code to plot all of the results across genotypes
    res(n).aoffh = h;
    res(n).aoffp = p;

    subplot(1,length(data),n);
    plot([1 2],[angvOFF angvON],'k-');                    % typing help plot will show you all the symbols you can use with plotting
    xticks([1 2])
    axis([0.5 2.5 0 200]);
    xticklabels({'OFF','ON'})
    box off; set(gca,'TickDir','out');
    hold on; plot([1 2],[nanmean(angvOFF) nanmean(angvON)],'go-','lineWidth',2,'markerSize',8);
    if n==1, ylabel('off ang vel (deg/s)'); end

    clear angvON angvOFF h p idx

end