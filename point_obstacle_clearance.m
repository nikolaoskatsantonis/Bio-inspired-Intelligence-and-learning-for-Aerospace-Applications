function clearance = point_obstacle_clearance(x,y,obstacles)
clearance = inf;
for j = 1:size(obstacles,1)
    cx = obstacles(j,1); cy = obstacles(j,2); r = obstacles(j,3);
    clearance = min(clearance,sqrt((x-cx)^2 + (y-cy)^2) - r);
end
end