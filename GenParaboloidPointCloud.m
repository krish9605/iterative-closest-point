function [I1,I2,Ract,Tact] = GenParaboloidPointCloud( nX,nY,xLocs,yLocs,initRT,noiseIntensity )
% I1 - Original point cloud
% I2 - Transformed point cloud

x=linspace(xLocs(1),xLocs(2),nX);
y=linspace(yLocs(1),yLocs(2),nY);

[X,Y]=meshgrid(x,y);

Z=X.^2+Y.^2; % Paraboloid point cloud
% plot3(X,Y,Z,'r*');

I1=[X(:),Y(:),Z(:)]';

% R and T to generate I2 cloud
xrot=initRT(1);
yrot=initRT(2);
zrot=initRT(3);
Tx=initRT(4);
Ty=initRT(5);
Tz=initRT(6);

R = GenRotate(xrot,yrot,zrot);
T = [Tx;Ty;Tz];

% Generate I2 cloud
I2= bsxfun(@plus,R*I1,T);
% add Gaussian Noise
I2=I2+randn(size(I2))*noiseIntensity;


Ract=R';
Tact=-R'*T;

end

