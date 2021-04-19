clc
clear
close all

%% init
q0 = [1;0;0;0];
dt = 1e-2;


%% plotting
x0 = [1;0;0];
y0 = [0;1;0];
z0 = [0;0;1];
q = q0;
figure
hold on
grid on
view(60, 30)

%% timeseries
for t = 0:dt:10
    w = [randn()*0.02; t/10 + randn()*0.02; sin(t/20) + randn()*0.02];
    
%% RK-4 scheme
    wq = [0;w]; % w vect to quat form
    k1 = 1/2 * quatMultiply(q, wq);
    k2 = 1/2 * quatMultiply(q+k1*dt/2, wq);
    k3 = 1/2 * quatMultiply(q+k2*dt/2, wq);
    k4 = 1/2 * quatMultiply(q+k3*dt, wq);
    q = q + dt/6 * (k1 + 2 * k2 + 2 * k3 + k4);
    q = q / norm(q);
    
%% plotting    
    x = quatRotate(q, x0);
    y = quatRotate(q, y0);
    z = quatRotate(q, z0);
    
    xplot = plot3([0 x(1)], [0 x(2)], [0 x(3)], 'r');
    yplot = plot3([0 y(1)], [0 y(2)], [0 y(3)], 'g');
    zplot = plot3([0 z(1)], [0 z(2)], [0 z(3)], 'b');
    
    xlim([-2 2])
    ylim([-2 2])
    zlim([-2 2])

    pause(dt)
    delete(xplot)
    delete(yplot)
    delete(zplot)

end