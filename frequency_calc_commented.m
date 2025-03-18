function out = frequency_calc_commented(avel,flynumb,color)
%Author:Hannah Gattuso

%% finding turn frequency 
avel = avel*50; 

lturnstarts = zeros(size(avel)); %making empty matrices to drop turn starts and ends into 
lturnends = zeros(size(avel));
rturnstarts = zeros(size(avel));
rturnends = zeros(size(avel));

for ii = 1:length(avel(1,:))
    thisavel = avel(:,ii);
    ls = gettimestamps(+45,thisavel,'+'); %finds instances where angular velocity rises above 45 degrees per second 
    le = gettimestamps(+45,thisavel,'-');
    rs = gettimestamps(-45,thisavel,'-');%finds instances where angular velocity falls below 45 degrees per second 
    re = gettimestamps(-45,thisavel,'+');
    lturnstarts(ls,ii) = 1; %creates sparse matrix of turn starts and ends (independently)
    lturnends(le,ii) =1;
    rturnstarts(rs,ii) = 1;
    rturnends(re,ii) =1;
   
end

%outputs for further use
out.lturnstarts=lturnstarts;
out.rturnstarts = rturnstarts;
out.turnstart=lturnstarts+rturnstarts;
allturns=lturnstarts+rturnstarts; 

%gets interturn intervals for each fly
for kk=1:max(flynumb)
    whichones=find(flynumb==kk);
    iti(kk).vals=[];
    for ii=1:size(allturns(:,whichones),2)
        iti(kk).vals=[iti(kk).vals diff(find(allturns(:,whichones(ii))==1))'];
    end
    iti(kk).vals=iti(kk).vals./50;
end
a=[];
%gets the histogram for each fly
for kk=1:max(flynumb)
    a=[a histcounts(iti(kk).vals,0:0.25:5,'Normalization','probability')'];
end
% figure
% plot(a)

%mean and standard error across flies 
amean=mean(a,2);
ase=std(a')./sqrt(max(flynumb));

%plotting
figure(1)
hold on
binctrs=[0.25/2:0.5/2:4.875];
plot(binctrs,amean,color,'LineWidth',1)
plot(binctrs,amean-ase',color,'LineWidth',0.25)
plot(binctrs,amean+ase',color,'LineWidth',0.25) 
xlabel('Inter-Turn Interval (s)')
ylabel('probability')

