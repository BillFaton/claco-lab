% Master1 CORO 
% Classical Control
% exercise 1 of lab1

clear all, close all, clc

disp('section 1.1')
disp('')

k=1;
T1=1;T2=5;T3=10;T4=50;
G1=tf(k,[T1 1]);
G2=tf(k,[T2 1]);
G3=tf(k,[T3 1]);
G4=tf(k,[T4 1]);

f1=figure(1);
set(f1,'position',[1   462   504   343])
set(f1,'name','question 1.1.1, step response, pole location, different T');
subplot(211)
step(G1,G2,G3,G4);
legend('G1','G2','G3','G4')
subplot(212)
pzmap(G1,G2,G3,G4)
legend('G1','G2','G3','G4')

S1 = stepinfo(G1,'SettlingTimeThreshold',0.05);
S2 = stepinfo(G2,'SettlingTimeThreshold',0.05);
S3 = stepinfo(G3,'SettlingTimeThreshold',0.05);
S4 = stepinfo(G4,'SettlingTimeThreshold',0.05);
disp(['5% settling time of G1 (T1=1) :',num2str(S1.SettlingTime)])
disp(['5% settling time of G2 (T2=5) :',num2str(S2.SettlingTime)])
disp(['5% settling time of G3 (T3=10) :',num2str(S3.SettlingTime)])
disp(['5% settling time of G4 (T4=50) :',num2str(S4.SettlingTime)])

%%

disp('---------------------------------------------')
disp('section 1.2')
disp('')

k1=1;k2=2;k3=5;k4=10;
T=10;

G1=tf(k1,[T 1]);G2=tf(k2,[T 1]);G3=tf(k3,[T 1]);G4=tf(k4,[T 1]);

f2=figure(2);hold on
set(f2,'position',[507   462   504   343])
set(f2,'name','question 1.2.1, step response, different gain');
step(G1,G2,G3,G4);
plot([0 T],[0 k1],'k')
plot([0 T],[0 k2],'k')
plot([0 T],[0 k3],'k')
plot([0 T],[0 k4],'k')
plot([T T],[0 k4],':k')
legend('G1','G2','G3','G4')


S1 = stepinfo(G1,'SettlingTimeThreshold',0.05);
S2 = stepinfo(G2,'SettlingTimeThreshold',0.05);
S3 = stepinfo(G3,'SettlingTimeThreshold',0.05);
S4 = stepinfo(G4,'SettlingTimeThreshold',0.05);

disp(['5% settling time of G1 (k=1) :',num2str(S1.SettlingTime)])
disp(['5% settling time of G2 (k=2) :',num2str(S2.SettlingTime)])
disp(['5% settling time of G3 (k=5) :',num2str(S3.SettlingTime)])
disp(['5% settling time of G4 (k=10) :',num2str(S4.SettlingTime)])

%%

disp('---------------------------------------------')
disp('section 1.3')
disp('')

k=1;
T1=1;T2=5;T3=10;T4=50;
G1=tf(k,[T1 1]);
G2=tf(k,[T2 1]);
G3=tf(k,[T3 1]);
G4=tf(k,[T4 1]);

f3=figure(3);
set(f3,'position',[1    52   504   343])
set(f3,'name','question 1.3.1/1.3.2, Frequency and step response, different T');
subplot(121)
%bode(G1,G2,G3,G4);
bodemag(G1,G2,G3,G4);
legend('G1','G2','G3','G4')
subplot(122)
step(G1,G2,G3,G4)
legend('G1','G2','G3','G4')

wc1=bandwidth(G1);
wc2=bandwidth(G2);
wc3=bandwidth(G3);
wc4=bandwidth(G4);

S1 = stepinfo(G1,'SettlingTimeThreshold',0.05);
S2 = stepinfo(G2,'SettlingTimeThreshold',0.05);
S3 = stepinfo(G3,'SettlingTimeThreshold',0.05);
S4 = stepinfo(G4,'SettlingTimeThreshold',0.05);

disp(['Bandwith of G1 (T1=1) :',num2str(wc1)])
disp(['Bandwith of G2 (T2=5) :',num2str(wc2)])
disp(['Bandwith of G3 (T3=10) :',num2str(wc3)])
disp(['Bandwith of G4 (T4=50) :',num2str(wc4)])
disp(' ')
disp(['5% settling time of G1 (T1=1) :',num2str(S1.SettlingTime)])
disp(['5% settling time of G2 (T2=5) :',num2str(S2.SettlingTime)])
disp(['5% settling time of G3 (T3=10) :',num2str(S3.SettlingTime)])
disp(['5% settling time of G4 (T4=50) :',num2str(S4.SettlingTime)])
disp(' ')
