function [end_list,branch_list,ridgeOrderMap,edgeWidth] = mark_minutia(in, inBound,inArea,block);
[w,h] = size(in);
[ridgeOrderMap,totalRidgeNum] = bwlabel(in); 
imageBound = inBound;
imageArea = inArea;
blOCKkSize = block;

edgeWidth = interRidgeWidth(in,inArea,blOCKkSize);

end_list    = [];
branch_list = [];


for n1=1:totalRidgeNum
   [m,n1] = find(ridgeOrderMap==n1);
   b = [m,n1];
   ridgeW = size(b,1);
   
   for x1 = 1:ridgeW
      i = b(x1,1);
      j = b(x1,2);
    if inArea(ceil(i/blOCKkSize),ceil(j/blOCKkSize)) == 1          
      neiborNumBER = 0;
      neiborNumBER = sum(sum(in(i-1:i+1,j-1:j+1)));
      neiborNumBER = neiborNumBER -1;
   if neiborNumBER == 1 
		end_list =[end_list; [i,j]];
           
   elseif neiborNumBER == 3
      %MORE THAN 2 NEIGHBOURS
      tmp=in(i-1:i+1,j-1:j+1);
      tmp(2,2)=0;
      [abr,bbr]=find(tmp==1);
      t=[abr,bbr];
      if isempty(branch_list)
         branch_list = [branch_list;[i,j]];
      else   
      for p1=1:3
         cbr=find(branch_list(:,1)==(abr(p1)-2+i) & branch_list(:,2)==(bbr(p1)-2+j) );
         if ~isempty(cbr)
            p1=4;
            break;
         end;
      end;
      if p1==3
         branch_list = [branch_list;[i,j]];
      end;
   	end;
  	end;	
	end;
end;
end;
