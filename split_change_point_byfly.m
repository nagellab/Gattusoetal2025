function [fly,gs,counttraj]=split_change_point_byfly(res,c,cutoffs)
%res=data
%c=color for plotting the different categories
%cutoffs=boundaries of categories
% does change point detection on each trial of odor data then looks at the
% mean of the state that the fly is in 2 seconds prior to the onset of odor
% is. Using that mean, trials are categorized based off of the input
% 'cuttoffs'. 

%% setup
for kk=1:length(cutoffs)+1
    headingmean(kk).vals=[];
    gsmean(kk).vals=[];
    counttraj(kk).vals=[];
end
for ii=1:length(res) %gather our data
    gs=res(ii).v; %groundspeed
    orientation=res(ii).thetafilt; %orientation
    heading=abs(wrapTo180(orientation-90)); %shifting to relative heading (toward upwind)
for kk=1:length(cutoffs)+1 %so we have categories for each fly
    fly(ii).cats(kk).idx=[];    
end
gs(isnan(gs))=0; %zero out any NAN

%% completing change point detection and categorizing trials
for jj=1:size(gs,2) 
    ipt=findchangepts(gs(:,jj),'MinDistance',100,'MinThreshold',1000);
    %finding the mean of forward velocity for the behavioral epoch the fly
    %is in roughly 2 seconds before odor onset
    a=find(ipt<1400);
    b=find(ipt>1400);
    a=max(a);
    b=min(b);
    %calculate mean
    if isempty(a) && isempty(b) %if there is one epoch for the whole trial
        thismean=mean(gs(:,jj));
    elseif isempty(a)
        thismean=mean(gs(1:ipt(b),jj));
    elseif isempty(b)
        thismean=mean(gs(ipt(a):end,jj));
    else
        thismean=mean(gs(ipt(a):ipt(b),jj));
    end
    
    if thismean<cutoffs(1) %use mean ground speed to separate trials
        fly(ii).cats(1).idx=[fly(ii).cats(1).idx jj];
    elseif thismean>cutoffs(end)
        fly(ii).cats(length(cutoffs)+1).idx=[fly(ii).cats(length(cutoffs)+1).idx jj];
    else
        for mm=2:length(cutoffs)
            if thismean>cutoffs(mm-1) && thismean<cutoffs(mm)
                fly(ii).cats(mm).idx=[fly(ii).cats(mm).idx jj];
            end
        end
    end
end
%now that all the data is categorized, we want to get the mean of each
%category for each fly
for kk=1:length(fly(ii).cats)
    if isempty(gs(:,fly(ii).cats(kk).idx))==0 %check to make sure the category isn't empty
    gsmean(kk).vals=[gsmean(kk).vals mean(gs(:,fly(ii).cats(kk).idx),2)]; %take the mean and store it
    headingmean(kk).vals=[headingmean(kk).vals mean(heading(:,fly(ii).cats(kk).idx),2)];
    counttraj(kk).vals=[counttraj(kk).vals size(gs(:,fly(ii).cats(kk).idx),2)]; %keep track of how many trials from each fly for each category (and how many flies)
    end
end
end

%% plotting
figure
hold on
tim=28:1/50:70;
for ii=1:length(gsmean)
    overallmean_gs=mean(gsmean(ii).vals,2,'omitnan');
    overallst_gs=std(gsmean(ii).vals','omitnan');
    plot(tim,overallmean_gs(1400:end),c(ii),'LineWidth',2)
    top=overallmean_gs+overallst_gs'/sqrt(length(counttraj(ii).vals));
    bot=overallmean_gs-overallst_gs'/sqrt(length(counttraj(ii).vals));
    plot(tim,top(1400:end),c(ii))
    plot(tim,bot(1400:end),c(ii))
end
title('ground speed')
xlabel('time(s)')

figure
hold on
tim=28:1/50:70;
for ii=1:length(headingmean)
    overallmean_heading=mean(headingmean(ii).vals,2,'omitnan');
    overallst_heading=std(headingmean(ii).vals','omitnan');
    plot(tim,overallmean_heading(1400:3500),c(ii),'LineWidth',2)
    top=overallmean_heading+overallst_heading'/sqrt(length(counttraj(ii).vals));
    bot=overallmean_heading-overallst_heading'/sqrt(length(counttraj(ii).vals));
    plot(tim,top(1400:3500),c(ii))
    plot(tim,bot(1400:3500),c(ii))
end
title('relative heading (zero upwind)')
xlabel('time(s)')





