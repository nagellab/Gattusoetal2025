function res = GattusoFigureS7GtACRRevision_ss38176(data)
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
        angvbase_emptysplit_ii(i) = nanmean(nanmean(emptysplit_ii(i).angvturn(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        angvlight_emptysplit_ii(i) = nanmean(nanmean(emptysplit_ii(i).angvturn(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(angvbase_emptysplit_ii)                    % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
        angvchange_emptysplit_ii(i) = angvlight_emptysplit_ii(i) - angvbase_emptysplit_ii(i);

    end
    
    meanangvchange_emptysplit_ii = nanmean(angvchange_emptysplit_ii);

    res(n).meanangvchange_emptysplit_ii = meanangvchange_emptysplit_ii;
end


for n=1:length(data(1))

    smp092 = data(1).resblankalwayson10slightbuff;

    for i=1:length(smp092)
        angvbase_smp092(i) = nanmean(nanmean(smp092(i).angvturn(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        angvlight_smp092(i) = nanmean(nanmean(smp092(i).angvturn(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(angvbase_smp092)
        angvchange_smp092(i) = angvlight_smp092(i) - angvbase_smp092(i);
    end

    angvchange_smp092 = angvchange_smp092';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
   
    
    meanangvchange_smp092 = nanmean(angvchange_smp092);

    [h p] = ttest2(angvchange_smp092,angvchange_emptysplit_ii)
    res(n).angvchange_smp092h = h;
    res(n).angvchange_smp092p = p;
    res(n).meanangvchange_smp092 = meanangvchange_smp092;
    
end