function jd=UCT2JD(Y,M,D,H,Mi,S)
% function jd=G2JD(Y,M,D,H,Mi,S)
% ����(Gregorian Calendar)ʱ��ת��Ϊ������(JD)
% ��ʽ�� jd=G2JD(Y,M,D,H,Mi,S)
%        jd=G2JD(date)
%        jd=G2JD(Y,M,D)
% ����:  jd            - ������
% ������ Y,M,D,H,Mi,S  - �꣬�£��գ�Сʱ�����ӣ��룻S������С������������������������.
%       date           - ����[�꣬�£��գ�Сʱ�����ӣ���]��6ά������date(6)������С������������������������.
%                        ����Ϊ����[�꣬�£���]��3ά����,date(3)������С������������������������.
%       Y,M,D          - �꣬�£��գ�D������С������������������������.
% ����  vpa(G2JD(1949,12,31,22,9,42))
%       vpa(G2JD([1949,12,31,22,9,42]))
%       vpa(G2JD(1949,12,31+22/24+9/1440+42/86400))

if nargin==1
    if(length(Y)==6)
        M=round(Y(2));D=round(Y(3));
        H=round(Y(4));Mi=round(Y(5));
        S=Y(6);Y=round(Y(1));
        Dh=H/24+Mi/1440+S/86400;
    elseif length(Y)==3
        M=round(Y(2));D=Y(3);Y=round(Y(1));
        Dh=0;
    else
        error('date�ĳ���ӦΪ3��6!');
    end
elseif nargin==3
    Y=round(Y);
    M=round(M);
    Dh=0;
elseif nargin==6
    Y=round(Y);M=round(M);
    D=round(D);H=round(H);
    Mi=round(Mi);
    Dh=H/24+Mi/1440+S/86400;
else
    error('�����������ӦΪ1��3��6!');
end

ASSERT(M>=1 & M<=12);
ASSERT(D>=1 & D<=32);

y = Y + 4800; %4801 B.C. is a century year and also a leap year.  
if( Y < 0 )
	y =y+ 1; 	% Please note that there is no year 0 A.D.
end
m = M;
if( m <= 2 )	%January and February come after December.
	m = m+12; 
	y = y - 1;
end
e =floor(30.6 * (m+1));
a =floor(y/100);	%number of centuries
if( Y <1582 )|(Y==1582&M<10)|(Y==1582& M==10 &D<15)
   % 10days missing between Gregorian (start from 1582,10,15)and Julian Calendar (end at 1582,10,4)
	b = -38;
else
	b = floor((a/4) - a); %number of century years that are not leap years
end
c =floor(365.25* y); %Julian calendar years and leap years 
jd = b + c + e + D+Dh- 32167.5;