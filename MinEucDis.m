function [locInX,distOld] = MinEucDis( a,X )

EucDist=@(X1,X2)sqrt(sum((X1-X2).^2));
distOld=10^10;

for i=1:length(X)
    
    distNew=EucDist(a,X(:,i));
    
    if(distNew<distOld)
        distOld=distNew;
        locInX=i;
    end
    
end
end

