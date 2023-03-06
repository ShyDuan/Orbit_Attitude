figure;
set(gcf, 'color', 'w', 'name', 'Animation of the tossed book');
axis equal;
L=6400;
dr=2000;
xlim([-L-dr, L+dr]);
ylim([-L-dr, L+dr]);
zlim([-L-dr, L+dr]);
xlabel('\itx (m)'); 
ylabel('\ity (m)'); 
zlabel('\itz (m)         ', 'rotation', 0);
view([135 30]);
grid on;
[x y z]=sphere();
mesh(L*x,L*y,L*z)
axis equal


h = animatedline;
point = line(out.Orbit_dynamics(1,1),out.Orbit_dynamics(1,2),out.Orbit_dynamics(1,3), 'marker', 'o', 'markerfacecolor', 'b');
for i = 1:5:size(out.tout,1)

set(point, 'xdata', out.Orbit_dynamics(i,1), 'ydata', out.Orbit_dynamics(i,2), 'zdata', out.Orbit_dynamics(i,3));
    addpoints(h,out.Orbit_dynamics(i,1),out.Orbit_dynamics(i,2),out.Orbit_dynamics(i,3));


    
    drawnow limitrate;
%     drawnow ;
%     writeVideo(video_w, getframe(gcf));

end