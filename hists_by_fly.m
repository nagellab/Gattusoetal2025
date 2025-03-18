function hists_by_fly(res, timerange, c)
%author: Hannah Gattuso
% generated historgrams of angular velocity and ground speed. calculates a
% histogram for each fly and then calculates mean and SE across flies.

avelbins=-600:50:600; %bins for angular velocity
amids=-575:50:575;

gsbins=0:1:30; %1mm/s bins for groundspeed
gmids=0.5:1:29.5;

avelhist=[];
gshist=[];

%get a histogram for each fly for both angular velocity and ground speed
for ii=1:length(res)
    avel=50*diff(res(ii).uthetafilt);
    avel=avel(timerange,:);
    gs=res(ii).v(timerange,:);
    avelhist=[avelhist histcounts(avel,avelbins,'Normalization','probability')'];
    gshist=[gshist histcounts(gs,gsbins,'Normalization','probability')'];
end


%get average histogram across flies and plot with standard errror 

%angular velocity
figure(1)
hold on
plot(amids,mean(avelhist,2),c, 'LineWidth',1)
se=std(avelhist')./sqrt(ii);
plot(amids,mean(avelhist,2)-se',c,'LineWidth',0.5)
plot(amids,mean(avelhist,2)+se',c,'LineWidth',0.5)
set(gca, 'YScale', 'log')
ylim([10^-5 1])

%ground speed
figure(2)
hold on
plot(gmids, mean(gshist,2),c, 'LineWidth',1)
se=std(gshist')./sqrt(ii);
plot(gmids, mean(gshist,2)-se',c,'LineWidth',0.5)
plot(gmids, mean(gshist,2)+se',c,'LineWidth',0.5)
set(gca, 'YScale', 'log')
ylim([10^-5 1])