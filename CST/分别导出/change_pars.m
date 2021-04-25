%% 函数或者脚本说明
%{  
---------------------------------------------------
*文件名: change_pars
*函数名: None
*功   能:在CST扫参后，指定需要处理数据的文件夹路径
    依次从CST导出的逐个txt文档中读取文件的前两列，并在第三列
    添加上当前参数的当前值。并可生成每个变量值对应的变量。最后
    这些参数变化绘制出来.
*变量说明:
*注意事项:
	1 要求txt的格式是cst直接导出的三列文件，没有修改，程序会去掉前三行
    2 在CST的结果teemplete results中定义计算吸收或其它变量的值，这样不用再进行数据处理
    3 建议把导出的数据按*变量*单独存放于一个文件夹
    4 文件名最后按照数据的格式，2 4 8，这样循环变量容易取
---------------------------------------------------
%}

clear;
load('color_QX');

%% diretory: 路径; var 参数名，命名时用
% var = 'w1';circle_range=50:2:70;diretory = "F:\Documents\CST\frontier in physics\里程\w1\导出文本\";
% var = 'w2';circle_range=20:3:50;diretory = "F:\Documents\CST\frontier in physics\里程\w2\导出文本\";
% var = 'houdu';circle_range=6:2:20;diretory = "F:\Documents\CST\frontier in physics\里程\houdu\导出文本\";
% var = 't';circle_range=3:.5:10;diretory = "F:\Documents\CST\frontier in physics\里程\t\导出文本\";
var = 'n';circle_range=1:0.1:2;
diretory = "F:\Documents\CST\frontier in physics\里程\n12old\导出文本\";
% var = 'nh';circle_range=5:12;diretory = "F:\Documents\CST\frontier in physics\里程\nh\导出文本\";
% var = 'thickness';circle_range=5:10;diretory = "F:\Documents\CST\frontier in physics\用来测试折射率的平面或凸起模型\凸起结构 用于测试 折射率\thickness\";
% var = 'thickness';circle_range=5:10;diretory = "F:\Documents\CST\frontier in physics\用来测试折射率的平面或凸起模型\平面结构 用于测试 折射率\thickness\";
%%
% savetotal = [];
% savefile = [var,'_sweep','.xlsx']; % 保存文件名
%% 循环条件也要更改
for each =  circle_range% txt的命名要按这个来
    myfilename = diretory+[num2str(each),'.txt'];%文件名
    tmp=readsweep(myfilename,each);
%     savetotal=[savetotal;tmp];
%{1
    %如果要显示每个变量名就打开这段程序
    if each>floor(each) %如果文件中有小数，把小数中的.换成_
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

switch var
    case 'w2'
%% w2绘图
%{1
general = {'figure name', ['改变参数',var];
    'title name',' ';
    'x_label','Frequency (THz)';
    'y_label','Absorption';
    };
close all;
data = {'x', 'y','legend','color','LineStyle';
    w2_20(:,1),w2_20(:,2),'$w_2=20$',QX(1,:),'-.';
    w2_23(:,1),w2_23(:,2),'$w_2=23$',QX(2,:),'-.';
    w2_26(:,1),w2_26(:,2),'$w_2=26$',QX(3,:),'-.';
    w2_29(:,1),w2_29(:,2),'$w_2=29$',QX(4,:),'-.';
    w2_32(:,1),w2_32(:,2),'$w_2=32$',QX(5,:),'-.';
    w2_35(:,1),w2_35(:,2),'$w_2=35$',QX(6,:),'-';
    w2_38(:,1),w2_38(:,2),'$w_2=38$',QX(7,:),'--';
    w2_41(:,1),w2_41(:,2),'$w_2=41$',QX(8,:),'--';
    w2_44(:,1),w2_44(:,2),'$w_2=44$',QX(9,:),'--';
    w2_47(:,1),w2_47(:,2),'$w_2=47$',QX(10,:),'--';
%     w2_50(:,1),w2_50(:,2),'$w_2=50$',QX(11,:),'--';
    };
hand = YW_Plot1(general,data);
set(gca(hand),'XLim',[.75 1.9]);
% set(gca(hand),'XTick',[.75 1.9])
%}

    case 'w1'
%% w1绘图
%{1
general = {'figure name', ['改变参数',var];
    'title name',' ';
    'x_label','Frequency (THz)';
    'y_label','Absorption';
    };
close all;
data = {'x', 'y','legend','color','LineStyle';
    w1_50(:,1),w1_50(:,2),'$w_1=50$',QX(1,:),'-.';
    w1_52(:,1),w1_52(:,2),'$w_1=52$',QX(2,:),'-.';
    w1_54(:,1),w1_54(:,2),'$w_1=54$',QX(3,:),'-.';
    w1_56(:,1),w1_56(:,2),'$w_1=56$',QX(4,:),'-.';
    w1_58(:,1),w1_58(:,2),'$w_1=58$',QX(5,:),'-.';
    w1_60(:,1),w1_60(:,2),'$w_1=60$',QX(6,:),'-';
    w1_62(:,1),w1_62(:,2),'$w_1=62$',QX(7,:),'--';
    w1_64(:,1),w1_64(:,2),'$w_1=64$',QX(8,:),'--';
    w1_66(:,1),w1_66(:,2),'$w_1=66$',QX(9,:),'--';
    w1_68(:,1),w1_68(:,2),'$w_1=68$',QX(10,:),'--';
    w1_70(:,1),w1_70(:,2),'$w_1=70$',QX(11,:),'--';
    }; 
hand = YW_Plot1(general,data);
set(gca(hand),'XLim',[.75 1.9]);
% set(gca(hand),'XTick',[.75 1.9])
%}

    case 'houdu'
%% houdu绘图
%{1
general = {'figure name', ['改变参数',var];
    'title name',' ';
    'x_label','Frequency (THz)';
    'y_label','Absorption';
    };
close all;
data = {'x', 'y','legend','color','LineStyle';
% 	houdu_6(:,1),houdu_6(:,2),	'$h=6$',QX(1,:),'-.';
% 	houdu_8(:,1),houdu_8(:,2),	'$h=8$',QX(2,:),'-.';
    houdu_10(:,1),houdu_10(:,2),'$h=10$',QX(3,:),'-.';
    houdu_12(:,1),houdu_12(:,2),'$h=12$',QX(4,:),'-.';
    houdu_14(:,1),houdu_14(:,2),'$h=14$',QX(5,:),'-';
    houdu_16(:,1),houdu_16(:,2),'$h=16$',QX(6,:),'--';
    houdu_18(:,1),houdu_18(:,2),'$h=18$',QX(7,:),'--';
    houdu_20(:,1),houdu_20(:,2),'$h=20$',QX(8,:),'--';
    }; 
hand = YW_Plot1(general,data);
set(gca(hand),'XLim',[.75 1.9]);
% set(gca(hand),'XTick',[.75 1.9])
%}

    case 't'
%% t绘图
%{1
general = {'figure name', ['改变参数',var];
    'title name',' ';
    'x_label','Frequency (THz)';
    'y_label','Absorption';
    };
close all;
data = {'x', 'y','legend','color','LineStyle';
    t_3(:,1),t_3(:,2),'$t=3$',QX(1,:),'-.';
%     t_3_5(:,1),t_3(:,2),'$t=3.5$',QX(7,:),'-.';
    t_4(:,1),t_4(:,2),'$t=4$',QX(2,:),'-';
    t_5(:,1),t_5(:,2),'$t=5$',QX(3,:),'--';
    t_6(:,1),t_6(:,2),'$t=6$',QX(4,:),'--';
    t_7(:,1),t_7(:,2),'$t=7$',QX(5,:),'--';
    t_8(:,1),t_8(:,2),'$t=8$',QX(6,:),'--';
%     t_9(:,1),t_9(:,2),'$t=9$',QX(7,:),'--';
%     t_10(:,1),t_10(:,2),'$t=10$',QX(8,:),'--';
    };
hand = YW_Plot1(general,data);
set(gca(hand),'XLim',[.75 1.9]);
% set(gca(hand),'XTick',[.75 1.9])
%}


    case 'n'
%% 两种结果的折射率都用的同段程序，注意区分
%{1
general = {'figure name', ['改变参数“',var,'”,注意区分用的哪种模型'];
    'title name',' ';
    'x_label','Frequency (THz)';
    'y_label','Absorption';
    };
close all;
data = {'x', 'y','legend','color','LineStyle';
    n_1(:,1),n_1(:,2),'$n=1.0$',QX(1,:),'-';
    %     n_1_1(:,1),n_1_1(:,2),'$n=1.1$',QX(2,:),'-.';
    n_1_2(:,1),n_1_2(:,2),'$n=1.2$',QX(3,:),'-.';
    %     n_1_3(:,1),n_1_3(:,2),'$n=1.3$',QX(4,:),'-.';
    n_1_4(:,1),n_1_4(:,2),'$n=1.4$',QX(5,:),'-.';
    %     n_1_5(:,1),n_1_5(:,2),'$n=1.5$',QX(6,:),'-';
    n_1_6(:,1),n_1_6(:,2),'$n=1.6$',QX(7,:),'-.';
    %     n_1_7(:,1),n_1_7(:,2),'$n=1.7$',QX(8,:),'--';
    n_1_8(:,1),n_1_8(:,2),'$n=1.8$',QX(9,:),'-.';
    %     n_1_9(:,1),n_1_9(:,2),'$n=1.9$',QX(10,:),'--';
    n_2(:,1),n_2(:,2),'$n=2.0$',QX(10,:),'-.';
    };
hand = YW_Plot1(general,data);
set(gca(hand),'XLim',[.75 1.9]);
% set(gca(hand),'XTick',[.75 1.9])
%}

    case 'nh'
%% nh绘图
%{1
general = {'figure name', ['改变参数',var];
    'title name',' ';
    'x_label','Frequency (THz)';
    'y_label','Absorption';
    };
close all;
data = {'x', 'y','legend','color','LineStyle';
    nh_5(:,1),nh_5(:,2),'t=5',QX(1,:),'-';
    nh_6(:,1),nh_6(:,2),'t=6',QX(7,:),'--';
    nh_7(:,1),nh_7(:,2),'t=7',QX(2,:),'--';
    nh_8(:,1),nh_8(:,2),'t=8',QX(3,:),'--';
    nh_9(:,1),nh_9(:,2),'t=9',QX(4,:),'--';
    nh_10(:,1),nh_10(:,2),'t=10',QX(5,:),'--';
    nh_11(:,1),nh_11(:,2),'t=11',QX(6,:),'--';
    nh_12(:,1),nh_12(:,2),'t=12',QX(7,:),'--';
    };
hand = YW_Plot1(general,data);
set(gca(hand),'XLim',[.75 1.9]);
% set(gca(hand),'XTick',[.75 1.9])
%}

    case 'thickness'
%% thickness绘图
%{1
general = {'figure name', ['改变参数',var];
    'title name',' ';
    'x_label','Frequency (THz)';
    'y_label','Absorption';
    };
close all;
data = {'x', 'y','legend','color','LineStyle';
    thickness_5(:,1),	thickness_5(:,2),	'$t_A$=5',QX(1,:),'-';
    thickness_6(:,1),	thickness_6(:,2),	'$t_A$=6',QX(7,:),'-.';
    thickness_7(:,1),	thickness_7(:,2),	'$t_A$=7',QX(2,:),'-.';
    thickness_8(:,1),	thickness_8(:,2),	'$t_A$=8',QX(3,:),'-.';
    thickness_9(:,1),	thickness_9(:,2),	'$t_A$=9',QX(4,:),'-.';
    thickness_10(:,1),	thickness_10(:,2),	'$t_A$=10',QX(5,:),'-.';
    };
hand = YW_Plot1(general,data);
set(gca(hand),'XLim',[.75 1.9]);
hand2 = YW_Plot1(general,data);
set(gca(hand2),'XLim',[1.1 1.15]);
% set(gca(hand2),'XLim',[1.44 1.5]);
% set(gca(hand),'XTick',[.75 1.9])
set(gca(hand2),'YLim',[.8 1]);
legend off;
xlabel('');
ylabel('');
%}
end
clear QX;
%% n12绘图
%{
general = {'figure name', ['改变参数',var];
    'title name',' ';
    'x_label','Frequency (THz)';
    'y_label','Absorption';
    };
close all;
data = {'x', 'y','legend','color','LineStyle';
    n_1(:,1),n_1(:,2),'n=1.0',QX(1,:),'-';
%     n_1_1(:,1),n_1_1(:,2),'n=1.1',QX(2,:),'-.';
    n_1_2(:,1),n_1_2(:,2),'n=1.2',QX(3,:),'--';
%     n_1_3(:,1),n_1_3(:,2),'n=1.3',QX(4,:),'-.';
    n_1_4(:,1),n_1_4(:,2),'n=1.4',QX(5,:),'--';
%     n_1_5(:,1),n_1_5(:,2),'n=1.5',QX(6,:),'-';
    n_1_6(:,1),n_1_6(:,2),'n=1.6',QX(7,:),'--';
%     n_1_7(:,1),n_1_7(:,2),'n=1.7',QX(8,:),'--';
    n_1_8(:,1),n_1_8(:,2),'n=1.8',QX(9,:),'--';
%     n_1_9(:,1),n_1_9(:,2),'n=1.9',QX(10,:),'--';
    n_2(:,1),n_2(:,2),'n=2.0',QX(10,:),'--';
    };   
hand = YW_Plot1(general,data);
set(gca(hand),'XLim',[.75 1.9]);
% set(gca(hand),'XTick',[.75 1.9])
%}
%% 空坐标轴绘图
%{
% 'y_label','Polarization Angle  \phi({\circ})';
general = {'figure name', ['坐标轴'];
    'title name',' ';
    'x_label','Frequency (THz)';
    'y_label','Incident Angle  \theta({\circ})';
    };
close all;
data = {'x', 'y','legend','color','LineStyle';
    0,0,'0',[1 1 1],'-';
    };

hand0 = YW_Plot1(general,data);
legend('off');
set(gca(hand0),'Box','off');
set(gca(hand0),'XLim',[.75 1.9]);
set(gca(hand0),'YLim',[0 90]);
set(gca(hand0),'YTick',[0:10:90]);
% set(gca(hand),'XTick',[.75 1.9])
%}






