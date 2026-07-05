function distance_ray = raycircledistance(x,y,ray_theta,obstacles,ray_max)
distance_ray = ray_max; dir = [cos(ray_theta); sin(ray_theta)];
for j = 1:size(obstacles,1)
    cx = obstacles(j,1); cy = obstacles(j,2); r = obstacles(j,3);
    b = 2*((x - cx)*dir(1) + (y - cy)*dir(2));
    c = (x - cx)^2 + (y - cy)^2 - r^2;
    delta = b^2 - 4*c;
    if delta >= 0
        delta1 = (-b - sqrt(delta))/2; delta2 = (-b + sqrt(delta))/2;
        roots = [delta1 delta2]; roots = roots(roots > 0);
        if ~isempty(roots), distance_ray = min(distance_ray, min(roots)); end
    end
end
distance_ray = min(distance_ray,ray_max);
end