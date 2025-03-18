function nchangepts=change_point(res,restitle,c)

allgs=[];
allang=[];
for ii=1:size(res,2)
    allgs=[allgs reshape(res(ii).v,1,numel(res(ii).v))]; %concatenating all data into one vector
    allang=[allang reshape(diff(res(ii).uthetafilt),1,numel(diff(res(ii).uthetafilt)))];
end

allang=50*abs(allang);


%plotting an example time period
figure
plot(allang(11*3500:12*3500))
figure
findchangepts(allgs(11*3500:12*3500),'MinDistance',100,'MinThreshold',1000) %just a visual to see how well its doing
ipt=findchangepts(allgs,'MinDistance',100,'MinThreshold',1000);


% 
%calculating the mean ground speed and angular velocity for each epoch
meanvals=mean(allgs(1:ipt(1)));
meanangv=mean(allang(1:ipt(1)));
durs=ipt(1);
for ii=1:length(ipt)-1
    meanvals=[meanvals mean(allgs(ipt(ii):ipt(ii+1)))];
    meanangv=[meanangv mean(allang(ipt(ii):ipt(ii+1)))];
    durs=[durs ipt(ii+1)-ipt(ii)];
end
meanvals=[meanvals mean(allgs(ipt(end):end))];
meanangv=[meanangv mean(allang(ipt(end):end))];
%calculating duration of epochs
durs=[durs length(allgs)-ipt(end)];
durs=durs./50;% to get the duration in seconds
bins=[0:0.5:40];
mids=[0.25:0.5:39.75];

%this adds the mean values of each epoch in the first plot as a horizontal 
% line within the epoch and adds a second subplot to the first figure that 
% plots the angular velocity trace, average angular velocity and lines that 
% mark the boundaries between epochs
figure(1)
subplot(2,1,1)
plot(allgs(1:10000))
xline(ipt(ipt<10000))
hold on
plot([0 ipt(1)],[meanvals(1) meanvals(1)],'r');
for ii=1:numel(find(ipt<10000))-1
    plot([ipt(ii) ipt(ii+1)],[meanvals(ii+1) meanvals(ii+1)],'r');
end
plot([ipt(ii+1) 10000],[meanvals(ii+2) meanvals(ii+2)],'r');
subplot(2,1,2)
plot(allang(1:10000))
xline(ipt(ipt<10000))


%this plots three subplots- first a histogram of ground speeds, then a
%heatmap of mean ground speed vs mean angular velocity and finally a
%scatter plot that compares mean ground speed to the duration of the epoch
figure(4)
% set(gcf,'position',[100, 100, 1200, 700])
% subplot(1,3,1)
hold on
[n,edges]=histcounts(meanvals,bins,'Normalization','probability');
plot(mids,n,'Color',c, "LineWidth",2)
title('Distribution of mean ground speeds')
xlabel('mean ground speed (mm/s)')
ylabel('probability')
xlim([0 20])

figure
% subplot(1,3,2)
% hold on
ybin=[0:9:180];
xbin=[0:1:20];
a=hist3([meanangv' meanvals'],'edges',{ybin xbin});
a=a./sum(sum(a));
surf(a,'EdgeColor', 'none')
colormap('parula')
set(gca,'ColorScale','log')
xlabel('mean groundspeed')
ylabel('mean abs(angular velocity)')
title('groundspeed v angular velocity')
colorbar

figure
% subplot(1,3,3)
% hold on
plot(meanvals,durs,'.','Color',c)
ylabel('duration of epoch (s)')
xlabel('mean ground speed')
title('Duration vs mean ground speed')
ylim([0 100])
sgtitle(restitle)

nchangepts=length(ipt);
% findchangepts(vertcat(allgs,abs(allang)),'MinDistance',100,'MinThreshold',10)


%% putting things in groups
%here I chategorized epochs based on mean ground speed and dropped them
%into bins. I then calculated a transition matrix and create a
%visualization of it.
bunches=[2 6 10];
cat=[];
for kk=1:length(meanvals)
    if meanvals(kk)<=bunches(1)
        cat=[cat 1];
    end
    for ii=2:length(bunches)
        if meanvals(kk)> bunches(ii-1) && meanvals(kk)<= bunches(ii)
            cat=[cat ii];
        end
    end
    if meanvals(kk)>bunches(end)
        cat=[cat ii+1];
    end  
end
transitions=zeros(length(bunches)+1);

for ii=1:length(cat)-1
    transitions(cat(ii),cat(ii+1))=transitions(cat(ii),cat(ii+1))+1;
end
transitions=transitions./(length(cat)-1);
figure
heatmap(transitions)
colormap('gray')
xlabel('preceeding state')
ylabel('following state')

%for labels
cutoffsprint=sprintfc('%d',bunches);
cutoffsless=append('<', cutoffsprint, 'mm/s');
a=gca;
a.XData=['',cutoffsless append('>',cutoffsprint(end),'mm/s')];
a.YData=['',cutoffsless append('>',cutoffsprint(end),'mm/s')];



