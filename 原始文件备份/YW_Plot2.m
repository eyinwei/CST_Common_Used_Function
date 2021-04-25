%% 函数或者脚本说明
%{  
---------------------------------------------------
*文件名: YW_Plot2 第二版
*函数名: YW_Plot2(x,x,x,x)
*功   能:绘制两组吸收和反射曲线，用的两个y坐标
*变量说明:
*注意事项:
        % 所有matlab的图，一律复制为矢量图，另外保存好原fig文件。
        % 图采用4:3长宽比例（eg. 560比420）；图中曲线颜色为蓝色，
        % 线宽为2号加粗；数据拟合曲线采用不连续红色线加粗；数据
        % 点用圆圈marker表示；横纵坐标和横纵坐标轴为14号Helvetica
        % 字体加粗，tick可以自己定义。
---------------------------------------------------
%}
%% 
function [outputArg1] = YW_Plot2(general,data,other,another_axis)
%% YW_Plot1 此处显示有关此函数的摘要
%  此处显示详细说明
%  版本二
%  左右两个y轴属于不同的axes
outputArg1 = 'Done';
% outputArg2 = inputArg2;
% 如果只需要一根线，变量只需要到flag前就行
% 如果flag=1，用原来的轴画第二根线
% 如果flag=2，新建一根y轴
% general 共用的信息（元胞），设置如下
%{ 0
general = {'figure name', 'your figure name';
    'title name','your title';
    'x_label','your x label';
    'y_label','your y label';
    };
%}
% date 以第一条y轴作图的数据，设置如下
%{0
x1 = -2:0.01:5;y1=cos(x1);
x2=1:0.2:6;y2=sin(x2);
x3=1:0.05:4;y3=x3;
data = {'x', 'y','legend','color','LineStyle';
    x1,y1,'datavhg1','b','-';
    x2,y2,'shu2',[0.5,0.5,0],'-.';
    x3,y3,'lbukl','r',':';
    };
%}
% other的设置
%{ 0
other = {
    'y_label2','your y label2';
    };
%}
% another_axis 以第二条y轴作图的数据，设置如下
%{0
x1 = 0:0.01:5.5;y1=1+cos(x1);
x2=1:0.2:6;y2=2*sin(x2);
x3=1:0.05:4;y3=2*x3+3;
another_axis = {'x', 'y','lengend','color','LineStyle';
    x1,y1,'x','k','-';
    x2,y2,'yy',[0.5,0.1,0.2],'-.';
    x3,y3,'zzz','c',':';
    };
%}
%% 此处定义一些默认的值
MarkerSize = 6;
Interpreter = 'latex';
FontSize = 14;
nargin
yaxis1_color = [0.00,0.45,0.74];
yaxis2_color =[1.00,0.07,0.65];

%% 设置图形窗口
Hf_this = figure;
set(Hf_this,'Name',general{1,2}); % 窗口名字
Hf_this.NumberTitle='off'; % 是否显示名字前面的Figure 1 %同时可以看出操作句柄的两种形式
title(general{2,2}); %标题名字
set(Hf_this,'Color','white')% 背景颜色none,'red','green','blue','cyan','magenta','yellow','black',也可用RGB,如[110]
set(Hf_this,'Renderer', 'painters')% 渲染器
set(Hf_this,'Position', [1041 304 560 420])% 含义分别为左和下边缘到窗口，宽度，高度，比例最好为4:3
set(Hf_this,'Units', 'pixels')% 单位，默认是pixels,归一化为'normalized'
Ha_this = gca;

%% 绘图区
[rows,cols] = size(data); % 获取数据的行列，注意第一行是标题，应该除开
% yyaxis left;
Ha_this.YAxisLocation = 'left';
for order = 2:rows
    x = data{order,1};
    y = data{order,2};
    legend_name = data{order,3};
    color = data{order,4};
    LineStyle = data{order,5};
    plot(x,y,'color',color,'LineStyle',LineStyle,'LineWidth',2,'MarkerSize',MarkerSize,'MarkerEdgeColor',color,...
        'MarkerFaceColor',[.49 1 .63])
    legend_str{order-1} = [legend_name];
    hold on;
    
    
end
%% 标签，图注，坐标轴1更改
Hlgd=legend
%     set(Hlgd,'String','legend $\alpha$ $\beta$') % 标签名词
set(Hlgd,'String',legend_str) % 标签名词
% legend(legend_str) % 标签名词
set(Hlgd, 'FontSize',FontSize-2)
set(Hlgd, 'TextColor',yaxis1_color )
set(Hlgd, 'Location','northwest')% best,详细阅读手册
set(Hlgd, 'Interpreter',Interpreter)
set(Hlgd, 'Box','on') %是否 删除图例轮廓
hold on;

% Ha_this = gca; % get the axes object
set(Ha_this,'LineWidth',1.5,'YColor',yaxis1_color,'FontSize', FontSize,'FontWeight','bold');
set(Ha_this,'XMinorTick','on'); %打开小刻度
x_label = general{3,2};
y_label = general{4,2};
xlabel(x_label,'FontSize', FontSize,'FontWeight','bold');
ylabel(y_label,'FontSize', FontSize,'FontWeight','bold');
Ha_this.TickDir = 'out'; % 刻度方向 out in both
% xticks('auto'); %或者用一个向量
% xticklabels([2 3 4]); % 要显示那些数字的标签


%% 设置第二个y轴,坐标轴2更改
% %------------------------------------------------------
if true
    % 开始新建一个axes
    axesNew = axes('position',get(Ha_this,'position'),'visible','off');
    hold on
    second_axis = axesNew;
    %     yyaxis right;
    second_axis.YAxisLocation = 'right'
    y_label2 = other{1,2};
    set(second_axis,'XLim',Ha_this.XLim);% 让两个x轴重合
    
    set(second_axis,'ycolor',yaxis2_color) % 设置标签颜色
    
    
    Hlgd2=legend(second_axis);
    %         y = 100*sin(XXX);
    [rows,cols] = size(another_axis); % 获取数据的行列，注意第一行是标题，应该除开
    for order = 2:rows
        x = another_axis{order,1};
        y = another_axis{order,2};
        legend_name = another_axis{order,3};
        color = another_axis{order,4};
        LineStyle = another_axis{order,5};
        plot(x,y,'color',color,'LineStyle',LineStyle,'LineWidth',2,'MarkerSize',MarkerSize,'MarkerEdgeColor',color,...
            'MarkerFaceColor',[.49 1 .63])%,'DisplayName',legend_name)
        legend_str2{order-1} = [legend_name];
        hold on;
        
        
    end
    
    
    set(Hlgd2,'String',legend_str2) % 标签名词
    %     legend(legend_str) % 标签名词
    set(Hlgd2, 'FontSize',FontSize-2)
    set(Hlgd2, 'TextColor',yaxis2_color )
    set(Hlgd2, 'Location','best')% best,详细阅读手册
    set(Hlgd2, 'Interpreter',Interpreter)
    set(Hlgd2, 'Box','on') %是否 删除图例轮廓
    
    %------------------------------------------------------
    set(second_axis,'LineWidth',1.5,'YColor',yaxis2_color,'FontSize', FontSize,'FontWeight','bold');
    %     set(second_axis,'XMinorTick','on'); %打开小刻度
    ylabel(second_axis,y_label2,'FontSize', FontSize,'FontWeight','bold');
    second_axis.TickDir = 'out'; % 刻度方向 out in both
    % xticks('auto'); %或者用一个向量
    % xticklabels([2 3 4]); % 要显示那些数字的标签
end

%% 其它设置
% box on; %是否显示边框
box off;
% grid on;
% grid minor;
% saveas(Hf_this, 'WithMargins.eps','psc2')
%%

disp("Congratulations! Plot Done");
end