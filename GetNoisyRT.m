function [ rEstimate,tEstimate ] = GetNoisyRT( rMaxNoise,tMaxNoise,initRT)
% rMaxNoise in degrees
% Creates rEstimate,tEstimate having a small noise compared to the original
% ones
xrot=initRT(1);
yrot=initRT(2);
zrot=initRT(3);
Tx=initRT(4);
Ty=initRT(5);
Tz=initRT(6);

xrotnoise=randi(rMaxNoise);
yrotnoise=randi(rMaxNoise);
zrotnoise=randi(rMaxNoise);
Txnoise=tMaxNoise*randn();
Tynoise=tMaxNoise*randn();
Tznoise=tMaxNoise*randn();

xrotNew=xrot+xrotnoise;
yrotNew=yrot+yrotnoise;
zrotNew=zrot+zrotnoise;

RoNoisy = GenRotate(xrotNew,yrotNew,zrotNew );
TrNoisy = [Tx;Ty;Tz] + [Txnoise;Tynoise;Tznoise];

rEstimate=RoNoisy';
tEstimate=-RoNoisy' * TrNoisy;
end

