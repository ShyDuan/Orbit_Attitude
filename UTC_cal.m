function UTC = UTC_cal(Y,D,S,t)

%%%Y年 D一年中第几天 S多少天 t经过的秒数
S_sum=S*86400+t;
D_utc=D+floor(S_sum/86400);
S_utc=mod(S_sum,86400);

Hour_utc=floor(S_utc/3600);
temp=mod(S_utc,3600);
Minute_utc=floor(temp/60);
Sec_utc=mod(temp,60);

month=[31 28 31 30 31 30 31 31 30 31 30 31];
month_utc=1;
for i=1:12
    
    if D_utc-month(i)<=0
        month_utc=i;
        break
    else
        D_utc=D_utc-month(i);
    end
end
    
    
UTC=[Y month_utc D_utc Hour_utc Minute_utc Sec_utc];

end

