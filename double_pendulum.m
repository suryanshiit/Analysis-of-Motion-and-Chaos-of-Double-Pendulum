function double_pendulum()

% Integrate the equations over from 0 to 5 seconds with 50 steps.
timeSpan = linspace(0.0, 5.0, 50);

% Set initial angles in radians and the initial speeds to zero.
initialConditions = [0.1, 0.2, 0.0, 0.0];

% Define particles' mass, pendulums' length, and the acceleration due to
% gravity.
m = 1.0;
l = 1.0;
g = 9.8;

% Integrate the equations of motion with the specified parameters.
[t, x] = double_pendulum_integrate(timeSpan, initialConditions, m, l, g);

% Plot the results.
fig1 = figure(1);
plot(t, x)
title('Double pendulum states as a function of time')
xlabel('Time [s]')
%legend('q1 [rad]')

legend('theta 1[rad]', 'theta 2 [rad]', 'w1 [rad/s]', 'w2 [rad/s]')

% Save the figure as a png.
saveas(fig1, 'double-pendulum-matlab-plot.png', 'png')

function [t, x] = double_pendulum_integrate(timeSpan, initialConditions, m, l, g)
% m : double
%   The mass of each particle.
% l : double
%   Length of each link.
% g : double
%   Acceleratoin due to gravity.
f = @(t, x) state_derivatives(t, x, m, l, g);

% Integrate the equations of motion with default integration settings.
[t, x] = ode45(f, timeSpan, initialConditions);

function xd = state_derivatives(t, x, m, l, g)
%function xd = state_derivatives(t, x, m, l, g)

q1 = x(1);
q2 = x(2);
u1 = x(3);
u2 = x(4);

% Initialize a vector for the derivatives.
xd = zeros(4, 1);
xd(1) = u1;
xd(2) = u2;
xd(3) = (-g * sin(q1) * sin(q2)^2 + 2 * g * sin(q1) - g * sin(q2) * ...
    cos(q1) * cos(q2) + 2 * l * u1^2 * sin(q1) * cos(q1) * ...
    cos(q2)^2 - l * u1^2 * sin(q1) * cos(q1) - 2 * l * u1^2 * ...
    sin(q2) * cos(q1)^2 * cos(q2) + l * u1^2 * sin(q2) * cos(q2) + ...
    l * u2^2 * sin(q1) * cos(q2) - l * u2^2 * sin(q2) * cos(q1)) / ...
    (l * (sin(q1)^2 * sin(q2)^2 + 2 * sin(q1) * sin(q2) * cos(q1) * ...
    cos(q2) + cos(q1)^2 * cos(q2)^2 - 2));
xd(4) = (-sin(q1) * sin(q2) / 2 - cos(q1) * cos(q2) / 2) * (2 * g * ...
    l * m * sin(q1) - l^2 * m * (-sin(q1) * cos(q2) + sin(q2) * ...
    cos(q1)) * u2^2) / (l^2 * m * (sin(q1) * sin(q2) / 2 + cos(q1) * ...
    cos(q2) / 2) * (sin(q1) * sin(q2) + cos(q1) * cos(q2)) - l^2 * m) + ...
    (g * l * m * sin(q2) - l^2 * m * (sin(q1) * cos(q2) - sin(q2) * ...
    cos(q1)) * u1^2) / (l^2 * m * (sin(q1) * sin(q2) / 2 + cos(q1) * ...
    cos(q2) / 2) * (sin(q1) * sin(q2) + cos(q1) * cos(q2)) - l^2 * m);