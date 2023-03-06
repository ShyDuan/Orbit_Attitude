function [sys,x0,str,ts] = controller(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumOutputs     = 17;
sizes.NumInputs      = 10;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];
function sys=mdlOutputs(t,x,u)
%%%惯量矩阵
J=[7.659 -0.002 0.038;
    -0.002 7.6490 -0.0170;
    0.038 -0.017 0.5330];
%%%姿态四元数
q0=u(1);
q=[u(2) u(3) u(4)]';
Q=[q0;q];
qX=[0 -q(3) q(2);
    q(3) 0 -q(1);
    -q(2) q(1) 0];

%%%角速度
omega=[u(5) u(6) u(7)]';
omegaX=[0 -omega(3) omega(2);
    omega(3) 0 -omega(1);
    -omega(2) omega(1) 0];

%%期望姿态
T=50;%欧拉角变化周期
thdx=2*pi/T*t;thdy=2*pi/T*t;thdz=2*pi/T*t;%三轴欧拉角
% wdi=[1 0 -sin(thdy);0 cos(thdx) sin(thdx)*cos(thdy);0 -sin(thdx) cos(thdx)*cos(thdy)]*[2*pi/T;2*pi/T;2*pi/T];%期望坐标系下的角速度
Qd=[cos(thdx/2)*cos(thdy/2)*cos(thdz/2)+sin(thdx/2)*sin(thdy/2)*sin(thdz/2);
    sin(thdx/2)*cos(thdy/2)*cos(thdz/2)-cos(thdx/2)*sin(thdy/2)*sin(thdz/2);
    cos(thdx/2)*sin(thdy/2)*cos(thdz/2)+sin(thdx/2)*cos(thdy/2)*sin(thdz/2);
    cos(thdx/2)*cos(thdy/2)*sin(thdz/2)-sin(thdx/2)*sin(thdy/2)*cos(thdz/2)];%期望坐标系的四元数

Qd=[1,0,0,0]';
wdi=[u(8),u(9),u(10)]';
% wdi=[0,-0.0011,0]';
qd0=Qd(1);
qd=[Qd(2) Qd(3) Qd(4)]';

%%%误差四元数
qe0=q0*qd0+qd'*q;
qe=qd0*q-q0*qd-qX*qd;
Qe=[qe0;qe];
qeX=[0 -qe(3) qe(2);
    qe(3) 0 -qe(1);
    -qe(2) qe(1) 0];

%%%期望坐标系到本体系的坐标变换矩阵
RQ=eye(3)-2*qe0*qeX+2*qeX*qeX;

%%%本体系下的期望角速度
wd=RQ*wdi;
wdX=[0 -wd(3) wd(2);
    wd(3) 0 -wd(1);
    -wd(2) wd(1) 0];

%%%误差角速度
omegae=omega-wd;
omegaeX=[0 -omegae(3) omegae(2);
    omegae(3) 0 -omegae(1);
    -omegae(2) omegae(1) 0];


if (qe0-1)^2+qe'*qe>0.3
Kd=0.2;
Kp=0.015;
elseif (qe0-1)^2+qe'*qe<=0.3&&(qe0-1)^2+qe'*qe>0.1
Kd=1;    
Kp=0.08;
elseif (qe0-1)^2+qe'*qe<=0.1
Kd=5;
Kp=0.3;
end


% Kd=200;    
% Kp=3;

u1=(wdX*J+J*wdX)*omega;
u2=wdX*J*omega;

% 控制力矩
tol=-Kp*J*qe-Kd*J*omega+u1+u2;



sys(1)=tol(1);
sys(2)=tol(2);
sys(3)=tol(3);
sys(4)=Qd(1);
sys(5)=Qd(2);
sys(6)=Qd(3);
sys(7)=Qd(4);
sys(8)=Qe(1);
sys(9)=Qe(2);
sys(10)=Qe(3);
sys(11)=Qe(4);
sys(12)=wd(1);
sys(13)=wd(2);
sys(14)=wd(3);
sys(15)=omegae(1);
sys(16)=omegae(2);
sys(17)=omegae(3);