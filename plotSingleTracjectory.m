function plotSingleTracjectory(res,trial)

%plotSingleTrajectory(emptygal4kir.10salwaysonblank(1),1)
pre=[1:1500];
odor = [1501:2000];
offset = [2001:3500];

% get forward and angular velocity
gs = res.v(:,trial);
uwindv = res.vy(:,trial);

avel = 50*diff(res.uthetafilt(:,trial)); 

% plot single trajectory, color coded for stimulus 
% figure; 
% subplot(1,2,1); 
figure('Renderer', 'painters', 'Position', [50 50 1400 700 ])
subplot('Position',[0.1 0.1 0.1 0.70]) %creates correct aspect ratio
plot(res.xfilt(pre,trial),res.yfilt(pre,trial),'k','LineWidth',1)
hold on; plot(res.xfilt(odor,trial),res.yfilt(odor,trial),'r','LineWidth',1)
hold on; plot(res.xfilt(offset,trial),res.yfilt(offset,trial),'b','LineWidth',1)
title('pre odor \color{red} during odor \color{blue}after odor')
axis([0 40 0 140]);

% % plot single trajectory, color coded for forward velocity 
ncolors = 10;
c = colormap;% c = flipud(c);
c = c(1:floor(length(c)/ncolors):end,:); 
subplot('Position',[0.3 0.1 0.1 0.7]); plot(res.xfilt(odor,trial),res.yfilt(odor,trial),'k','LineWidth',1); hold on; 
for n=1:ncolors
    ind = find(gs>20/ncolors*(n-1));
    plot(res.xfilt(ind,trial),res.yfilt(ind,trial),'.','LineWidth',1,'color',c(n,:)); hold on; 
end
title('forward velocity overlay')

axis([0 40 0 140]);
% set(gcf,'Position',[26   169   455   524]);

% % plot forward and angular velocity
% figure; 
subplot('Position',[0.5 0.55 0.45 0.4]); plot(gs,'k','LineWidth',1);
hold on
plot(odor,gs(odor),'r','LineWidth',1);
plot(offset,gs(offset),'b','LineWidth',1);
ylabel('forward velocity (mm/s)');
axis([0 3500 -1 25])

subplot('Position',[0.5 0.05 0.45 0.4]); plot(avel,'k','LineWidth',1); 
hold on
plot(odor,avel(odor),'r','LineWidth',1);
plot(offset,avel(offset),'b','LineWidth',1);
ylabel('angular velocity (deg/s)');
axis([0 3500 -500 500])
% 
% set(gcf,'Position',[482   408   600   400]);

% plot forward vs angular velocity
% figure;
% plot(avel,fvel,'k.');
% hold on; plot(avel(odor),fvel(odor),'r.');
% hold on; plot(avel(offset),fvel(offset),'b.');
% 
% set(gcf,'Position',[955   416   319   277]);


