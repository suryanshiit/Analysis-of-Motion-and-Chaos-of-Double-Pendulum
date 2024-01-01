function [ yprime ] = double_pendulum (t ,y) 
%UNTITLED Summary of this function goes here 
% Detailed explanation goes here 
yprime = zeros (4 ,1); 
m1=2;
m2=1;
L1=1;
L2=2;
g=32.0;
a = (m1+m2)*L1;
b = m2*L2*cos(y(1)-y(3));
c = m2*L1*cos(y(1)-y(3));
d = m2*L2;
e = -m2*L2*y(4)*y(4)* sin (y(1)-y(3))-g*(m1+m2)*sin (y (1));
f = m2*L1*y(2)*y(2)* sin (y(1)-y(3))-m2*g*sin (y (3));
yprime (1) = y(2); 
yprime (3) = y(4); 
yprime (2) = (e*d-b*f )/( a*d-c*b);
yprime (4) = (a*f-c*e )/( a*d-c*b);
end