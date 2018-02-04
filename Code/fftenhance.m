function [final]=fftenhance(image,f)
I = 255-double(image);
[w,h] = size(I);
w1=floor(w/32)*32;
h1=floor(h/32)*32;
inner = zeros(w1,h1);
for i1=1:32:w1
   for i2=1:32:h1
      a=i1+31;
      b=i2+31;
      F=fft2( I(i1:a,i2:b) );%PERFORMING FFT TRANSFORM AND IFT OF EACH BLCOK
      factor=abs(F).^f;
      part = abs(ifft2(F.*factor));
      temp=max(part(:));
      if temp==0
         temp=1;%d=DIVISION BY ZERO ERROR REMOVAL
      end;
      part= part./temp;
      inner(i1:a,i2:b) = part; %STORING ALL ENHANCED PARTS IN INNER
   end;
end;
inner;
final=inner*255;
final=histeq(uint8(final)); 

