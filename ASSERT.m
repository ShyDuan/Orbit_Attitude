function ASSERT(c,errorstr)
% function ASSERT(c,errorstr)
% 确保输入条件成立
% 参数:     c: 输入条件，如果c有分量为0，则中断程序
%           errorstr: 错误提示字符串,默认为'非法输入'

if nargin==1
    errorstr='非法输入';
end
if(~all(c))
    error(errorstr);
end