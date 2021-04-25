%% 函数或者脚本说明
%{  
---------------------------------------------------
*文件名: data_main
*函数名: 
*功   能:在CST扫参后，指定需要处理数据的文件夹路径
    依次从CST导出的逐个txt文档中读取文件的前两列，并在第三列
    添加上当前参数的当前值。并可生成每个变量值对应的变量。最
    后将数据生成一个txt文档，利用COMSOL绘制COLORMAP.

*变量说明:
*注意事项:
    1 要求txt的格式是cst直接导出的三列文件，没有修改，程序会去掉前三行
    2 在CST的结果teemplete results中定义计算吸收或其它变量的值，这样不用再进行数据处理
    3 建议把导出的数据按变量单独存放于一个文件夹
    4 文件名最后按照数据的格式，2 4 8，这样循环变量容易取
---------------------------------------------------
%}
%%
% function [] = data_main(nn)
clear;
close all;
%% 文件说明
%{
% 函数(文件)功能：
% 注意事项：
  
%}

%% diretory: 路径; var 参数名，命名时用
% var = 'w1';circle_range = 50:2:70;diretory = "F:\Documents\CST\frontier in physics\里程\w1\导出文本\";
% var = 'w2';circle_range = 20:3:50;diretory = "F:\Documents\CST\frontier in physics\里程\w2\导出文本\";
% var = 'TM_theta';circle_range = 0:2:88;diretory = "F:\Documents\CST\frontier in physics\里程\TM theta\";
var = 'TE_theta';circle_range = 0:1:89;diretory = "F:\Documents\CST\frontier in physics\里程\TE theta\";
% var = 'phi'; circle_range = 0:2:88; diretory = "F:\Documents\CST\frontier in physics\里程\phi\导出文本\";
% var = 'TE_theta';circle_range = 0:8:88;diretory = "F:\Documents\CST\frontier in physics\最终版本\四角中心框模型终版\INWARD\TE THETA\";
% var = 'TM_theta';circle_range = 0:8:88;diretory = "F:\Documents\CST\frontier in physics\最终版本\四角中心框模型终版\INWARD\TM THETA\";
var = 'TM_theta';circle_range = 0:3:87;
diretory = "F:\Documents\CST\frontier in physics\review 补充\最终版本的对照组 平面版本\tm\";

%%
savetotal = [];
OutTableTitle = {'% Frequency(THz)','Absorption(%)',var};
freq_range = [1, .75, 1.9]; % 指定频率范围，1表示开，0表示不启用这个功能
%% 循环条件也要更改
for each = circle_range % txt的命名要按这个来
    myfilename = diretory+num2str(each);%文件名
    tmp=readsweep(myfilename,each);
    savetotal=[savetotal;tmp];
    %{
    %如果要显示每个变量名就打开这段程序
    if each>floor(each)
        % 如果文件中有小数，把小数中的.换成_
        % 只包含了文件名中有一个小数的情况，其它情况类似更改
        % 将小数中的. 替换成了_
        xiaoshu = (each - floor(each)+0.001)*10;
        % 这里+.01是因为floor有bug，有时floor(2)=1
        makename=[var,'_',...
            num2str(floor(each)),...
            '_',num2str(floor(xiaoshu))];% 先定义这样一个变量名
    else
        makename=[var,'_',num2str(each)];% 先定义这样一个变量名
    end
    eval([makename,'=','tmp',';']);
    %}
    clear tmp;
end
if freq_range(1) == 1
    savetotal(savetotal(:,1)<freq_range(2),:) = [];
    savetotal(savetotal(:,1)>freq_range(3),:) = [];
end
savefile = [var,'_parameters_sweep']; % 保存文件名,不加这个'.xlsx'默认为txt，txt好像才有分隔符
Table = array2table(savetotal,'VariableNames',OutTableTitle);
writetable(Table,savefile,'Delimiter','\t');disp(["Write Done"]);
% end

