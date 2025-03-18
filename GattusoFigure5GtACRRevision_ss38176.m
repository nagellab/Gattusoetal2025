function res = GattusoFigure5GtACRRevision_ss38176(data)
% load all data sets and compare effects of Chrimson activation

if nargin <1
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/ss38176_gtacr(II).mat')
        data(1) = ss38176_gtacr;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/emptysplit_gtacrii.mat')
        data(2) = emptysplit_gtacrii;
end

%% plot effects of light on ground speed
for n=1:length(data(2))

    emptysplit_ii = data(2).resblankalwayson10slightbuff;

    for i=1:length(emptysplit_ii)
        vbase_emptysplit_ii(i) = nanmean(nanmean(emptysplit_ii(i).vmove(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        vlight_emptysplit_ii(i) = nanmean(nanmean(emptysplit_ii(i).vmove(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(vbase_emptysplit_ii)                    % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
        vchange_emptysplit_ii(i) = vlight_emptysplit_ii(i) - vbase_emptysplit_ii(i);

    end
    
    meanvchange_emptysplit_ii = nanmean(vchange_emptysplit_ii);

    res(n).meanvchange_emptysplit_ii = meanvchange_emptysplit_ii;
end


for n=1:length(data(1))

    smp092 = data(1).resblankalwayson10slightbuff;

    for i=1:length(smp092)
        vbase_smp092(i) = nanmean(nanmean(smp092(i).vmove(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        vlight_smp092(i) = nanmean(nanmean(smp092(i).vmove(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(vbase_smp092)
        vchange_smp092(i) = vlight_smp092(i) - vbase_smp092(i);
    end

    vchange_smp092 = vchange_smp092';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
   
    
    meanvchange_smp092 = nanmean(vchange_smp092);

    [h p] = ttest2(vchange_smp092,vchange_emptysplit_ii)
    res(n).vchange_smp092h = h;
    res(n).vchange_smp092p = p;
    res(n).meanvchange_smp092 = meanvchange_smp092;
    
end





%[h p] = ttest2(vchange_throttle,vchange_emptysplit)
%[h p] = ttest2(vchange_LAL073a,vchange_emptysplit)
%[h p] = ttest2(vchange_ss41947,vchange_emptysplit)
%[h p] = ttest2(vchange_smp092,vchange_emptysplit)