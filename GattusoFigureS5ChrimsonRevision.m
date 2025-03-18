function res = GattusoFigureS5ChrimsonRevision(data)
% load all data sets and compare effects of Chrimson activation

if nargin <1
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/Chrimson/vglutad_31a11db_chrimson.mat')
        data(1) = vglutad_31a11db_chrimson;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/Chrimson/SS49952 Chrimson.mat')
        data(2) = SS49952Chrimson;
    load('/Users/kvanhass/Library/CloudStorage/OneDrive-BowdoinCollege/Documents/Nagel Lab/LAL light pulse mat files/Chrimson/EmptySplit_Chrimson.mat')
        data(3) = EmptySplit_Chrimson;
end

%% plot effects of light on ground speed
for n=1:length(data(3))

    emptysplit = data(3).resblankalwayson10slightbuff;

    for i=1:length(emptysplit)
        vbase_emptysplit(i) = nanmean(nanmean(emptysplit(i).vmove(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        vlight_emptysplit(i) = nanmean(nanmean(emptysplit(i).vmove(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(vbase_emptysplit)                    % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
        vchange_emptysplit(i) = vlight_emptysplit(i) - vbase_emptysplit(i);

    end
    
    meanvchange_emptysplit = nanmean(vchange_emptysplit);

    res(n).meanvchange_emptysplit = meanvchange_emptysplit;
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

    [h p] = ttest2(vchange_tortuous,vchange_emptysplit)
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

    [h p] = ttest2(vchange_ss49952,vchange_emptysplit)
    res(n).vchange_ss49952h = h;
    res(n).vchange_ss49952p = p;
    res(n).meanvchange_ss49952 = meanvchange_ss49952;
    
end

%% plot effects of light on ang speed
for n=1:length(data(3))

    emptysplit = data(3).resblankalwayson10slightbuff;

    for i=1:length(emptysplit)
        vbase_emptysplit(i) = nanmean(nanmean(emptysplit(i).angvturn(1001:1500,:)));          % assigns the mean of v over the interval 1001:1500 to the ith term of vbase
        vlight_emptysplit(i) = nanmean(nanmean(emptysplit(i).angvturn(1501:2000,:)));         % the syntax v(1:10,:) takes rows 1:10 and all columns that exist
    end
    
    for i=1:length(vbase_emptysplit)                    % taking transpose turns the row vectors into column vectors for plotting, means, and statistical test below
        vchange_emptysplit(i) = vlight_emptysplit(i) - vbase_emptysplit(i);

    end
    
    meanvchange_emptysplit = nanmean(vchange_emptysplit);

    res(n).meanangvchange_emptysplit = meanvchange_emptysplit;
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

    [h p] = ttest2(vchange_tortuous,vchange_emptysplit)
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

    [h p] = ttest2(vchange_ss49952,vchange_emptysplit)
    res(n).angvchange_ss49952h = h;
    res(n).angvchange_ss49952p = p;
    res(n).meanangvchange_ss49952 = meanvchange_ss49952;
    
end