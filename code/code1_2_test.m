%parameters
a=100;
b=10;
c=2.5;
d=0.0082;
%func1
x1 = linspace(0, 0.1, 1000);
y1 = x1 .* (exp(-b*x1) .^c);
%func2 continuous
%{
x2 = linspace(0.1, 0.45, 1000);
y2 = x2 .* (exp(-b*x2) .^c);
%}
%func2
x2 = linspace(0.1, 0.45, 1000);
dd = linspace(d, d, 1000);
y2 = dd;
%func3
x3 = linspace(0.45, 0.6, 1000);
y3 = (x3-0.35) .* (exp(-b*(x3-0.35)) .^c);

%combination
x=[x1 x2 x3];
y=a*[y1 y2 y3];
%plot
figure;
plot(x, y);
xlabel('x');
ylabel('y');
title('Plot of envelop function');

grid on;