%% 文件说明
%{
% 函数(文件)功能：计算两种模型的灵敏度 有三种形式
% 注意事项：
    1 show_every_var = 1 or 2 显示或者不显示每个变量
    2 fsmode = 1 2 3 三种灵敏度的计算方法
%}
clear;
close all;
load('color_QX');
vars = {'n12';'n12old'};
show_every_var = 2;
for eachturn = 2:-1:1
    var = vars{eachturn};
    %%
    diretory = "F:\Documents\CST\frontier in physics\里程\"+var+"\导出文本";
    RANGE=1:0.1:3;
    peaksdetail = [];
    
    %%
    for each =  RANGE% txt的命名要按这个来
        myfilename = diretory+['\',num2str(each),'.txt'];%文件名
        tmp=readsweep(myfilename,each);
        if show_every_var == 1
            %{1
            %如果要显示每个变量名就打开这段程序
            if each>floor(each) %如果文件中有小数，把小数中的.换成_
                xiaoshu = (each - floor(each)+0.001)*10;
                % 这里+.01是因为floor有bug，有时floor(2)=1
                makename=[var,'_',...
                    num2str(floor(each)),...
                    '_',num2str(floor(xiaoshu))];% 先定义这样一个变量名
            else
                makename=[var,'_',num2str(each)];% 整数就正常计算
            end
            %}
            eval([makename,'=','tmp',';']);
        elseif (show_every_var ==2)&&(each==1)
            makename=[var,'_',num2str(each)];% 至少需要计算f0的信息
            eval([makename,'=','tmp',';']);
        end
        
        peaksdetail = [peaksdetail;PEAK(tmp)];
        clear tmp;
    end
    
    %% f0
    [~,f0] = findpeaks(eval([var,'_1','(:,2)']),eval([var,'_1','(:,1)']));
    %% FRE SHIFT; since it is double-peak, we definite 2 fs values；WD: peak's width
    [NUM,~] = size(peaksdetail);%NUM=NUM/6;
    FS1 = [];FS2 = [];WD1 = [];WD2 = [];
    
    for every = 1:NUM/6
        FS1 = [FS1;peaksdetail(6*every-4)-f0(1)];
        FS2 = [FS2;peaksdetail(6*every-1)-f0(2)];
        WD1 = [WD1;peaksdetail(6*every-3)];
        WD2 = [WD2;peaksdetail(6*every)];
    end
    % y坐标的含义 
    fsmode = 1;
    switch fsmode
        case 1
            YLABEL='Frequency Shift (THz)';
        case 2
        %% 另外一种FOM
            FS1 = FS1./WD1;
            FS2 = FS2./WD2;YLABEL='Frequency Shift/FWHM';
        case 3
            FS1 = FS1./f0(1)*100;
            FS2 = FS2./f0(2)*100;YLABEL='Frequency Shift(%)';
    end
      
    
    
    %% 通过线性拟合计算直线
    P1 = polyfit(RANGE,FS1,1);
    FS_fit1 = polyval(P1,RANGE);
    P2 = polyfit(RANGE,FS2,1);
    FS_fit2 = polyval(P2,RANGE);  
    if eachturn == 2
        % 保存旧模型数据
        FS_old1 = FS1;FS_old2 = FS2;
        FS_old_fit1 = FS_fit1; FS_old_fit2 = FS_fit2;
        P_old1 = P1;
        P_old2 = P2;
    end
            
    
end 
    %%  绘制新模型
    %{1
    general = {'figure name', ['新模型的折射率的变化'];
        'title name',' ';
        'x_label','Refractive Index';
        'y_label',YLABEL;
        };
    close all;
    data = {'x', 'y','legend','color','LineStyle';
        RANGE,FS1,'$f_1$',QX(1,:),'s';
        RANGE,FS_fit1,'$f_1$ fit',QX(1,:),'-';
        RANGE,FS2,'$f_2$',QX(5,:),'d';
        RANGE,FS_fit2,'$f_2$ fit',QX(5,:),'-.';
        };
    hand1 = YW_Plot1(general,data);
%}
    %%  绘制旧模型
    %{1
    general = {'figure name', ['旧模型的折射率的变化'];
        'title name',' ';
        'x_label','Refractive Index';
        'y_label',YLABEL;
        };
    data = {'x', 'y','legend','color','LineStyle';
        RANGE,FS_old1,'$f_1$',QX(3,:),'s';
        RANGE,FS_old_fit1,'$f_1$ fit',QX(3,:),'-';
        RANGE,FS_old2,'$f_2$',QX(9,:),'d';
        RANGE,FS_old_fit2,'$f_2$ fit',QX(9,:),'-.';
        };
    hand2 = YW_Plot1(general,data);
%}

%% 同时绘两个图
%{1
general = {'figure name', ['新旧模型折射率的变化'];
    'title name',' ';
    'x_label','Refractive Index';
    'y_label',YLABEL;
    };
data = {'x', 'y','legend','color','LineStyle';
    RANGE,FS1,'$f_1$',QX(1,:),'s';
    RANGE,FS_fit1,'$f_1$ fit',QX(1,:),'-';
    RANGE,FS2,'$f_2$',QX(11,:),'^';
    RANGE,FS_fit2,'$f_2 fit$',QX(11,:),'-.';
    };
other = {
    'y_label2',YLABEL;
    'second y',1;
    'second legend', 0;
    };
another_axis = {'x', 'y','lengend','color','LineStyle';
    RANGE,FS_old1,'$f_1$',QX(3,:),'s';
    RANGE,FS_old_fit1,'$f_1 fit$',QX(3,:),'-';
    RANGE,FS_old2,'$f_2$',QX(7,:),'^';
    RANGE,FS_old_fit2,'$f_2 fit$',QX(7,:),'-.';
    };
hand = YW_Plot1(general,data,other,another_axis);
% set(gca(hand),'XLim',[.75 1.9]);
% set(gca(hand),'XTick',[.75 1.9])
%}
clear general data other another_axis