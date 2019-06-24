root = fliplr(erase(fliplr(mfilename('fullpath')),fliplr(mfilename())));
%%
cd(root);
HRTF = load('marl_nyu\HRIRrepository\S001_marl-nyu.mat');
data = HRTF.data;
datas = [data(73).IR(1:256,1) data(74).IR(1:256,1) data(75).IR(1:256,1) data(76).IR(1:256,1) data(77).IR(1:256,1) data(78).IR(1:256,1) data(79).IR(1:256,1) data(80).IR(1:256,1) data(81).IR(1:256,1) data(82).IR(1:256,1) data(83).IR(1:256,1) data(84).IR(1:256,1)  data(85).IR(1:256,1) data(86).IR(1:256,1) data(87).IR(1:256,1) data(88).IR(1:256,1) data(89).IR(1:256,1) data(90).IR(1:256,1)  data(91).IR(1:256,1) data(92).IR(1:256,1) data(93).IR(1:256,1) data(94).IR(1:256,1) data(95).IR(1:256,1) data(96).IR(1:256,1)];
datas2 = fix(datas*10^9);
fileID = fopen('data_file.txt','w');
dataSize = size(datas2);
%mem_filters(0)(0) <= to_signed(-13688343,32);
fprintf(fileID,'library IEEE;\r\n')
fprintf(fileID,'use IEEE.std_logic_1164.all;\r\n');
fprintf(fileID,'use IEEE.numeric_std.all;\r\n');
fprintf(fileID,'library work;\r\n');
fprintf(fileID,'use work.FilterTypes.all;\r\n');
fprintf(fileID,'\r\n');
fprintf(fileID,'entity FilterMemory is\r\n');
fprintf(fileID,'  port(mem_filters : out fir_filter_array(23 downto 0));\r\n');
fprintf(fileID,'end entity;\r\n');
fprintf(fileID,'\r\n');
fprintf(fileID,'architecture memory of FilterMemory is\r\n');
fprintf(fileID,'begin \r\n');
for j = 1:dataSize(2) 
    
    fprintf(fileID,'  --filter %d\r\n', j-1);
    for i = 1:dataSize(1) 
        fprintf(fileID,'  mem_filters(%d)(%d) <= ', j-1,i-1);
        fprintf(fileID,'to_signed(%d,32);', datas2(i,j));
        if rem(i,2) == 0
            fprintf(fileID,'\r\n');
        end
    end
    fprintf(fileID,'\r\n');
end
fprintf(fileID,'end memory;');
fclose(fileID);