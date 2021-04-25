%% 函数或者脚本说明
%{  
---------------------------------------------------
*文件名: plot_test
*函数名: 
*功   能: 演示使用YW_Plot1()
*变量说明:

*注意事项:

---------------------------------------------------
%}
%% colors
%{
Dutch Palette
[255, 195, 18]/255
[196, 229, 56]/255
[18, 203, 196]/255
[253, 167, 223]/255
[237, 76, 103]/255
Chinese Palette
[255, 165, 2]/255
[255, 127, 80]/255
[255, 107, 129]/255
[164, 176, 190]/255
[87, 96, 111]/255
%}
%% 数据生成
%%
x1 = 0:0.01:5;y1=cos(x1);
x2=1:0.2:6;y2=sin(x2);
x3=1:0.05:4;y3=x3;
%%
general = {'figure name', 'my figure name';
    'title name','your title';
    'x_label','your x label';
    'y_label','your y label';
    };

data = {'x', 'y','legend','color','LineStyle';
    x1,y1,'datavhg1','b','-';
    x2,y2,'shu2',[0.5,0.5,0],'-.';
    %x3,y3,'lbukl','r',':';
    };
%%
other = {
    'y_label2','your y label2';
    'second y',1;
    'second legend', 1;
    };

another_axis = {'x', 'y','legend','color','LineStyle';
    x1,y1+3,'x','k','-';
    3*x2,y2,'yy',[0.5,0.1,0.2],'-.';
    %x3,y3,'zzz','c',':';
    };
%%
close all;
YW_Plot1(general,data,other,another_axis);
% YW_Plot1(general,data);