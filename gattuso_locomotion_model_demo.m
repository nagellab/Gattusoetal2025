% gattuso_locomotion_model_demo: a demo of locomotion trajectories, making a montage
% with a range of param values of self-excitation and cross-inhibition
% calls gattuso_locomotion_model_JV(B,XLR,XLR2,XS,XX,sw,plotting,deltaT)
%
% this creates Figure S4 of Gattuso et al., 2025
% via clear; gattuso_locomotion_model_demo
%
% calls gattuso_locomotion_model_JV;
%
% JV
%
if ~exist('random_seed')
    rng('default');
else
    rng(random_seed);
end
if ~exist('b_list') b_list=[0.7:0.1:0.9]; end
if ~exist('I_C_list') I_C_list=-[0.005:.01:.055]; end
if ~exist('I_C2_offset') I_C2_offset=-0.01; end %only matters if sw is supplied
if ~exist('I_S') I_S=-0.03; end
if ~exist('n_pre') n_pre=1500;end
if ~exist('n_during') n_during=500; end
if ~exist('n_post') n_post=1500; end
if ~exist('deltaT') deltaT=0.02; end
%  plot options
if ~exist('plot_fracmarg') plot_fracmarg=0.05;end %a fractional margin for the plots
if ~exist('plot_keepticks') plot_keepticks=0; end %1 to keep ticks
% 
sw=[zeros(1,n_pre),ones(1,n_during),zeros(1,n_post)];
triallength=length(sw);
%
if any(sw>0)
    pre_odor=[1:min(find(sw>0)-1)];
    during_odor=[min(find(sw>0)):max(find(sw>0))];
    post_odor=[max(find(sw>0))+1:triallength];
else
    pre_odor=[1:triallength];
    during_odor=[];
    post_odor=[];
end
%
figure;
set(gcf,'Position',[100 100 1200 800]);
set(gcf,'NumberTitle','off');
set(gcf,'Name',sprintf(' b: %7.3f to %7.3f, IC: %7.3f to %7.3f',min(b_list),max(b_list),max(I_C_list),min(I_C_list)));
%
nb=length(b_list);
nI=length(I_C_list);
res=cell(nb,nI);
for ib=1:nb
    for iI=1:nI
        b=b_list(ib);
        I_C=I_C_list(iI);
        I_C2=I_C+I_C2_offset;
        res{ib,iI}=gattuso_locomotion_model_JV(b,I_C,I_C2,I_S,0,sw',NaN);
    end
end
for ib=1:nb
    for iI=1:nI
        b=b_list(ib);
        I_C=I_C_list(iI);
        subplot(nb,nI,iI+(ib-1)*nI);
        xvals=res{ib,iI}.x;
        yvals=res{ib,iI}.y;
        plot(xvals(pre_odor),yvals(pre_odor),'k'); hold on;
        plot(xvals(during_odor),yvals(during_odor),'r'); hold on;
        plot(xvals(post_odor),yvals(post_odor),'b'); hold on;
        %
        xl=get(gca,'XLim');
        set(gca,'XLim',xl+diff(xl)*plot_fracmarg*[-1 1]);
        yl=get(gca,'YLim');
        set(gca,'YLim',yl+diff(yl)*plot_fracmarg*[-1 4]); %more room at top
        axis equal
        box off;
        string_params=sprintf('b=%4.2f I_C=%7.3f',b,I_C);
        string_eivs=cat(2, ...
            '\lambda_E=',sprintf('%6.2f',res{ib,iI}.eigs_anti(1,1)),...
            ' \lambda_E_+_2_C=',sprintf('%6.2f',res{ib,iI}.eigs_anti(1,2))...
         );
         text(.05,0.95,string_eivs,'FontSize',7,'Units','normalized','Color','k');
        if n_post>0
            I_C2=I_C+I_C2_offset;
            string_params=cat(2,string_params,sprintf(' %7.3f',I_C2));
            string_eivs2=cat(2,...
            '\lambda_E=',sprintf('%6.2f',res{ib,iI}.eigs_anti(2,1)),...
            ' \lambda_E_+_2_C=',sprintf('%6.2f',res{ib,iI}.eigs_anti(2,2))...
             );
            text(.05,0.88,string_eivs2,'FontSize',7,'Units','normalized','Color','b');
        end
        title(string_params);
    end
end
