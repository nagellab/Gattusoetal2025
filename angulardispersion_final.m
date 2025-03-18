function out= angulardispersion_final(res)
%Author: Hannah Gattuso
%out = angulardispersion(control.pulse10s);



%creating window for plotting
figure('Renderer', 'painters', 'Position', [50 10 800 800])

%% setting up parameters
thetameanpre=[];
thetameandur=[];
thetameanpost=[];
for ii=1:size(res,2)
    theta=res(ii).uthetafilt; %all angular velocities from all trails for a single genotype
    %preodor
    thetastarttpre=theta(1,:).*ones(1500,size(theta,2)); %get starting x and y values
    thetadiffpre=(theta(1:1500,:)-thetastarttpre); %calculate difference between starting heading and current heading
    thetameanpre=[thetameanpre mean(abs(thetadiffpre'))']; %take absolute value and mean
    %during odor
    thetastarttdur=theta(1500,:).*ones(500,size(theta,2)); %get starting x and y values
    thetadiffdur= (theta(1501:2000,:)-thetastarttdur);%calculate difference between starting heading and current heading
    thetameandur=[thetameandur mean(abs(thetadiffdur'))']; %take absolute value and mean
    %post odor
    thetastarttpost=theta(2000,:).*ones(1500,size(theta,2)); %get starting x and y values
    thetadiffpost=(theta(2001:3500,:)-thetastarttpost);%calculate difference between starting heading and current heading
    thetameanpost=[thetameanpost mean(abs(thetadiffpost'))']; %take absolute value and mean
end

size(thetameanpost)



%% pre odor

thetamean=mean(thetameanpre,2); %take absolute value and mean
thetase=std(thetameanpre')./sqrt(size(thetameanpre,2)); %standard error calculation

%plotting mean and errorbars
hold on
plot(thetamean,'k', 'LineWidth',1)
plot(thetamean+thetase','k','LineWidth',0.5)
plot(thetamean-thetase','k','LineWidth',0.5)
out.pre=thetamean;

%% during odor

thetamean=mean(thetameandur,2); %take absolute value and mean
thetase=std(thetameandur')./sqrt(size(thetameandur,2));%standard error calculation

%plotting mean and errorbars
hold on
plot(thetamean,'r', 'LineWidth',1)
plot(thetamean+thetase','r','LineWidth',0.5)
plot(thetamean-thetase','r','LineWidth',0.5)
out.dur=thetamean;
 
%% post odor
 
thetamean=mean(thetameanpost,2); %take absolute value and mean
thetase=std(thetameanpost')./sqrt(size(thetameanpost,2));%standard error calculation

%plotting mean and errorbars
hold on
plot(thetamean,'b', 'LineWidth',1)
plot(thetamean+thetase','b','LineWidth',0.5)
plot(thetamean-thetase','b','LineWidth',0.5)
out.post=thetamean;
