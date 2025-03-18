function res = gattuso_locomotion_model(B,XLR,XLR2,XS,XX,SW,plotting)
%this code creates fictive walking trajectories of drosophila olfactory
%navigation. Written for Gattuso et al 2024

%explanation of input variables:
%B=self influencing term
%XLR=contralateral connection during preodor period
%XLR2=contralateral connection during postodor period
%XS=interaction with the stop unit
%XX=ipsilateral connections
%SW=waveform of fictive odor stimulus(ex. SW=zeros(3500,1); SW(1501:2000)=0.6;)
%plotting=flag for output of plots

triallength = 3500;
m=5;
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


n = randn(m,triallength); %noise component for each neuron

U = [0.1; 0.1 ;0 ;0.1; 0.1];
v(1) = 0; %the fly is stopped at the start of each trial
a(1) = 0;

x(1) = 0;
y(1) = 0;
theta(1) = 2*pi*rand(1); %starts the fly at a random heading

for i=2:triallength
    
    if i<=2000 %odor offset occurs at 2000 samples and the model switches contralateral terms
        U(:,i) = act(W*U(:,i-1) + S(: ,i-1)*sin(theta(i-1)-pi/2) + SS(:,i) + 1*n(:,i)+tonic);
        
    else
        
        U(:,i) = act(W2*U(:,i-1) + S(:,i-1)*sin(theta(i-1)-pi/2) + SS(:,i) + 1*n(:,i)+tonic);
    end
    
    if U(3,i)>0 %forces a stop if the stop node is positive
        v(i) = 0;
    else    %otherwise the forward velocity is a linear combination of the nodes
        v(i) = (1.6*max(0,sum(U([1 5],i)))) + 0.5*max(0,sum(U([2 4],i)));   %unit/sec
    end

    if U(3,i)>0     %again forces the angular velocity to be zero if the stop node is engaged
        a(i) = 0;
    else %makes the angular velocity the difference across the sides
        a(i) = 0.2*diff(U([1 5],i))+0.35*diff(U([2 4],i));

    end
  
    theta(i) = theta(i-1)+a(i)/50; %updating angular velocity- velcity is in rad/s and sampling rate is 50hz
    [dx, dy] = pol2cart(theta(i),v(i)/50); %converting to x and y coordinates and make unit/sample
    x(i) = x(i-1)+dx;
    y(i) = y(i-1)+dy;
    
end

  
a=rad2deg(a); %get the angle in degrees for plotting
if plotting==1 %for if we want to plot angular velocity and ground speed 
    %angular velocity
    figure
    hold on
    plot(1:1500, a(1:1500),'k')
    hold on
    plot(1500:2000, a(1500:2000),'r')
    plot(2000:3500, a(2000:3500),'b')
    title('angular velocity')
    set(gcf,'Position',[94    24   600   300]);

    %ground speed
    figure
    plot(1:1500,v(1:1500),'k')
    hold on
    plot(1500:2000,v(1500:2000),'r')
    plot(2000:3500,v(2000:3500),'b')
    title('ground speed')

    %plotting the trajectory in x,y coordinates
    figure
    hold on; 
    plot(x(1:1500),y(1:1500),'k'); axis equal
    hold on; plot(x(1500:2000),y(1500:2000),'r');
    hold on; plot(x(2000:3500),y(2000:3500),'b');
    set(gcf,'Position',[640   277   560   420]);
end

%model outputs 
res.W = W;
res.U = U';
res.v = v;
res.a = a;
res.theta = theta;
res.x = x;
res.y = y;
end


function y = act(x) %keeps the system from exploding
    y = 20./(1+exp(-x/4))-10;
end



