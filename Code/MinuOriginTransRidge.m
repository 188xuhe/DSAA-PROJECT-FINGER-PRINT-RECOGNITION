function [newXY] = MinuOriginTransRidge(real_end,k,ridgeMap)
      theta = real_end(k,3);
      if theta <0
		theta1=2*pi+theta;
		end;

		theta1=pi/2-theta;

      rotate_mat=[cos(theta1),-sin(theta1);sin(theta1),cos(theta1)];
      
      %locate all the ridge points connecting to the miniutia
      %and transpose it as the form:
      %x1 x2 x3...
      %y1 y2 y3...
      pathPointForK = find(ridgeMap(:,3)== k);
      toBeTransformedPointSet = ridgeMap(min(pathPointForK):max(pathPointForK),1:2)';
      
      %translate the minutia position (x,y) to (0,0)
      %translate all other ridge points according to the basis 
      tonyTrickLength = size(toBeTransformedPointSet,2);
      pathStart = real_end(k,1:2)';
      translatedPointSet = toBeTransformedPointSet - pathStart(:,ones(1,tonyTrickLength));
      
      %rotate the point sets 
      newXY = rotate_mat*translatedPointSet;
      
     
            
      
      
