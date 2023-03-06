%%%先运行main函数，再打开Sim.slx进行仿真
%%%zy2115134@buaa.edu.cn 张桐 202.6.28

clear;
BIG_OEMGA=5.0199/180*pi;
i=97.4624/180*pi;
e=0.0017714;
little_omega=98.0865/180*pi;
M=307.5984/180*pi;
orbit_frquence=15.19435917;

T0=[2022 177 0.60599694];



uE = 3.986004418e+5;

Mm=0.02*[1 1 1];
%%%地心轨道系中位置与速度
f=M;
a=((86400/2/pi/orbit_frquence)^2*uE)^(1/3);%%%半长轴
r=a*(1-e^2)/(1+e*cos(f));
Reo=[r*cos(f),r*sin(f),0]';
Veo=sqrt(uE/a/(1-e^2))*[-sin(f),e+cos(f),0]';

%%%赤道惯性系ECI中位置与速度
Ri=Rotatez(BIG_OEMGA)*Rotatex(i)*Rotatez(little_omega)*Reo;
Vi=Rotatez(BIG_OEMGA)*Rotatex(i)*Rotatez(little_omega)*Veo;


uE = 3.986004418e+5;

x=Ri(1);
y=Ri(2);
z=Ri(3);
x_dot=Vi(1);
y_dot=Vi(2);
z_dot=Vi(3);

r=sqrt(x^2+y^2+z^2);%%%半径
v=sqrt(x_dot^2+y_dot^2+z_dot^2);%%%速度
aa=1/(2/r-(x_dot^2+y_dot^2+z_dot^2)/uE);%%%半长轴
h=[0 -z y;z 0 -x;-y x 0]*Vi;%%%角动量
p=h'*h/uE;%%%半通径
e=sqrt(1-p/aa);%%%离心率

ii=acos(h(3)/sqrt(h'*h));%%%
vec_N=[0 -1 0;1 0 0;0 0 0]*h;%%%节线方向;
OMEGA=acos(vec_N(1)/sqrt(vec_N'*vec_N));%%%升交点赤经
theta=acos(vec_N'*Ri/sqrt(vec_N'*vec_N)/r);%%%升交点幅角
% f=acos((p-r)/r/e);%%%真近角
% little_omega=theta-f;%%%近地点幅角
Roi=Rotatez(OMEGA)*Rotatex(i)*Rotatez(theta+pi/2)*Rotatex(-pi/2)*[0;0;a];






