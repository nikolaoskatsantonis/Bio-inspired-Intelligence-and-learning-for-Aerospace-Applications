function r = rewardFunction(u_now,s_next,s_prev,distancescale,velocityscale,reward_progress,negative_progress_cost,cost_dist_next,cost_heading_error,cost_steer,reward_speed,obstacle_cost,ray_max,minim_Ray,minim_front_Ray)
dist_prev = s_prev(1)*distancescale;
dist_next = s_next(1)*distancescale;
heading_error = s_next(2);
v = s_next(3)*velocityscale;
rays = s_next(4:end)*ray_max;
frontRay = rays(4);
minRay = min(rays);
progress = dist_prev - dist_next;
r = 0;
% alignmentBonus = 50*cos(pi*heading_error);
% if minRay < 10, r = r - Obstacle_cost*(10-minRay)^2; end
% if frontRay < 12, r = r - 1.5*Obstacle_cost*(12-frontRay)^2; end
if minRay < minim_Ray
    r = r - obstacle_cost*(minim_Ray-minRay)^2;
end
if frontRay < minim_front_Ray
    r = r - 1.5*obstacle_cost*(minim_front_Ray-frontRay)^2;
end
% nearGoalBonus = 80/(1+dist_next);
r = r + reward_progress*progress + reward_speed*v - cost_dist_next*dist_next - cost_heading_error*abs(heading_error) - cost_steer*(abs(u_now(1))^2);% + alignmentBonus + nearGoalBonus;
if progress < 0
    r = r - negative_progress_cost*abs(progress);
end
if dist_next > 5 && v < 0.2
    r = r - 30;
end

end