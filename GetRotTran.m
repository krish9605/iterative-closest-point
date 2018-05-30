function [ R,T ] = GetRotTran( I1,I2 )
% Calculates the rotation and translation for 
M1=mean(I1')';
M2=mean(I2')';

I1n=bsxfun(@minus,I1,M1);
I2n=bsxfun(@minus,I2,M2);

H=I2n*I1n';

[U,~,V]=svd(H);
R=V*U';

T=M1-R*M2;

end

