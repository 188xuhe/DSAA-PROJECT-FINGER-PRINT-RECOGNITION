function [newXY] = MinuOrigin_TransAll(real_end,k)

theta = real_end(k,3);

if theta <0
	theta1=2*pi+theta;
end;

theta1=pi/2-theta;


rotate_mat=[cos(theta1),-sin(theta1),0;sin(theta1),cos(theta1),0;0,0,1];

      toBeTransformedPointSet = real_end';
      
      tonyTrickLength = size(toBeTransformedPointSet,2);
      
      pathStart = real_end(k,:)';
      
      translatedPointSet = toBeTransformedPointSet - pathStart(:,ones(1,tonyTrickLength));
      
      newXY = rotate_mat*translatedPointSet;
      
      %ensure the direction is in the domain[-pi,pi]
      
      for i=1:tonyTrickLength
         if or(newXY(3,i)>pi,newXY(3,i)<-pi)
            newXY(3,i) = 2*pi - sign(newXY(3,i))*newXY(3,i);
         end;
      end;
      
		