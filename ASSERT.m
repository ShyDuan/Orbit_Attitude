function ASSERT(c,errorstr)
% function ASSERT(c,errorstr)
% ȷ��������������
% ����:     c: �������������c�з���Ϊ0�����жϳ���
%           errorstr: ������ʾ�ַ���,Ĭ��Ϊ'�Ƿ�����'

if nargin==1
    errorstr='�Ƿ�����';
end
if(~all(c))
    error(errorstr);
end