%% 函数或者脚本说明
%{  
---------------------------------------------------
*文件名: readsweep
*函数名: readsweep
*功   能:在CST扫参后，从CST导出的逐个txt文档中读取文件的前两列，并在第
    三列添加上当前参数的当前值
*变量说明:
    filename：字符串，合成的文件路径，包含文件名，不包含后缀
    vars_name: 数据格式，当前变量的值，例如vars_name = 5，则在第三列添加上一列5
    dataLines：也可以指定从哪一行开始读取
    thedata：返回矩阵格式，三列的值分别对应着 频率 吸收 变量值（这个文件为例）
*注意事项:
    1 文件用非legacy格式导出最好，不用改参数
    2 在CST的结果teemplete results中定义计算吸收或其它变量的值，这样不用再进行数据处理
    3 
---------------------------------------------------
%}

%%
function thedata = readsweep(filename, vars_name,dataLines)
%%
% 如果不指定 dataLines，请定义默认范围：从第四行开始读取内容
% 前几行都是标题，也可以自行指定从第几行开始读取
if nargin < 3
    dataLines = [4, Inf]; 
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% 指定范围和分隔符
opts.DataLines = dataLines;
opts.Delimiter = "\t";

% 指定列名称和类型
opts.VariableNames = ["Fre", "Absop"];
opts.VariableTypes = ["double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 导入数据
thedata = readtable(filename, opts);
thedata = table2array(thedata);
[r,c] = size(thedata);
% disp(['这一组的变量是',num2str(vars_name)]);
% newvalue = eval(vars_name);
newvalue = vars_name;
thedata = [thedata,ones(r,1)*newvalue];

end
