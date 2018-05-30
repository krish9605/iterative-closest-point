function [PointsI1,PointsI2]= IdentifyClosePoints( I1,I2old,rEstimate,tEstimate,nChoose,thresholdForPointReject )

I2inI1 = bsxfun(@plus,rEstimate*I2old,tEstimate);

nPoints=length(I2inI1);

pointsChosen=randperm(nPoints,nChoose); % Pick random points
selectedPointsI2=I2inI1(:,pointsChosen);           % Random points Selected to represent I2 space

PointsinI1=zeros(nChoose,1);    
PointsinI2=zeros(nChoose,1);

k=1;


for i=1:nChoose
    [closestPointInI1,dist] = MinEucDis(selectedPointsI2(:,i),I1);
    if(dist<thresholdForPointReject)
        PointsinI1(k)=closestPointInI1;
        PointsinI2(k)=pointsChosen(i);
        k=k+1;
    end
end


PointsinI1(k:end)=[];
PointsinI2(k:end)=[];

PointsI1=I1(:,PointsinI1);
PointsI2=I2old(:,PointsinI2);

end

