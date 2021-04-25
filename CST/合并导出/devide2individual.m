%% 函数或者脚本说明
%{  
---------------------------------------------------
*文件名: devide2individual
*函数名: None
*功   能:将CST合并导出的txt分成若干个txt，
              每个txt的包含一个变量对应的值
*变量说明:
--name_pool 设置变量范围
--txtin:设置源文件
*注意事项:
    目的文件夹要首先建立，否则报错
    分割好后，再用change_pars或data_main脚本处理
    可以选择是否保留前三行标题
---------------------------------------------------
%}

%% 文件说明
%{
% 函数(文件)功能：
% 注意事项：
    1 可以选择是否保留前三行标题
    2 完成此步后再用change_pars或data_main脚本处理
    3 建议把导出的数据按变量单独存放于一个文件夹
%}
fclose all;clear;clc;
%% 数据预备
txtin=fopen('222.txt','r');%源文件
tmp_txtout=fopen('mid_temp.txt','w');%新文件，用于写入不含空行的数据
save_title_flag = 1;
new_parg_flag = 0;
count_flag = 0;
name_pool = 2:4:120; %设置变量范围
name_flag = 1; % 分割的文件计数
directory = '.\independent_txt\'; %同级文件夹
%% 开始读取
while ~feof(txtin) %判断是否为文件末尾
    tline=fgetl(txtin);%读取一行
    %% # 行处理
    if tline(1)=='#' %是否为#开头
        count_flag = count_flag+1;
        fprintf(tmp_txtout,'%s\n',tline); % 写入文档
        if count_flag ==3
            count_flag = 0;
            new_parg_flag = 1;
            tmp=strcat(directory,num2str(name_pool(name_flag)),'.txt');%保存文件时连续命名
            txtout=fopen(tmp,'w');%新文件，用于写入不含空行的数据
            name_flag = name_flag+1;
        end
     %% 数据行处理
    else     
        if new_parg_flag
             new_parg_flag = 0;
            if save_title_flag
                fclose(tmp_txtout);
                tmp_txtout=fopen('mid_temp.txt','r');
                while ~feof(tmp_txtout)
                    tmp_tline = fgetl(tmp_txtout);
                    fprintf(txtout,'%s\n',tmp_tline);
                end
                fclose(tmp_txtout);
                tmp_txtout=fopen('mid_temp.txt','w');
            end
        end
        fprintf(txtout,'%s\n',tline);
    end
end
fclose all;
delete('mid_temp.txt')
disp("Congratulations! 文件分割成功!");

