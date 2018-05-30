function [I1,I2,Ract,Tact] = GenRandomPointCloud( minSpace,maxSpace,nPoints,initRT,noiseIntensity )
I1=minSpace+(maxSpace-minSpace)*rand(3,nPoints);

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

