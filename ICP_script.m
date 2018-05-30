clc
clear
close all
%% Generate point clouds, I1 - base cloud, I2 - cloud to be transformed
initRT=[26,45,46,5,8,7]; % [Rx,Ry,Rz,Tx,Ty,Tz] Rx,Ry,Rz in degrees
noiseIntensity = 1/30;
%
% nX=100;
% nY=100;
% xLocs=[-3,5];
% yLocs=[-1,8];
% [I1,I2,Ract,Tact] = GenParaboloidPointCloud( nX,nY,xLocs,yLocs,initRT,noiseIntensity);

minSpace=-10;
maxSpace=10;
nPoints=10000;
[I1,I2,Ract,Tact] = GenRandomPointCloud( minSpace,maxSpace,nPoints,initRT,noiseIntensity );

%% Create Initial estimates of R and T
rMaxNoise=10; % In degrees
tMaxNoise=0.7;
[rInit,tInit] = GetNoisyRT( rMaxNoise,tMaxNoise,initRT);

%% ICP algo

EucDist=@(X1,X2)sqrt(sum((X1-X2).^2));
Thresh=2;
valForOptimalityCheck=3;
nChoose=300; % Randomly pick nChoose points
thresholdForPointReject=1;
rEstimate=rInit;
tEstimate=tInit;
for i=1:100
    
    [PointsI1,PointsI2] = IdentifyClosePoints( I1,I2,rEstimate,tEstimate,nChoose,thresholdForPointReject);
    
    [rEstimateNew,tEstimateNew] = GetRotTran( PointsI1,PointsI2); % Get better R and T estimates from the selected points
    if(det(rEstimateNew)==-1)
        disp('error, a better Rotation estimate and Translation estimate is required');
        break;
    end
    
    k=EucDist(I1,bsxfun(@plus,rEstimateNew*I2,tEstimateNew));
    error(i)=sqrt(sum(k.^2))
    if(i>1)
        if(error(i)<error(i-1))
            % update values as the new estimates are good
            rEstimate=rEstimateNew;
            tEstimate=tEstimateNew;
        end
    end
    if(i>5) % minimum five iterations before convergence
        if((error(i)<Thresh)||(abs(error(i-4)-  error(i))<valForOptimalityCheck)) % The second condition is to check if the solution is optimal
            break
        end
    end
end

errorR=sum(sum((Ract-rInit).^2));
errorT=sum(sum((Tact-tInit).^2));
fprintf('ErrorR Initial = %f and ErrorT Initial = %f \n',errorR,errorT)

errorR=sum(sum((Ract-rEstimate).^2));
errorT=sum(sum((Tact-tEstimate).^2));
fprintf('ErrorR Final = %f and ErrorT Final = %f \n',errorR,errorT)

scatter(1:length(error),error)
xlabel('Number of iterations')
ylabel('Euclidean distance between I1 and R*I2 + T')
% print('ExampleErrorGraph','-r400','-dpng')


% References
% 1. Wikipedia, "Iterative closest point", https://en.wikipedia.org/wiki/Iterative_closest_point
% 2. "Iterative Closest Point", Woven Gvili
% 3. "Least-Squares Fitting of Two 3-D Point Sets", ARUN et al,1987
% 4. Dynamic Geometry Processing, "The ICP algorithm and its extensions", Niloy J. Mitra
% 5. Coursera, "ICP", https://www.coursera.org/learn/robotics-learning/home/week/4