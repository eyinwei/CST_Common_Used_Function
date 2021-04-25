%% 函数或者脚本说明
%{  
---------------------------------------------------
*文件名: PEAK
*函数名: PEAK
*功   能:计算波峰的峰值 位置 宽度 凸起值
*变量说明:
    imported_data：一条线 一维矩阵
    outputArg: 依次返回每个峰的峰值，位置，宽度
*注意事项:
    1 文件用非legacy格式导出最好，不用改参数
    2 在CST的结果teemplete results中定义计算吸收或其它变量的值，这样不用再进行数据处理
    3 
---------------------------------------------------
%}

%%
function [outputArg] = PEAK(imported_data)
    VALUES = imported_data(:,2);
    FRE = imported_data(:,1);
    [pks,locs,widths,~] = findpeaks(VALUES,FRE,'Annotate','extents');
    % findpeaks(VALUES,FRE,'Annotate','extents'); % 不给句柄时会绘制
    outputArg=[pks';locs';widths'];
    outputArg = [outputArg(:,1);outputArg(:,2)];
    if length(outputArg)>6 % 有三个峰只要前两个
        outputArg = outputArg(1:6);
    end
    if length(outputArg)<6
        disp(['峰数：',length(outputArg/3)]);
    end
end


