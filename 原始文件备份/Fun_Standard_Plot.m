function [outputArg1,outputArg2] = Fun_Standard_Plot(XXX,YYY,legend_name,title_name,x_label,y_label,flag...
    ,XXX2,YYY2,legend_name_two,~,y_label2 )
%% Fun_Standard_Plot 此处显示有关此函数的摘要
%   此处显示详细说明
% outputArg1 = inputArg1;
% outputArg2 = inputArg2;
% 如果只需要一根线，变量只需要到flag前就行
% 如果flag=1，用原来的轴画第二根线
% 如果flag=2，新建一根y轴
%% 适用于单个y轴的情况
%     clear all;close all;
%     XXX=0:0.01:100;
%     YYY=cos(XXX);
%% 设置图形窗口，用了第二种方法，方便单独注释
Hf_this = figure;
set(Hf_this,'Name','your figure window name here'); % 窗口名字
Hf_this.NumberTitle='off'; % 是否显示名字前面的Figure 1 %同时可以看出操作句柄的两种形式
set(Hf_this,'Color','white')% 背景颜色none,'red','green','blue','cyan','magenta','yellow','black',也可用RGB,如[110]
set(Hf_this,'Renderer', 'painters')% 渲染器
set(Hf_this,'Position', [1041 304 560 420])% 含义分别为左和下边缘到窗口，宽度，高度，比例最好为4:3
set(Hf_this,'Units', 'pixels')% 单位，默认是pixels,归一化为'normalized'

%% 绘图区
plot(XXX,YYY,'b','LineWidth',2,'MarkerSize',6,'MarkerEdgeColor','b',...
    'MarkerFaceColor',[.49 1 .63])
%% 标签，图注，坐标轴更改
Hlgd=legend;
%     set(Hlgd,'String','legend $\alpha$ $\beta$') % 标签名词
set(Hlgd,'String',legend_name) % 标签名词
set(Hlgd, 'Location','northwest')% best,详细阅读手册
set(Hlgd, 'FontSize',12)
set(Hlgd, 'TextColor','blue' )
set(Hlgd, 'Interpreter','latex')
set(Hlgd, 'Interpreter','latex')
set(Hlgd, 'Box','on') %是否 删除图例轮廓

Ha_this = gca; % get the axes object
set(Ha_this,'lineWidth',1.5,'FontSize', 14,'FontWeight','bold');
set(Ha_this,'XMinorTick','on'); %打开小刻度
xlabel(x_label,'FontSize', 14,'FontWeight','bold');
ylabel(y_label,'FontSize', 14,'FontWeight','bold');
Ha_this.TickDir = 'out'; % 刻度方向 out in both
% xticks('auto'); %或者用一个向量
% xticklabels([2 3 4]); % 要显示那些数字的标签


%% 设置第二个y轴
%------------------------------------------------------
% 如果flag=1，用原来的轴画第二根线
% 如果flag=2，新建一根y轴
if flag==1
    hold on ;
    plot(XXX2,YYY2,'r','LineStyle','-.','LineWidth',2,'MarkerSize',6,'MarkerEdgeColor','b',...
        'MarkerFaceColor',[.49 1 .63],...
        'DisplayName',legend_name_two...% 第二个legend
        );
%     second_axis = gca;
%     ylabel(second_axis,y_label2,'FontSize', 14,'FontWeight','bold');
%     set(second_axis,'ycolor','r') % 设置标签颜色
elseif flag==2
    
    yyaxis right;
    %         y = 100*sin(XXX);
    plot(XXX2,YYY2,'r','LineStyle','-.','LineWidth',2,'MarkerSize',6,'MarkerEdgeColor','b',...
        'MarkerFaceColor',[.49 1 .63],...
        'DisplayName',legend_name_two...% 第二个legend
        );
    second_axis = gca;
    ylabel(second_axis,y_label2,'FontSize', 14,'FontWeight','bold');
    set(second_axis,'ycolor','r') % 设置标签颜色
    
    %------------------------------------------------------
end

%% 其它设置
% box on; %是否显示边框
box off
title(title_name)
% grid on;
% grid minor;
% saveas(Hf_this, 'WithMargins.eps','psc2')
%%
% 所有matlab的图，一律复制为矢量图，另外保存好原fig文件。
% 图采用4:3长宽比例（eg. 560比420）；图中曲线颜色为蓝色，
% 线宽为2号加粗；数据拟合曲线采用不连续红色线加粗；数据
% 点用圆圈marker表示；横纵坐标和横纵坐标轴为14号Helvetica
% 字体加粗，tick可以自己定义。

end