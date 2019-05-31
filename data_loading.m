datas = [data(73).IR(1:256,1) data(74).IR(1:256,1) data(75).IR(1:256,1) data(76).IR(1:256,1) data(77).IR(1:256,1) data(78).IR(1:256,1) data(79).IR(1:256,1) data(80).IR(1:256,1) data(81).IR(1:256,1) data(82).IR(1:256,1) data(83).IR(1:256,1) data(84).IR(1:256,1)  data(85).IR(1:256,1) data(86).IR(1:256,1) data(87).IR(1:256,1) data(88).IR(1:256,1) data(89).IR(1:256,1) data(90).IR(1:256,1)  data(91).IR(1:256,1) data(92).IR(1:256,1) data(93).IR(1:256,1) data(94).IR(1:256,1) data(95).IR(1:256,1) data(96).IR(1:256,1)];
datas2 = fix(datas*10^9);
fileID = fopen('data_file.txt','w');
writes = fprintf(fileID,'%d\n', datas2);
fclose(fileID);