%% 文件说明
%{
% 函数(文件)功能：计算两种模型的灵敏度 有三种形式, 介质的厚度nh从5-10
% 注意事项：
    1 show_every_var = 1 or 2 显示或者不显示每个变量
    2 fsmode = 1 2 3 三种灵敏度的计算方法
%}
clear;
close all;
load('color_QX');
vars = {'proposed';'planar'};
nhs = {'nh5','nh8','nh11','nh14','nh17'};
show_every_var = 2;
%% 取得所有峰值信息
for eachturn = 2:-1:1
    var = vars{eachturn};
    peaksdetail = [];
    for eachnh = 1:length(nhs)
        diretory = "F:\Documents\CST\frontier in physics\用来测试折射率的平面或凸起模型\tA with RI\"...
            +var+"\"+nhs{eachnh};
        RANGE=1:0.1:2.7;
        
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

        end
    end
    
    % 结束之前保存峰的细节
    if eachturn==2
        peaksdetail_planar = peaksdetail;
    elseif eachturn ==1
        peaksdetail_proposed = peaksdetail;
    end
    clear peaksdetail
end
%% 假设每条线都有两个峰
for eachturn = 2:-1:1
    if eachturn==2
        peaksdetail = peaksdetail_planar;
    elseif eachturn ==1
        peaksdetail = peaksdetail_proposed;
    end
    [NUM,~] = size(peaksdetail);
    NUM=NUM/6/length(nhs); % 除以每条线的6个值，除以nh的5组，得到每组的条数

    Frequency1 = [];Frequency2=[];
    for everynh = 1:length(nhs)
        thisgroup = peaksdetail((everynh-1)*6*length(RANGE)+1:...
            everynh*6*length(RANGE));
        firstline = thisgroup(1:6);
        f01 = firstline(2);
        f02 = firstline(5);
        FS1 = [];FS2 = [];WD1 = [];WD2 = [];
        
        for every = 1:NUM
            FS1 = [FS1;thisgroup(6*every-4)-f01];
            FS2 = [FS2;thisgroup(6*every-1)-f02];
            WD1 = [WD1;thisgroup(6*every-3)];
            WD2 = [WD2;thisgroup(6*every)];
        end
        fsmode = 1;
        switch fsmode
            case 1
                YLABEL='Frequency Shift (THz)';
            case 2
                %% 另外一种FOM
                FS1 = FS1./WD1;
                FS2 = FS2./WD2;YLABEL='Frequency Shift/FWHM';
            case 3
                FS1 = FS1./f01*100;
                FS2 = FS2./f02*100;YLABEL='Frequency Shift(%)';
        end
        % 保存这些横坐标值，按列存储
        Frequency1 = [Frequency1,FS1];
        Frequency2 = [Frequency2,FS2];
    end
    % 分成平面和非平面两组结果
    if eachturn==2
        Frequency1_planar = Frequency1;
        Frequency2_planar = Frequency2;
    elseif eachturn ==1
        Frequency1_proposed = Frequency1;
        Frequency2_proposed = Frequency2;
    end
    clear Frequency1 Frequency2
    
    
    
end
 
% x = 1:.1:3;
% x = x';
% for ii =1:6
%     plot(x,Frequency2_proposed(:,ii));
%     hold on
% end
    
    Frequency1_planar(13,4) = NaN;
    Frequency2_planar(13,4) = NaN;
    
   

      
    
    
%     %% 通过线性拟合计算直线
%     P1 = polyfit(RANGE,FS1,1);
%     FS_fit1 = polyval(P1,RANGE);
%     P2 = polyfit(RANGE,FS2,1);
%     FS_fit2 = polyval(P2,RANGE);  
%     if eachturn == 2
%         % 保存旧模型数据
%         FS_old1 = FS1;FS_old2 = FS2;
%         FS_old_fit1 = FS_fit1; FS_old_fit2 = FS_fit2;
%         P_old1 = P1;
%         P_old2 = P2;
%     end
            
    
% end 
    %%  平面模型1
    %{1
    general = {'figure name', ['平面模型的折射率的变化f1'];
        'title name',' ';
        'x_label','Refractive Index';
        'y_label',YLABEL;
        };
    data = {'x', 'y','legend','color','LineStyle';
        RANGE,Frequency1_planar(:,1),'$t_A=5 $',QX(1,:),'-d';
        RANGE,Frequency1_planar(:,2),'$t_A=8 $',QX(2,:),'-d';
        RANGE,Frequency1_planar(:,3),'$t_A=11$',QX(3,:),'-d';
        RANGE,Frequency1_planar(:,4),'$t_A=14$',QX(4,:),'-d';
        RANGE,Frequency1_planar(:,5),'$t_A=17$',QX(5,:),'-d';
        };
    hand11 = YW_Plot1(general,data);
    set(gca(hand11),'XLim',[1 2.7])
%}
    %%  平面模型2
    %{1
    general = {'figure name', ['平面模型的折射率的变化f2'];
        'title name',' ';
        'x_label','Refractive Index';
        'y_label',YLABEL;
        };
    data = {'x', 'y','legend','color','LineStyle';
        RANGE,Frequency2_planar(:,1),'$t_A=5 $',QX(1,:),'-s';
        RANGE,Frequency2_planar(:,2),'$t_A=8 $',QX(2,:),'-s';
        RANGE,Frequency2_planar(:,3),'$t_A=11$',QX(3,:),'-s';
        RANGE,Frequency2_planar(:,4),'$t_A=14$',QX(4,:),'-s';
        RANGE,Frequency2_planar(:,5),'$t_A=17$',QX(5,:),'-s';
        };
    hand12 = YW_Plot1(general,data);
    set(gca(hand12),'XLim',[1 2.7])
%}
    %%  新模型1
    %{1
    general = {'figure name', ['新模型的折射率的变化f1'];
        'title name',' ';
        'x_label','Refractive Index';
        'y_label',YLABEL;
        };
    data = {'x', 'y','legend','color','LineStyle';
        RANGE,Frequency1_proposed(:,1),'$t_A=5 $',QX(1,:),'-o';
        RANGE,Frequency1_proposed(:,2),'$t_A=8 $',QX(2,:),'-o';
        RANGE,Frequency1_proposed(:,3),'$t_A=11$',QX(3,:),'-o';
        RANGE,Frequency1_proposed(:,4),'$t_A=14$',QX(4,:),'-o';
        RANGE,Frequency1_proposed(:,5),'$t_A=17$',QX(5,:),'-o';
        };
    hand21 = YW_Plot1(general,data);
    set(gca(hand21),'XLim',[1 2.7])
%}
    %%  新模型2
    %{1
    general = {'figure name', ['新模型的折射率的变化f2'];
        'title name',' ';
        'x_label','Refractive Index';
        'y_label',YLABEL;
        };
    data = {'x', 'y','legend','color','LineStyle';
        RANGE,Frequency2_proposed(:,1),'$t_A=5 $',QX(1,:),'-x';
        RANGE,Frequency2_proposed(:,2),'$t_A=8 $',QX(2,:),'-x';
        RANGE,Frequency2_proposed(:,3),'$t_A=11$',QX(3,:),'-x';
        RANGE,Frequency2_proposed(:,4),'$t_A=14$',QX(4,:),'-x';
        RANGE,Frequency2_proposed(:,5),'$t_A=17$',QX(5,:),'-x';
        };
    hand22 = YW_Plot1(general,data);
    set(gca(hand22),'XLim',[1 2.7])
%}

%% 同时绘两个图
%{
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