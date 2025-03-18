function automobile_errorbars(res,f)
%inputs- unfiltered angular velocity and corresponding fly identities
%(keeps track of which trials come from which fly). This data comes from
%the code avel_nofilt.mat
%calculates the autocorrelation of angular velocity and then plots the mean
%across flies with standard error
precross=zeros(999, size(res,2));
durcross=zeros(999, size(res,2));
postcross=zeros(999, size(res,2));
for ii = 1:size(res,2)
    res(isnan(res(:,ii)),ii)=0;
    [precross(:,ii), prelags] = xcorr(res(1001:1500,ii)-mean(res(1001:1500,ii))*ones(size(res(1001:1500,ii))),'coeff');
    [durcross(:,ii), durlags] = xcorr(res(1501:2000,ii)-mean(res(1501:2000,ii))*ones(size(res(1501:2000,ii))),'coeff');
    [postcross(:,ii), postlags] = xcorr(res(2001:2500, ii)-mean(res(2001:2500,ii))*ones(size(res(2001:2500,ii))),'coeff');
end
flypremeans=[];
flydurmeans=[];
flypostmeans=[];
for ii=1:max(f)
    thisfly=find(f==ii);
    flypremeans=[flypremeans mean(precross(:,thisfly),2)];
    flydurmeans=[flydurmeans mean(durcross(:,thisfly),2)];
    flypostmeans=[flypostmeans mean(postcross(:,thisfly),2)];
end

overallpremean=mean(flypremeans,2);
prese=std(flypremeans')./sqrt(max(f));
overalldurmean=mean(flydurmeans,2);
durse=std(flydurmeans')./sqrt(max(f));
overallpostmean=mean(flypostmeans,2);
postse=std(flypostmeans')./sqrt(max(f));

figure
hold on
plot(prelags,overallpremean,'k','LineWidth',1.5)
hold on
plot(prelags, overallpremean+prese','k','LineWidth',0.5)
plot(prelags, overallpremean-prese','k','LineWidth',0.5)


plot(durlags,overalldurmean,'r','LineWidth',1.5)
hold on
plot(durlags, overalldurmean+durse','r','LineWidth',0.5)
plot(durlags, overalldurmean-durse','r','LineWidth',0.5)


plot(postlags,overallpostmean,'c','LineWidth',1.5)
hold on
plot(postlags, overallpostmean+postse','c','LineWidth',0.5)
plot(postlags, overallpostmean-postse','c','LineWidth',0.5)

xlim([-100 100])
forlabels=str2double(xticklabels);
xticklabels(forlabels./50) %convert lags to seconds