function RNNassess(trialnum, toplot)
%% desired stimulus
S = zeros(3500,1); S(1501:2000)=0.6;

%% creating some variables for later
pref=[];
prea=[];
durf=[];
dura=[];
postf=[];
posta=[];

fxpref=[];
fxdurf=[];
fxpostf=[];
fxprea=[];
fxdura=[];
fxposta=[];


theta=[];
%% runs desired number of sample trials with indicated parameters
for ii = 1:trialnum
    res(ii) = gattuso_locomotion_model(0.8,-0.015,-0.025,-0.03,0,S,toplot); %change the values here to alter the parameters of the model

    pref=[pref res(ii).v(1:1500)];
    durf=[durf res(ii).v(1501:2000)];
    postf=[postf res(ii).v(2001:3500)];
    prea=[prea res(ii).a(1:1500)];
    dura=[dura res(ii).a(1501:2000)];
    posta=[posta res(ii).a(2001:3500)];
    theta=[theta;res(ii).theta];
    
   %separating the parts of the trials for the autocorrelation 
   fxpref=[fxpref ;  res(ii).v(1:1500)];
   fxdurf=[fxdurf ;  res(ii).v(1501:2000)];
   fxpostf=[fxpostf ;  res(ii).v(2001:3500)];
   fxprea=[fxprea ;  res(ii).a(1:1500)];
   fxdura=[fxdura ;  res(ii).a(1501:2000)];
   fxposta=[fxposta ;  res(ii).a(2001:3500)];
    
end

%% Summary

% % 2D hist
fedges=[0:1:30];
aedges=-625:50:625;%rad2deg([-25:1:25]);
fbins = [0.5:1:29.5];
abins=-600:50:600;%rad2deg([-24.5:1:24.5]);


figure(2); 
hold on
% f=histcounts(pref,'BinEdges', fedges, 'Normalization', 'probability');
% plot(fbins,f,'k', 'LineWidth',1)
% hold on
f=histcounts(postf,'BinEdges', fedges, 'Normalization', 'probability');
plot(fbins,f,'c', 'LineWidth',1)
set(gca, 'yscale', 'log')
title('Forward Velocity')
figure(1); hold on;
% a=histcounts(prea,'BinEdges', aedges, 'Normalization', 'probability');
% plot(abins,a,'k', 'LineWidth',1)
hold on
a=histcounts(posta,'BinEdges', aedges, 'Normalization', 'probability');
plot(abins,a,'c', 'LineWidth',1)
set(gca, 'yscale', 'log')
title('Angular Velocity')
xlim([-800 800])


%% autocorrelation of angular velocity
for m=trialnum:-1:1
[xapre(m,:),prelags]=xcorr(fxprea(m,:)-mean(fxprea(m,:))*ones(size(fxprea(m,:))),'coeff');
[xadur(m,:),durlags]=xcorr(fxdura(m,:)-mean(fxdura(m,:))*ones(size(fxdura(m,:))),'coeff');
[xapost(m,:), postlags]=xcorr(fxposta(m,:)-mean(fxposta(m,:))*ones(size(fxposta(m,:))),'coeff');
 end

xapremean=mean(xapre);
xadur=mean(xadur);
xapost=mean(xapost);

figure(3)
hold on
plot(prelags, xapremean,'k','LineWidth',1)
hold on
plot(durlags, xadur,'r','LineWidth',1)
plot(postlags, xapost, 'c', 'LineWidth',1)
axis([-1500 1500 -0.3 1])
title('Angular Velocity Autocorrelation')





