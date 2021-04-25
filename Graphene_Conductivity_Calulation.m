%% 函数或者脚本说明
%{  
---------------------------------------------------
*文件名: Graphene_Conductivity_Calulation
*函数名: None
*功   能:使用了两个公式，分别计算了石墨烯的电导率
*变量说明:GC1和GC2是结果，由实部和虚部两项构成
---------------------------------------------------
%}

clc;clear all; %clf;

%% 定义一些常数项

lambda=10*1e-6;     %波长[m]
c = 3e8 ;                    %the speed of light
Vf=1e6;                      %费米速度[m/s]
ec=1.602e-19;          %元电子电荷 elementary charge
kB=1.38e-23;            %波尔兹曼常数
H_bar=6.63e-34/2/pi;%普朗克常数
Mob=10000*1e-4;     %载流子漂移迁移率
T=300;                         %温度[K]

omega=2*pi*c./lambda;%频率
Ef=0.43*ec; %费米能


n=(Ef./H_bar./Vf).^2./pi;%载流子浓度
tau=Mob.*Ef./ec./Vf.^2; %intra-band 弛豫时间 [s]
%% 第一种计算方法
GC1_1=2.*ec.^2.*kB.*T./(pi.*H_bar.^2).*(1i./(omega+1i./tau)).*log(2.*cosh(Ef./(2.*kB.*T)));%intra-band 
GC1_2=ec.^2./(4.*H_bar).*(0.5+1./pi.*atan((H_bar.*omega-2.*Ef)./(2.*kB.*T))-1i./(2.*pi).*log((H_bar.*omega+2.*Ef).^2./((H_bar.*omega-2.*Ef).^2+4.*(kB.*T).^2)));%inter-band
GC1=GC1_1+GC1_2;%电导率

%% 第二种计算方法，第二项结果不一样
GC2_1 = 1i*(ec^2*kB*T)/(pi*H_bar^2*(omega+1i/tau))*(Ef/kB/T+2*log(exp(-Ef/kB/T)+1));
GC2_2 = 1i*(ec^2/4/pi/H_bar)*log(...
    (2*abs(Ef)-H_bar*(omega+1i/tau))...
    /(2*abs(Ef)+H_bar*(omega+1i/tau))...
);
GC2=GC2_1+GC2_2;%电导率
disp("Caculate Done");
clearvars -except GC1 GC2