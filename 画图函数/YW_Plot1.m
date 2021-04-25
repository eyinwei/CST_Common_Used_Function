%% 函数或者脚本说明
%{  
---------------------------------------------------
*文件名: YW_Plot1 第一版
*函数名: hf=YW_Plot1(x,x,x,x)
*功   能:多条曲线绘图函数，可以开启第二个y轴，甚至可以使用第二套legend（不推荐）
*变量说明:
**varargin**:
----必须输入两个或四个元胞，否则报错
****genernal:
----varargin中第一个元胞，定义了一些公用信息
----general =
----  {
----    'figure name', 'your figure name';
----    'title name','your title';
----    'x_label','your x label';
----    'y_label','your y label';
----  };
****data:
----varargin中第二个元胞，定义图形的x,y,legend,color,linestyle(可含marker)
----data = 
----	{
----		'x', 'y','legend','color','LineStyle';
----		...;
----    }
****other:varargin中第三个元胞(可选)，定义图形的第二个ylabel，
    是否显示第二个y(建议1)，是否开启第二套legend(建议0)
----other = 
----	{
----    'y_label2','your y label2';
----    'second y',1;
----    'second legend', 0;
----    };
****another_axis:varargin中第四个元胞(和other同存亡)，格式与data基本一样

*注意事项:
		% 查看plot_test了解调用方法
        % 所有matlab的图，一律复制为矢量图，另外保存好原fig文件。
        % 图采用4:3长宽比例（eg. 560比420）；图中曲线颜色为蓝色，
        % 线宽为2号加粗；数据拟合曲线采用不连续红色线加粗；数据
        % 点用*圆圈marker*表示；横纵坐标和横纵坐标轴为14号Helvetica
        % 字体加粗，tick可以自己定义。
---------------------------------------------------
%}

% ===================main===========================
function [Hf_this] = YW_Plot1(varargin)

%% 先判断输入参数的个数
if nargin == 2
    general = varargin{1};
    data = varargin{2};
    other = cell(5,5); %随便一个空cell
    another_axis = cell(5,5);%随便一个空cell
elseif nargin == 4
    general = varargin{1};
    data = varargin{2};
    other = varargin{3};
    another_axis = varargin{4};
else
    print('input wrong, you should input 2 or 4 cells')
    return;
end
%% 此处定义一些默认的值
MarkerSize = 6;
Interpreter = 'latex';% 如果不使用中文的话,改成latex效果更好
FontSize = 14;
nargin;
xaxis1_color = [0 0 0];
yaxis1_color = [0.00,0.45,0.74];
yaxis2_color =[1.00,0.07,0.65];
Linewidth_box = 1.5;% 坐标轴，图例的线框宽度
Line_Width = 2; %线条的宽度
fig_size =  [500 300 560 420];%figure大小
% fig_size =  [500 300 720 360];%figure大小


%% 设置图形窗口参数
Hf_this = figure;
set(Hf_this,'Name',general{1,2}); % 窗口名字
Hf_this.NumberTitle='off'; % 是否显示名字前面的Figure 1 
set(Hf_this,'Color','white')% 背景颜色,也可用RGB,如[110]
set(Hf_this,'Renderer', 'painters')% 渲染器
set(Hf_this,'Position',fig_size)% 含义分别为左和下边缘到窗口，宽度，高度，比例最好为4:3
set(Hf_this,'Units', 'points')% 单位，默认是pixels,归一化为'normalized'
title(general{2,2}); %标题名字

% ///////////////////////////////////////
% 第一条或只有一条y轴的情况
%

%% 绘图区
Ha_this = gca; % get the axes object
[rows,cols] = size(data); % 获取数据的行列，注意第一行是标题，应该除开
 yyaxis left;
%Ha_this.YAxisLocation = 'left';
for order = 2:rows
    x = data{order,1};
    y = data{order,2};
    legend_name = data{order,3};
    color = data{order,4};
    LineStyle = data{order,5};
    
    H1(order-1)=plot(x,y,LineStyle,'color',color,'LineWidth',Line_Width,'MarkerSize',...
        MarkerSize,'MarkerEdgeColor',color);%'MarkerFaceColor',[.49 1 .63]
    legend_str{order-1} = [legend_name];
    hold on;
    
    
end
%% 标签，图注，坐标轴更改
Hlgd=legend;
set(Hlgd,'String',legend_str)
set(Hlgd,'FontName','Arial')
set(Hlgd, 'FontSize',FontSize-2);%FontSize-2
set(Hlgd, 'LineWidth',Linewidth_box)
set(Hlgd, 'TextColor',yaxis1_color )
set(Hlgd, 'Location','best')% best,详细阅读手册
set(Hlgd, 'Interpreter',Interpreter)
set(Hlgd, 'Box','off') %是否 删除图例轮廓
set(Hlgd,'color','none');
hold on;


set(Ha_this,'lineWidth',1.5,...
    'XColor',xaxis1_color,...
    'YColor',yaxis1_color,'FontSize', FontSize,'FontWeight','bold');
set(Ha_this,'color','none');
set(Ha_this,'XMinorTick','on'); %打开小刻度
x_label = general{3,2};
y_label = general{4,2};
xlabel(x_label,'FontSize', FontSize,'FontWeight','bold');
ylabel(y_label,'FontSize', FontSize,'FontWeight','bold');
Ha_this.TickDir = 'out'; % 刻度方向 out in both
% xticks('auto'); %或者用一个向量
% xticks([.75 1.9]); %或者用一个向量
% xticklabels([2 3 4]); % 要显示那些数字的标签

% box off;

% ///////////////////////////////////////
% 第二条y轴的情况
%

%% 设置第二个y轴
% %------------------------------------------------------
if other{2,2}
    yyaxis right
    [rows,cols] = size(another_axis); % 获取数据的行列，注意第一行是标题，应该除开
    for order = 2:rows
        x = another_axis{order,1};
        y = another_axis{order,2};
        legend_name = another_axis{order,3};
        color = another_axis{order,4};
        LineStyle = another_axis{order,5};
        H2(order-1)=plot(x,y,LineStyle,'color',color,'LineWidth',Line_Width,'MarkerSize',MarkerSize,...
        'MarkerEdgeColor',color,'MarkerFaceColor',[.49 1 .63],'DisplayName',legend_name);
        legend_str2{order-1} = [legend_name];
        hold on;
            
    end
    y_label2 = other{1,2};
    ylabel(Ha_this,y_label2,'FontSize', FontSize,'FontWeight','bold')%,'visible','off');
    set(Ha_this,'ycolor',yaxis2_color) % 设置标签颜色
%    yyaxis left % 再设置一下左轴，因为前面使用的是Ha_this.YAxisLocation = 'left'，经过后面的yyaxis，颜色发生改变
%    set(Ha_this,'lineWidth',15,'YColor',yaxis1_color,'FontSize', FontSize,'FontWeight','bold');
%    yyaxis right
    
    %% 设置第二个轴系，用来分别显示图例
    if other{3,2} %是否分开显示图例
        legend(Ha_this,H1,legend_str)
        second_axis = axes('position',get(Ha_this,'position'),'visible','off',...
            'Color','none');
        Hlgd2=legend(second_axis);
        legend(second_axis,H2,legend_str2) % 标签名词
        set(Hlgd2, 'FontSize',FontSize-2)
        set(Hlgd2, 'LineWidth',Linewidth_box)
        set(Hlgd2, 'TextColor',yaxis2_color )
        set(Hlgd2, 'Location','northeast')% best,详细阅读手册
        set(Hlgd2, 'Interpreter',Interpreter)
        set(Hlgd2, 'Box','on') %是否 删除图例轮廓
        set(Hlgd2,'color','none');
        linkaxes([Ha_this,second_axis],'x');
        
% %------------------------------------------------------
    end
end

%% 其它设置
 box on; %是否显示边框
% box off
% grid on;
% grid minor;


disp("Congratulations! Plot Done!");
end
%% colors
% https://blog.csdn.net/wang1qqqq/article/details/94459631