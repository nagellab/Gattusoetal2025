function res = GattusoFigureS5GtACRRevision(data)
% load all data sets and compare effects of Chrimson activation

if nargin <1
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/vglutad_31a11db_gtacrfull.mat')
        data(1) = vglutad_31a11db_gtacrfull;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/ss49952_gtacr(III).mat')
        data(2) = ss49952_gtacrIII;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/gtacr/emptysplit_gtacriii.mat')
        data(3) = emptysplit_gtacriii;
end

%% plot effects of light on ground speed
for n=1:length(data(3))

    emptysplit_iii = data(3).resblankalwayson10slightbuff;

    for i=1:length(emptysplit_iii)
        vbase_emptysplit_iii(i) = nanmean(nanmean(emptysplit_iii(i).vmove(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        vlight_emptysplit_iii(i) = nanmean(nanmean(emptysplit_iii(i).vmove(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(vbase_emptysplit_iii)                    % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
        vchange_emptysplit_iii(i) = vlight_emptysplit_iii(i) - vbase_emptysplit_iii(i);

    end
    
    meanvchange_emptysplit_iii = nanmean(vchange_emptysplit_iii);

    res(n).meanvchange_emptysplit_iii = meanvchange_emptysplit_iii;
end


for n=1:length(data(1))

    tortuous = data(1).resblankalwayson10slightbuff;

    for i=1:length(tortuous)
        vbase_tortuous(i) = nanmean(nanmean(tortuous(i).vmove(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        vlight_tortuous(i) = nanmean(nanmean(tortuous(i).vmove(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(vbase_tortuous)
        vchange_tortuous(i) = vlight_tortuous(i) - vbase_tortuous(i);
    end

    vchange_tortuous = vchange_tortuous';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
   
    
    meanvchange_tortuous = nanmean(vchange_tortuous);

    [h p] = ttest2(vchange_tortuous,vchange_emptysplit_iii)
    res(n).vchange_tortuoush = h;
    res(n).vchange_tortuousp = p;
    res(n).meanvchange_tortuous = meanvchange_tortuous;
    
end

for n=1:length(data(2))

    ss49952 = data(2).resblankalwayson10slightbuff;

    for i=1:length(ss49952)
        vbase_ss49952(i) = nanmean(nanmean(ss49952(i).vmove(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        vlight_ss49952(i) = nanmean(nanmean(ss49952(i).vmove(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(vbase_ss49952)
        vchange_ss49952(i) = vlight_ss49952(i) - vbase_ss49952(i);
    end

    vchange_ss49952 = vchange_ss49952';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
   
    
    meanvchange_ss49952 = nanmean(vchange_ss49952);

    [h p] = ttest2(vchange_ss49952,vchange_emptysplit_iii)
    res(n).vchange_ss49952h = h;
    res(n).vchange_ss49952p = p;
    res(n).meanvchange_ss49952 = meanvchange_ss49952;
    
end

%% plot effects of light on ang speed
for n=1:length(data(3))

    emptysplit_ii = data(3).resblankalwayson10slightbuff;

    for i=1:length(emptysplit_ii)
        vbase_emptysplit_ii(i) = nanmean(nanmean(emptysplit_ii(i).angvturn(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        vlight_emptysplit_ii(i) = nanmean(nanmean(emptysplit_ii(i).angvturn(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(vbase_emptysplit_ii)                    % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
        vchange_emptysplit_ii(i) = vlight_emptysplit_ii(i) - vbase_emptysplit_ii(i);

    end
    
    meanvchange_emptysplit_iii = nanmean(vchange_emptysplit_iii);

    res(n).meanangvchange_emptysplit_iii = meanvchange_emptysplit_iii;
end


for n=1:length(data(1))

    tortuous = data(1).resblankalwayson10slightbuff;

    for i=1:length(tortuous)
        vbase_tortuous(i) = nanmean(nanmean(tortuous(i).angvturn(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        vlight_tortuous(i) = nanmean(nanmean(tortuous(i).angvturn(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(vbase_tortuous)
        vchange_tortuous(i) = vlight_tortuous(i) - vbase_tortuous(i);
    end

    vchange_tortuous = vchange_tortuous';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
   
    
    meanvchange_tortuous = nanmean(vchange_tortuous);

    [h p] = ttest2(vchange_tortuous,vchange_emptysplit_iii)
    res(n).angvchange_tortuoush = h;
    res(n).angvchange_tortuousp = p;
    res(n).meanangvchange_tortuous = meanvchange_tortuous;
    
end

for n=1:length(data(2))

    ss49952 = data(2).resblankalwayson10slightbuff;

    for i=1:length(ss49952)
        vbase_ss49952(i) = nanmean(nanmean(ss49952(i).angvturn(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        vlight_ss49952(i) = nanmean(nanmean(ss49952(i).angvturn(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(vbase_ss49952)
        vchange_ss49952(i) = vlight_ss49952(i) - vbase_ss49952(i);
    end

    vchange_ss49952 = vchange_ss49952';                     % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
   
    
    meanvchange_ss49952 = nanmean(vchange_ss49952);

    [h p] = ttest2(vchange_ss49952,vchange_emptysplit_iii)
    res(n).angvchange_ss49952h = h;
    res(n).angvchange_ss49952p = p;
    res(n).meanangvchange_ss49952 = meanvchange_ss49952;
    
end