function res = GattusoFigure5PathLength(data)
% load all data sets

if nargin <1
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/Chrimson/vglutADvt043158DB_chrim.mat')
        data(1) = vglutADvt043158DB_chrim;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/vglut_vt0_gtacrfull.mat')
        data(2) = vglut_vt0_gtacrfull;
end

%% plot effects of light on odor-evoked path
figure; 
set(gcf,'PaperPositionMode','auto');  
set(gcf,'Position',[369        1640         641         188]);  

for n=1
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
    
    [h p] = ttest(pathlengthON,pathlengthOFF)        % this runs a paired t-test
    
    res(n).pathlengthON = pathlengthON;                  % here I am putting all the outputs into a single structure so its easy to keep track of
    res(n).pathlengthOFF = pathlengthOFF;                % you could make a "res" structure like this for each genotype then write plotting code to plot all of the results across genotypes
    res(n).ph = h;
    res(n).pp = p;

    subplot(1,2,1);
    plot([1 2],[pathlengthOFF pathlengthON],'k-');                    % typing help plot will show you all the symbols you can use with plotting
    axis([0.5 2.5 0 150]);

    xticklabels({'OFF','ON'})
    xticks([1 2])
    box off; set(gca,'TickDir','out');
    hold on; plot([1 2],[nanmean(pathlengthOFF) nanmean(pathlengthON)],'ro-','lineWidth',2,'markerSize',8);
    if n==1, ylabel('path length (mm)'); end

    clear pathlengthON pathlengthOFF h p idx

end

for n=2
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
    
    [h p] = ttest(pathlengthON,pathlengthOFF)        % this runs a paired t-test
    
    res(n).pathlengthON = pathlengthON;                  % here I am putting all the outputs into a single structure so its easy to keep track of
    res(n).pathlengthOFF = pathlengthOFF;                % you could make a "res" structure like this for each genotype then write plotting code to plot all of the results across genotypes
    res(n).ph = h;
    res(n).pp = p;

    subplot(1,2,2);
    plot([1 2],[pathlengthOFF pathlengthON],'k-');                    % typing help plot will show you all the symbols you can use with plotting
    axis([0.5 2.5 0 150]);
    xticks([1 2])
    box off; set(gca,'TickDir','out');
    hold on; plot([1 2],[nanmean(pathlengthOFF) nanmean(pathlengthON)],'go-','lineWidth',2,'markerSize',8);
    xticklabels({'OFF','ON'})
    if n==1, ylabel('path length (mm)'); end

    clear pathlengthON pathlengthOFF h p idx

end