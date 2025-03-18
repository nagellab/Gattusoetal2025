function res = GattusoFigure4ChrimsonRevision(data)
% load all data sets and compare effects of Chrimson activation

if nargin <1
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/Chrimson/SS49952 Chrimson.mat')
        data(1) = SS49952Chrimson;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/Chrimson/EmptySplit_Chrimson.mat')
        data(2) = EmptySplit_Chrimson;
end

%% change in ang v split gal4 vs empty split

figure; 
set(gcf,'PaperPositionMode','auto');  
set(gcf,'Position',[369        1640         641         188]);  

for n=1:length(data(1))
    % analyze only flies for which both light ON and light OFF data exist
    lightON_ss49952 = data(1).res10salwaysonalwayson;
    lightOFF_ss49952 = data(1).res10salwaysonalwaysoff;

    ONlist_ss49952 = [strvcat(lightON_ss49952.date) strvcat(lightON_ss49952.fly) strvcat(lightON_ss49952.experiment)];
    OFFlist_ss49952 = [strvcat(lightOFF_ss49952.date) strvcat(lightOFF_ss49952.fly) strvcat(lightOFF_ss49952.experiment)];

    for i=1:length(ONlist_ss49952), 
        temp = strmatch(ONlist_ss49952(i,:), OFFlist_ss49952, 'exact'); 
        if(~isempty(temp)), 
            idx(i) = temp(1); 
        else
            idx(i) = 0;
        end
        clear temp
    end
    lightON_ss49952(find(idx==0)) = [];
    idx(find(idx==0)) = []; 
    lightOFF_ss49952 = lightOFF_ss49952(idx);

    for i=1:length(lightON_ss49952)
        angvON_ss49952(i) = nanmean(nanmean(lightON_ss49952(i).angvturn(2001:2250,:)));         
        angvOFF_ss49952(i) = nanmean(nanmean(lightOFF_ss49952(i).angvturn(2001:2250,:)));         
    end
    
    for i=1:length(angvON_ss49952)
        diffangv_ss49952(i) = angvON_ss49952(i) - angvOFF_ss49952(i);
    end
    
    diffangv_ss49952 = diffangv_ss49952';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
   
end
    
for n=1:length(data(2))
    % analyze only flies for which both light ON and light OFF data exist
    lightON_emptysplit = data(2).res10salwaysonalwayson;
    lightOFF_emptysplit = data(2).res10salwaysonalwaysoff;

    ONlist_emptysplit = [strvcat(lightON_emptysplit.date) strvcat(lightON_emptysplit.fly) strvcat(lightON_emptysplit.experiment)];
    OFFlist_emptysplit = [strvcat(lightOFF_emptysplit.date) strvcat(lightOFF_emptysplit.fly) strvcat(lightOFF_emptysplit.experiment)];

    for i=1:length(ONlist_emptysplit), 
        temp = strmatch(ONlist_emptysplit(i,:), OFFlist_emptysplit, 'exact'); 
        if(~isempty(temp)), 
            idx(i) = temp(1); 
        else
            idx(i) = 0;
        end
        clear temp
    end
    lightON_emptysplit(find(idx==0)) = [];
    idx(find(idx==0)) = []; 
    lightOFF_emptysplit = lightOFF_emptysplit(idx);

    for i=1:length(lightON_emptysplit)
        angvON_emptysplit(i) = nanmean(nanmean(lightON_emptysplit(i).angvturn(2001:2250,:)));         
        angvOFF_emptysplit(i) = nanmean(nanmean(lightOFF_emptysplit(i).angvturn(2001:2250,:)));         
    end
    
    for i=1:length(angvON_emptysplit)
        diffangv_emptysplit(i) = angvON_emptysplit(i) - angvOFF_emptysplit(i);
    end
    
    diffangv_emptysplit = diffangv_emptysplit'; 
    
    [h p] = ttest2(diffangv_ss49952,diffangv_emptysplit)        % this runs a paired t-test
    
                    % you could make a "res" structure like this for each genotype then write plotting code to plot all of the results across genotypes
    res(n).aoffdiffh = h;
    res(n).aoffdiffp = p;

    

    

end