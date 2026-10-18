%%
clear all, close all, clc

disp('section 3.2.1')
disp('')
cs = [-10, -0.25, -0.1, 0.1, 0.25, 10];

s = tf('s');
G = 1/((s + 1)*(0.5*s + 1));

systems = {G};

for c = cs
    systems{end+1} = (-s+c)/(c*(s+1)*(0.5*s+1));
end

f1=figure(1);
set(f1,'position',[1   462   504   343])
set(f1,'name','question 3.2.1, Bode Plot');


bode(systems{:});
legend('G', 'c=-10', 'c=-0.25', 'c=-0.1', 'c=0.1', 'c=0.25', 'c=10')
grid on

f2=figure(2);
set(f1,'position',[1   462   504   343])
set(f1,'name','question 3.2.1, Bode Plot - normal, alpha = +10, alpha = -10');
bode(systems{1}, systems{2}, systems{7});

legend('G', 'c=-10', 'c=10')
grid on

f3=figure(3);
set(f1,'position',[1   462   504   343])
set(f1,'name','question 3.2.1, Bode Plot - normal, alpha = +0.25, alpha = -0.25');
bode(systems{1}, systems{3}, systems{6});

legend('G', 'c=-0.25', 'c=0.25')
grid on

f4=figure(4);
set(f1,'position',[1   462   504   343])
set(f1,'name','question 3.2.1, Bode Plot - normal, alpha = +0.1, alpha = -0.1');
bode(systems{1}, systems{4}, systems{5});

legend('G', 'c=-0.1', 'c=0.1')
grid on