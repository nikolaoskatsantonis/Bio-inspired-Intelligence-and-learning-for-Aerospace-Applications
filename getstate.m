function s = getstate(x,y,theta,v,goal,distancescale,velocityscale,obstacles,ray_max)
dx = goal(1)-x; dy = goal(2)-y;
distance = sqrt(dx^2 + dy^2);
angle_to_goal = atan2(dy,dx);
heading_error = wrapToPi(angle_to_goal - theta); %  radians
rays = [-pi/2, -pi/3, -pi/6, 0, pi/6, pi/3, pi/2];
raydistance = zeros(7,1);
for i = 1:7
    raydistance(i) = raycircledistance(x,y,theta + rays(i),obstacles,ray_max);
end
s = [distance/distancescale; heading_error/pi; v/velocityscale; raydistance(:)/ray_max];
end