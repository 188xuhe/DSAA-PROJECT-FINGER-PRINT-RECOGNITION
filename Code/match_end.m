function [percent_match]=match_end(template1,template2,edgeWidth,noShow)

if or(edgeWidth == 0,isempty(edgeWidth))
   edgeWidth=10;
end;

if or(isempty(template1), isempty(template2))
   percent_match = -1;
else
length1 = size(template1,1);
minu1 = template1(length1,3);
real_end1 = template1(1:minu1,:);
ridgeMap1= template1(minu1+1:length1,:);

length2 = size(template2,1);
minu2 = template2(length2,3);
real_end2 = template2(1:minu2,:);
ridgeMap2= template2(minu2+1:length2,:);

ridgeNum1 = minu1; 
minuNum1 = minu1;
ridgeNum2 = minu2;
minuNum2 = minu2;


max_percent=zeros(1,3);
      
for k1 = 1:minuNum1
      
      newXY1 = MinuOriginTransRidge(real_end1,k1,ridgeMap1);
   for k2 = 1:minuNum2

      newXY2 = MinuOriginTransRidge(real_end2,k2,ridgeMap2);
      
      
      compareL = min(size(newXY1,2),size(newXY2,2));
      eachPairP = newXY1(1,1:compareL).*newXY2(1,1:compareL);
      pairPSquare = eachPairP.*eachPairP;
      temp = sum(pairPSquare);
      
      ridgeSimCoef = 0;
      
      if temp > 0
      ridgeSimCoef = sum(eachPairP)/( temp^.5 );
      end;
      
if ridgeSimCoef > 0.8
         fullXY1=MinuOrigin_TransAll(real_end1,k1);
         fullXY2=MinuOrigin_TransAll(real_end2,k2);
         
         minuN1 = size(fullXY1,2);
         minuN2 = size(fullXY2,2);
         xyrange=edgeWidth;
         num_match = 0;
         
for i=1:minuN1 
   for j=1:minuN2  
      if (abs(fullXY1(1,i)-fullXY2(1,j))<xyrange & abs(fullXY1(2,i)-fullXY2(2,j))<xyrange)
         angle = abs(fullXY1(3,i) - fullXY2(3,j) );
         if or (angle < pi/3, abs(angle-pi)<pi/6)
         num_match=num_match+1;     
         break;
         end;
      end;   
   end;
end;


% get the largest matching score
current_match_percent=num_match;
if current_match_percent > max_percent(1,1);
   max_percent(1,1) = current_match_percent;
   max_percent(1,2) = k1;
   max_percent(1,3) = k2;
end;
num_match = 0;

end;
end;
end;

percent_match = max_percent(1,1)*100/minuNum1;
end;

%if function is called in GUI mode, popup out the message box
%for final result
if nargin == 3
   text=strcat('The max matching percentage is  ',num2str(percent_match),'%');
msgbox(text);
end;
