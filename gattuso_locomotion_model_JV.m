function res = gattuso_locomotion_model_JV(B,XLR,XLR2,XS,XX,SW,plotting,deltaT)
% JV mods:
% added plots of timecourses
% odor on and off automatically detected from SW, and used for coloring plots
% allow for arbitrary length of SW
% include explicit timestep, deltaT (defaults to 0.020 ms)
% paramerter labeling in plots
% calculation of analytic eigenvalues
% rotation into symmetry-splitting variables
% rotation into eigenvectors and plots
%
% standard params per HG:
% sw=[zeros(1,1500) ones(1,500) zeros(1,1500)];
% gattuso_locomotion_model(0.8,-0.015,-0.025,-0.03,0,sw',0)
%
% multiple AR model of fvel and avel

%
if (nargin<=7)
    deltaT=0.02; %standard time step is 20 ms
end
%activation function params
a0=10.;
a1=8.;

%triallength = 3500;
triallength=length(SW);
%determne pre and post-odor periods from SW
if any(SW>0)
    pre_odor=[1:min(find(SW>0)-1)];
    during_odor=[min(find(SW>0)):max(find(SW>0))];
    post_odor=[max(find(SW>0))+1:triallength];
else
    pre_odor=[1:triallength];
    during_odor=[];
    post_odor=[];
end
tstring=sprintf('B=%7.4f XLR=%7.4f XLR_2=%7.4f XS=%7.4f XX=%7.4f',B,XLR,XLR2,XS,XX);


tonic=0; 

W = [B XX XS XLR XLR;       % network weights baseline period
    XX B XS XLR XLR;
     XS XS B XS XS;
    XLR XLR XS B XX;
    XLR XLR XS XX B];

W2 = [B XX XS XLR2 XLR2;       %network weights for offset period
    XX B XS XLR2 XLR2;
     XS XS B XS XS;
    XLR2 XLR2 XS B XX;
    XLR2 XLR2 XS XX B];

S = [1;1;0;-1;-1]*SW';       % sensory input (wind orientation)
SS = [0;0;-.1;0;0]*SW';      % supress stopping during odor

nvar=size(W,1);

n = randn(size(W,1),triallength); %noise component for each neuron

U = [0.1; 0.1 ;0 ;0.1; 0.1];
v(1) = 0;
a(1) = 0;

x(1) = 0;
y(1) = 0;
theta(1) = 2*pi*rand(1);

for i=2:triallength
    if ~ismember(i,post_odor) %detect odor off from SW
%    if i<=2000
        U(:,i) = act(W*U(:,i-1) + S(: ,i-1)*sin(theta(i-1)-pi/2) + SS(:,i) + 1*n(:,i)+tonic,a0,a1);
        
    else
        
        U(:,i) = act(W2*U(:,i-1) + S(:,i-1)*sin(theta(i-1)-pi/2) + SS(:,i) + 1*n(:,i)+tonic,a0,a1);
    end
    
    if U(3,i)>0 %forces a stop if the stop node is positive
        v(i) = 0;
    else    %otherwise the forward velocity is a linear combination of the nodes
        v(i) = (1.6*max(0,sum(U([1 5],i)))) + 0.5*max(0,sum(U([2 4],i)));   %unit/sec
    end

    if U(3,i)>0     %again forces the angular velocity to be zero if the stop node is engaged
        a(i) = 0;
    else %makes the angular velocity the difference across the sides
%         a(i) = act2(0.1*diff(U([1 5],i))+0.17*diff(U([2 4],i))); %rad/sec
        a(i) = 0.2*diff(U([1 5],i))+0.35*diff(U([2 4],i));

    end
  
    theta(i) = theta(i-1)+a(i)/50;
    [dx, dy] = pol2cart(theta(i),v(i)/50); %converting to x and y coordinates and make unit/sample
    x(i) = x(i-1)+dx;
    y(i) = y(i-1)+dy;
    
end
%analysis
k_E=(1/deltaT)*(a0/a1*B-1);
k_S=-(1/deltaT)*(a0/a1)*XS;
k_C=-(1/deltaT)*(a0/a1)*[XLR XLR2]';
kSC=sqrt(k_C.^2+4*k_S.^2);

%transformed versions of the underlying variables
hr2=1/sqrt(2);
R= [hr2  0  0   0 hr2;...
    0  hr2  0  hr2 0 ;...
    0   0   1   0  0 ;...
    0 -hr2  0  hr2 0 ;...
   -hr2 0   0  0 hr2];
rot_names={'y_1','y_2','y_3','z_1','z_2'}; %names of rotated variables

Urot=R*U; %rotated variables based on symmetry
%Eigenvalues, eigenvectors will depend on baseline vs odor-off params (iv loop)
%
for iv=1:2
    eigs_sym(iv,:)=k_E+[0 -k_C(iv)+[1 -1]*kSC(iv)];
    eigs_anti(iv,:)=k_E+[0 2*k_C(iv)];
    L(:,:,iv)=[...
        k_E       0    -k_S -k_C(iv) -k_C(iv);...
         0       k_E   -k_S -k_C(iv) -k_C(iv);...
       -k_S     -k_S    k_E   -k_S    -k_S  ;...
     -k_C(iv) -k_C(iv) -k_S    k_E      0    ;...
     -k_C(iv) -k_C(iv) -k_S     0      k_E    ];
    eigs_numeric(iv,:)=eigs(L(:,:,iv))';
end
eiv_names={'sym \lambda_E','sym \lambda_+','sym \lambda_-','anti \lambda_E','anti \lambda_E_+_2_C'}; %names of rotated variables
eigs_analytic=[eigs_sym,eigs_anti];
Emtx=zeros(nvar,nvar,2);
for iv=1:2
    h=hr2*(-k_C(iv)+[-1 1]*kSC(iv))/k_S;
    Emtx(1,[1:2],iv)=[-1 1]; %sym eigenvec k_E
    if k_S~=0
        Emtx(2,[1:3],iv)=[1 1 h(1)]; %sym eigenvec lambda-
        Emtx(3,[1:3],iv)=[1 1 h(2)]; %sym eigenvec lambda+
    else
        Emtx(2,[1:3],iv)=[1 1 0];
        Emtx(3,[1:3],iv)=[0 0 1];
    end
    Emtx(4,[4:5],iv)=[1 -1]; %anti eigenvec for k_E
    Emtx(5,[4:5],iv)=[1 1]; %enti eigenvec for k_E+2*k_C
    %
    Emtx(:,:,iv)=Emtx(:,:,iv)./repmat(sqrt(sum(Emtx(:,:,iv).^2,2)),1,nvar);
    Lrot(:,:,iv)=R*L(:,:,iv)*R';
    Ueiv(:,:,iv)=Emtx(:,:,iv)*Urot;
end

decayratefvel=1/2;
    for kk=1:length(a)
        if abs(a(kk))>3
            gain=(3^(decayratefvel))./(abs(a(kk)).^(decayratefvel));
            v(kk)=gain*v(kk);
        end
    end
   
  
a=rad2deg(a); %get the angle in degrees for plotting
if plotting==1 | plotting==-1
    %for if we want to plot angulat velocity and ground speed 
        figure;
        hold on
        plot(pre_odor*deltaT,a(pre_odor),'k');
        plot(during_odor*deltaT,a(during_odor),'r');
        plot(post_odor*deltaT,a(post_odor),'b');
        namestring='angular velocity';
        title(namestring)
        set(gcf,'Position',[94    24   600   300]);
        xlabel('time (sec)')
        set(gca,'XLim',[0 triallength*deltaT]);
        util_label(namestring,tstring);
%
        figure;
        hold on;
        plot(pre_odor*deltaT,v(pre_odor),'k')
        plot(during_odor*deltaT,v(during_odor),'r')
        plot(post_odor*deltaT,v(post_odor),'b')
        namestring='ground speed';
        title(namestring);
        xlabel('time (sec)');
        set(gca,'XLim',[0 triallength*deltaT]);
        util_label(namestring,tstring);
end
if plotting==0 | plotting==1 | plotting==-1
    figure;
    hold on; plot(x(pre_odor),y(pre_odor),'k'); axis equal
    hold on; plot(x(during_odor),y(during_odor),'r');
    hold on; plot(x(post_odor),y(post_odor),'b');
    namestring='position';
    title(namestring);
    set(gcf,'Position',[640   277   560   420]);
    util_label(namestring,tstring);
end
if plotting==-1
    %plot original time series and symmetry-rotated
    figure;
    set(gcf,'NumberTitle','off');
    set(gcf,'Position',[100 100 1400 800]);
    set(gcf,'Name',cat(2,'orig variables ',tstring));
    for k=1:nvar
        subplot(nvar,2,2*k-1);
        hold on;plot(pre_odor*deltaT,U(k,pre_odor),'k');
        hold on;plot(during_odor*deltaT,U(k,during_odor),'r');
        hold on;plot(post_odor*deltaT,U(k,post_odor),'b');
        set(gca,'YLim',[-10 10]);
        ylabel(sprintf('u_%1.0f',k))
        if k==nvar
            xlabel('time (sec)')
        end
        set(gca,'XLim',[0 triallength*deltaT]);
        subplot(size(U,1),2,2*k);
        hold on;plot(pre_odor*deltaT,Urot(k,pre_odor),'k');
        hold on;plot(during_odor*deltaT,Urot(k,during_odor),'r');
        hold on;plot(post_odor*deltaT,Urot(k,post_odor),'b');
        set(gca,'YLim',[-10 10]);
        ylabel(sprintf('%s',rot_names{k}))
        if k==nvar
            xlabel('time (sec)')
        end
        set(gca,'XLim',[0 triallength*deltaT]);
     end
    axes('Position',[0.01,0.05,0.01,0.01]); %for text
    text(0,0,tstring);
    axis off;
    %plot rotated into eigenvectors, for baseline and odor-off params
    figure;
    set(gcf,'NumberTitle','off');
    set(gcf,'Position',[100 100 1400 800]);
    set(gcf,'Name',cat(2,'eigenvariables ',tstring));
    for iv=1:2
        switch iv
            case 1
                pname='baseline params';
            case 2
                pname='odor off params';
        end
        for k=1:nvar
            subplot(nvar,2,iv+(k-1)*2);
            hold on;plot(pre_odor*deltaT,Ueiv(k,pre_odor,iv),'k');
            hold on;plot(during_odor*deltaT,Ueiv(k,during_odor,iv),'r');
            hold on;plot(post_odor*deltaT,Ueiv(k,post_odor,iv),'b');
            set(gca,'YLim',[-15 15]);
            ylabel(eiv_names{k})
            if k==nvar
                xlabel('time (sec)')
            end
            set(gca,'XLim',[0 triallength*deltaT]);
            title(sprintf('eigenvalue: %7.4f',eigs_analytic(iv,k)))
        end
    end %iv
    axes('Position',[0.01,0.05,0.01,0.01]); %for text
    text(0,0,tstring);
    axis off;
end
res.W = W;
res.U = U';
res.Urot=Urot';
res.v = v;
res.a = a;
res.theta = theta;
res.x = x;
res.y = y;
%from body
res.params_sigmoid.a0=a0;
res.params_sigmoid.a1=a1;
res.params_step.deltaT=deltaT;
res.params_M.A=B;
res.params_M.I_S=XS;
res.params_M.I_C=[XLR XLR2];
res.params_M_string=tstring;
%from JV appendix
res.params_L.k_E=k_E;
res.params_L.k_S=k_S;
res.params_L.k_C=k_C;
res.params_L_string=sprintf('k_E=%6.3f k_S=%6.3f k_C=%6.3f %6.3f',k_E,k_S,k_C);
%
res.eigs_sym=eigs_sym;
res.eigs_anti=eigs_anti;
res.eigs_numeric=eigs_numeric;
res.L=L;
res.Lrot=Lrot;
res.Emtx=Emtx;
res.Ueiv=permute(Ueiv,[2 1 3]);
%
res.rot_names=rot_names;
res.eiv_names=eiv_names;


end


function y = act(x,a0,a1) %keeps the system from exploding
%    y = 20./(1+exp(-x/4))-10; %previous
  y=a0*(2./(1+exp(-2*x/a1))-1);
end

function util_label(namestring,tstring)
set(gcf,'NumberTitle','off');
set(gcf,'Name',cat(2,namestring,' ',tstring));
axes('Position',[0.01,0.05,0.01,0.01]); %for text
text(0,0,tstring,'FontSize',7);
axis off;
return
end



