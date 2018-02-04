function edgeDistance = interRidgeWidth(image,inROI,blocksize)

[w1,h1] = size(image);

a11=sum(inROI);

b11=find(a11>0);

c11=min(b11);
d11=max(b11);
i11=round(w1/5);
m11=0;

for k11=1:4
   m11=m11+sum(image(k11*i11,16*c11:16*d11));
end;
e=(64*(d11-c11))/m11;

a11=sum(inROI,2);
b11=find(a11>0);

c11=min(b11);
d11=max(b11);

i11=round(h1/5);
m11=0;

for k11=1:4
   m11=m11+sum(image(16*c11:16*d11,k11*i11));
end;
m11=(64*(d11-c11))/m11;

edgeDistance=round((m11+e)/2);

   




