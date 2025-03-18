function icontraimpact_compareunits(trialnum, icval)

S = zeros(3500,1); % no odor stim

for ii=1:trialnum
res(ii) = gattuso_locomotion_model(0.8,icval,icval,-0.03,0.025,S,0);
end





%% plotting
% U1 vs U2
z=[];
for ii=1:length(res)
    a=res(ii).U(:,1)'-ones(1,length(res(ii).U(:,1)))*mean(res(ii).U(:,1));
    b=res(ii).U(:,2)'-ones(1,length(res(ii).U(:,2)))*mean(res(ii).U(:,2));
    [out,lags]=xcorr(a,b,'coeff');
    z=[z; out];
end
zmean=mean(z);
zse=std(z)./sqrt(length(res));
lags=lags./50; %to put it in s instead of samples
figure
hold on
subplot(1,3,1)
hold on
plot(lags,zmean,'k','LineWidth',1)
plot(lags,zmean+zse,'k','LineWidth',0.5)
plot(lags,zmean-zse,'k','LineWidth',0.5)


%U1 vs U5
z=[];
for ii=1:length(res)
    a=res(ii).U(:,1)'-ones(1,length(res(ii).U(:,1)))*mean(res(ii).U(:,1));
    b=res(ii).U(:,5)'-ones(1,length(res(ii).U(:,5)))*mean(res(ii).U(:,5));
    [out,lags]=xcorr(a,b,'coeff');
    z=[z; out];
end
zmean=mean(z);
zse=std(z)./sqrt(length(res));
lags=lags./50; %to put it in s instead of samples
subplot(1,3,2)
hold on
plot(lags,zmean,'b','LineWidth',1)
plot(lags,zmean+zse,'b','LineWidth',0.5)
plot(lags,zmean-zse,'b','LineWidth',0.5)

%U1 vs U3
z=[];
for ii=1:length(res)
    a=res(ii).U(:,1)'-ones(1,length(res(ii).U(:,1)))*mean(res(ii).U(:,1));
    b=res(ii).U(:,3)'-ones(1,length(res(ii).U(:,3)))*mean(res(ii).U(:,3));
    [out,lags]=xcorr(a,b,'coeff');
    z=[z; out];
end
zmean=mean(z);
zse=std(z)./sqrt(length(res));
lags=lags./50; %to put it in s instead of samples
subplot(1,3,3)
hold on
plot(lags,zmean,'r','LineWidth',1)
plot(lags,zmean+zse,'r','LineWidth',0.5)
plot(lags,zmean-zse,'r','LineWidth',0.5)
linkaxes
xlim([-10 10])
sgtitle(['Ic = ' num2str(icval) ' Unit 1 vs Unit2 \color{blue} Unit1 vs Unit 5 \color{red} Unit 1 vs Unit 3'])

