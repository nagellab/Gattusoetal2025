function twodhist_maker(res,timerange)
%plots 2dimensional histogram of angular velocity and ground speed 
binnumb = 30;
xbins = [0:30/binnumb:30]; %setting histogram bins
ybins = [-800:1600/binnumb:800];
out=zeros(size(xbins,2),size(ybins,2));
for ii=1:length(res)
    angvel = diff(res(ii).uthetafilt)*50;
    angvel=angvel(timerange,:);
    gs = res(ii).v(timerange,:);
    angvel=reshape(angvel,1, numel(angvel));
    gs=reshape(gs,1, numel(gs));
    thishist=hist3([gs' angvel'],"Edges",{xbins ybins});
    out=out+thishist./sum(sum(thishist));
end
out=out./length(res);
figure
h=surf(ybins,xbins,out);
set(gca,'zscale','log')
set(gca,'ColorScale','log')
set(h,'edgecolor','none')
grid off
colorbar
clim([10^-6 1])
view(2)