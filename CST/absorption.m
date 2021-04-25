%% 函数或者脚本说明
%{  
---------------------------------------------------
*文件名: absorption
*函数名: None
*功   能:绘制两组吸收和反射曲线，用的两个y坐标
*变量说明:
*注意事项:
---------------------------------------------------
%}

%% 
clear;close all;
load('color_QX');
diretory = "F:\Documents\CST\frontier in physics\里程\简单数据";
vars = {'a','a1','r','r1'};st =0; 
%%
savetotal = [];
%% 循环条件也要更改
for eachturn = 1:4
    var = vars{eachturn};
    myfilename = diretory+['\',num2str(var)];%文件名
    tmp=readforinter(myfilename,eachturn);
    savetotal=[savetotal;tmp];
%{1
    %如果要显示每个变量名就打开这段程序
    makename=[var];% 先定义这样一个变量名
    eval([makename,'=','tmp',';']); 
%}
    clear tmp;
end

%% 绘图
%{1
general = {'figure name', ['吸收和反射'];
    'title name',' ';
    'x_label','Frequency (THz)';
    'y_label','Absorption';
    };
data = {'x', 'y','legend','color','LineStyle';
    a(:,1),a(:,2),'Proposed',[0.00,0.45,0.74],'-';
    a1(:,1),a1(:,2),'Planar',[0.00,0.45,0.74],'--';
    };
other = {
    'y_label2','Reflection';
    'second y',1;
    'second legend', 0;
    };
another_axis = {'x', 'y','legend','color','LineStyle';
    r(:,1),r(:,2),'Proposed',[1.00,0.07,0.65],'-';
    r1(:,1),r1(:,2),'Planar',[1.00,0.07,0.65],'--';
    };
hand = YW_Plot1(general,data,other,another_axis);
set(gca(hand),'XLim',[.75 1.9]);
% set(gca(hand),'XTick',[.75 1.9])
%}
yaxis1_color = [0.00,0.45,0.74];
yaxis2_color =[1.00,0.07,0.65];