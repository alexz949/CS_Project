SchurMat = [1,-1,2,0,4,1;2,0,-3,6,-3,0;0,0,3,1,4,1;0,0,0,4,2,8;0,0,0,-5,-1,0;0,0,0,0,0,-1];
disp(SchurMat);

schE = eig(SchurMat);
disp(schE);