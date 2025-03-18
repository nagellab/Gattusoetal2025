function res = GattusoFigureS7GtACRRevision(data)
% load all data sets and compare effects of Chrimson activation

if nargin <1
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/vglut_vt0_gtacrfull.mat')
        data(1) = vglut_vt0_gtacrfull;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/LALS1_gtacr.mat')
        data(2) = LALS1_gtacr;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/SS41947_gtacr.mat')
        data(3) = SS41947_gtacr;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/ss38176_gtacr(II).mat')
        data(4) = ss38176_gtacr;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/emptysplit_gtacriii.mat')
        data(5) = emptysplit_gtacriii;
end

%% plot effects of light on angular velocity
for n=1:length(data(5))

    emptysplit = data(5).resblankalwayson10slightbuff;

    for i=1:length(emptysplit)
        angvbase_emptysplit(i) = nanmean(nanmean(emptysplit(i).angvturn(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        angvlight_emptysplit(i) = nanmean(nanmean(emptysplit(i).angvturn(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(angvbase_emptysplit)                    % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
        angvchange_emptysplit(i) = angvlight_emptysplit(i) - angvbase_emptysplit(i);

    end
    
    meanangvchange_emptysplit = nanmean(angvchange_emptysplit);

    res(n).meanangvchange_emptysplit = meanangvchange_emptysplit;
end

for n=1:length(data(1))

    throttle = data(1).resblankalwayson10slightbuff;

    for i=1:length(throttle)
        angvbase_throttle(i) = nanmean(nanmean(throttle(i).angvturn(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        angvlight_throttle(i) = nanmean(nanmean(throttle(i).angvturn(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(angvbase_throttle)
        angvchange_throttle(i) = angvlight_throttle(i) - angvbase_throttle(i);
    end

    angvchange_throttle = angvchange_throttle';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
   
    
    meanangvchange_throttle = nanmean(angvchange_throttle);
    
    [h p] = ttest2(angvchange_throttle,angvchange_emptysplit)
    res(n).angvchange_throttleh = h;
    res(n).angvchange_throttlep = p
    res(n).meanangvchange_throttle = meanangvchange_throttle;
end

for n=1:length(data(2))

    LAL073a = data(2).resblankalwayson10slightbuff;

    for i=1:length(LAL073a)
        angvbase_LAL073a(i) = nanmean(nanmean(LAL073a(i).angvturn(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        angvlight_LAL073a(i) = nanmean(nanmean(LAL073a(i).angvturn(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(angvbase_LAL073a)
        angvchange_LAL073a(i) = angvlight_LAL073a(i) - angvbase_LAL073a(i);
    end

    angvchange_LAL073a = angvchange_LAL073a';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
   
    
    meanangvchange_LAL073a = nanmean(angvchange_LAL073a);
    
    [h p] = ttest2(angvchange_LAL073a,angvchange_emptysplit)
    res(n).angvchange_LAL073ah = h;
    res(n).angvchange_LAL073ap = p;
    res(n).meanangvchange_LAL073a = meanangvchange_LAL073a;
end


for n=1:length(data(3))

    ss41947 = data(3).resblankalwayson10slightbuff;

    for i=1:length(ss41947)
        angvbase_ss41947(i) = nanmean(nanmean(ss41947(i).angvturn(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        angvlight_ss41947(i) = nanmean(nanmean(ss41947(i).angvturn(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(angvbase_ss41947)
        angvchange_ss41947(i) = angvlight_ss41947(i) - angvbase_ss41947(i);
    end

    angvchange_ss41947 = angvchange_ss41947';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
   
    
    meanangvchange_ss41947 = nanmean(angvchange_ss41947);

    [h p] = ttest2(angvchange_ss41947,angvchange_emptysplit)
    res(n).angvchange_ss41947h = h;
    res(n).angvchange_ss41947p = p;
    res(n).meanangvchange_ss41947 = meanangvchange_ss41947;
    
end

for n=1:length(data(4))

    smp092 = data(4).resblankalwayson10slightbuff;

    for i=1:length(smp092)
        angvbase_smp092(i) = nanmean(nanmean(smp092(i).angvturn(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        angvlight_smp092(i) = nanmean(nanmean(smp092(i).angvturn(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(angvbase_smp092)
        angvchange_smp092(i) = angvlight_smp092(i) - angvbase_smp092(i);
    end

    angvchange_smp092 = angvchange_smp092';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
   
    
    meanangvchange_smp092 = nanmean(angvchange_smp092);

    [h p] = ttest2(angvchange_smp092,angvchange_emptysplit)
    res(n).angvchange_smp092h = h;
    res(n).angvchange_smp092p = p;
    res(n).meanangvchange_smp092 = meanangvchange_smp092;
    
end