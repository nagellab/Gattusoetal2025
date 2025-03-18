function [angvel,flynumb] = avel_nofilt(res)
%obtains unfiltered angular velocity and then removed trials where fly did
%not move
alltheta=[];
flynumb=[];
for ii = 1:length(res)
    
    ix=[];
    
    theta = res(ii).theta;
    x= res(ii).x;
    y= res(ii).y;
    thisflynumb=ii*ones(1,size(theta,2));
    
% Filters coordinates X and Y
    [b, a] = butter(2,2.5/25); % Designs a band-pass filter (this is the same filter used in the extraction code)
    xfilt = filtfilt(b,a,x); % Filters
    yfilt = filtfilt(b,a,y);
    del = hypot(diff(yfilt,1,1),diff(xfilt,1,1));
    for kk=1:size(del,2)
    if nansum(del(:,kk)) < 25 % excludes if total distance moved is below 25 mm
        ix = [ix, kk];
    end
    end    
    theta(:,ix)=[];
    thisflynumb(:,ix)=[];
    alltheta=[alltheta theta];
    flynumb=[flynumb thisflynumb];
end
%unwrap
alltheta=deg2rad(alltheta); %needs to be converted to radians to unwrap. Then convert back.
alltheta=unwrap(alltheta,2);
alltheta =rad2deg(alltheta);
angvel=diff(alltheta);
size(angvel)
