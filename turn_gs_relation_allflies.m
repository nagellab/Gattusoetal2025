function turn_gs_relation_allflies(res)
% splits trials by ground speed before the onset of a turn. Then, plots angular velocity and ground speed 
fs=50; %sampling rate of data
avel=[];
gs=[];
for ii=1:length(res)
    avel=[avel fs*abs(diff(res(ii).uthetafilt))]; %calcualte angular velocity
    gs=[gs res(ii).v]; %calculate forward velocity
end
size(gs)
precross=25;
postcross=35;
chunksavel=[];
chunksgs=[];

for mm=1:size(avel,2)
    turnstart=gettimestamps(+45, avel(:,mm), '+'); %find where turns start
    turnstart(turnstart<precross+1)=[];% %gets rid of turns that start less than half a second before the trial starts
    turnstart(turnstart>(length(avel)-postcross))=[];%gets rid of turns that start less than one second before end of trial
    for kk=1:length(turnstart)
        chunksavel=[chunksavel avel(turnstart(kk)-precross:turnstart(kk)+postcross,mm)]; %window of half a second before turn and second after (gathers all turns for a fly)
        chunksgs=[chunksgs gs(turnstart(kk)-precross:turnstart(kk)+postcross,mm)];
    end
end
thresh=[1 3 8 12 18];
gsmeans=mean(chunksgs(1:25,:)); %gets mean gs for the second around the turn onset
[vals, idx]=sort(gsmeans);
chunksavel=chunksavel(:,idx);
chunksgs=chunksgs(:,idx);

gscat(1).vals=chunksgs(:,1:max(find(vals<thresh(1))));
avelcat(1).vals=chunksavel(:,1:max(find(vals<thresh(1))));
for ii=2:length(thresh)
    w=min(find(vals>thresh(ii-1))):max(find(vals<thresh(ii)));
    gscat(ii).vals=chunksgs(:,w);
    avelcat(ii).vals=chunksavel(:,w);
end
gscat(length(thresh)+1).vals=chunksgs(:,min(find(vals>thresh(end))):end);
avelcat(length(thresh)+1).vals=chunksavel(:,min(find(vals>thresh(end))):end);

gsmeans=[];
gsse=[];
avelmeans=[];
avelse=[];
for ii=1:length(gscat)
    gsmeans=[gsmeans mean(gscat(ii).vals,2)];
    gsse=[gsse (std(gscat(ii).vals')./sqrt(size(gscat(ii).vals,2)))'];
    avelmeans=[avelmeans mean(avelcat(ii).vals,2)];
    avelse=[avelse (std(avelcat(ii).vals')./sqrt(size(avelcat(ii).vals,2)))'];
end
colormap("prism")
c=colormap;
a=floor(size(c,1)/size(gsmeans,2));
ts=-1*precross/fs:1/fs:postcross/fs;

%c(ii*a,:)
figure
subplot(1,2,1)
for ii=1:size(avelmeans,2)
    plot(ts,avelmeans(:,ii),'color',c(ii,:),'LineWidth',1)
    hold on
    plot(ts,avelmeans(:,ii)+avelse(:,ii),'color',c(ii,:),'LineWidth',1)
    plot(ts,avelmeans(:,ii)-avelse(:,ii),'color',c(ii,:),'LineWidth',1)
    xline(0,'k')
end
subplot(1,2,2)
for ii=1:size(gsmeans,2)
    plot(ts,gsmeans(:,ii),'color',c(ii,:),'LineWidth',1)
    hold on
    plot(ts,gsmeans(:,ii)+gsse(:,ii),'color',c(ii,:),'LineWidth',1)
    plot(ts,gsmeans(:,ii)-gsse(:,ii),'color',c(ii,:),'LineWidth',1)
    xline(0,'k')

end
