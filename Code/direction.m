function [ROIBOUND,ROIAREA] = direction(image,blocksize,noshow)
[w,h] = size(image);
direct = zeros(w,h);
gxmulgy = zeros(w,h);
sq_gxminusgy = zeros(w,h);
sq_gxsumgy = zeros(w,h);
W = blocksize;
theta = 0;
sumval = 1;
bg_certainty = 0;

blockIndex = zeros(ceil(w/W),ceil(h/W));
timesval = 0;
minusval = 0;

center = [];

%gx X-GRADIENT
filter_gradient = fspecial('sobel');
I_horizontal = filter2(filter_gradient,image);

%gy Y-GRADIENT
filter_gradient = transpose(filter_gradient);
I_vertical = filter2(filter_gradient,image);


gxmulgy=I_horizontal.*I_vertical;
sq_gxminusgy=(I_vertical-I_horizontal).*(I_vertical+I_horizontal);
sq_gxsumgy = (I_horizontal.*I_horizontal) + (I_vertical.*I_vertical);


for i1=1:W:w
    for i2=1:W:h
      if i2+W-1 < h & i1+W-1 < w
		    timesval = sum(sum(gxmulgy(i1:i1+W-1, i2:i2+W-1)));
          minusval = sum(sum(sq_gxminusgy(i1:i1+W-1, i2:i2+W-1)));
          sumval = sum(sum(sq_gxsumgy(i1:i1+W-1, i2:i2+W-1)));
          bg_certainty = 0;
          theta = 0;
          if sumval ~= 0 & timesval ~=0
             bg_certainty = (timesval*timesval + minusval*minusval)/(W*W*sumval); 
            if bg_certainty > 0.05 %THRESHOLD
             blockIndex(ceil(i1/W),ceil(i2/W)) = 1;
             tan_value = atan2(2*timesval,minusval);
             theta = (tan_value)/2+pi/2 ;
             center = [center;[round(i1 + (W-1)/2),round(i2 + (W-1)/2),theta]];
        		end;
        end;
    end;
 		timesval = 0;
        minusval = 0;
        sumval = 0;
          
   end;
end;



if nargin == 2 %FUNCTION INPUT ARGUEMENTS
	imagesc(direct);

	hold on;
	[u,v] = pol2cart(center(:,3),8);
   quiver(center(:,2),center(:,1),u,v,0,'g');%PLOTTING AS IMAGE
   hold off;
end;


x = bwlabel(blockIndex,4);
y = bwmorph(x,'close');
ROIAREA = bwmorph(y,'open');
ROIBOUND = bwperim(ROIAREA);


%DSAA GROUP_20
%ANIRUDH KANNAN
%DHARANI AKURATHI
%MONICA SAGAR
%LAISHA WADHWA