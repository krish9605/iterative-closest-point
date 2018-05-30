function [ R ] = GenRotate( xrot,yrot,zrot )

xrot=deg2rad(xrot);
yrot=deg2rad(yrot);
zrot=deg2rad(zrot);

sx=sin(xrot);
cx=cos(xrot);
sy=sin(yrot);
cy=cos(yrot);
sz=sin(zrot);
cz=cos(zrot);

Rx=[1,0,0;
    0,cx,-sx;
    0,sx,cx];

Ry=[cy,0,sy;
    0,1,0;
    -sy,0,cy];

Rz=[cz,-sz,0;
    sz,cz,0;
    0,0,1];

R=Rz*Ry*Rx;

end

