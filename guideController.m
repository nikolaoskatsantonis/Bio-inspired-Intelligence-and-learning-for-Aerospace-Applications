function u = guideController(x,y,theta,v,goal,obstacles,steering_max,throttle_max)
% I use a guide controller to tell where obstacles are to avoid it and then
% RL manages the amplitude of those gains.
vec = goal - [x;y];
goal = atan2(vec(2),vec(1));

%% Repulsive field
rep = [0;0];
influence = 12;   % radius around each obstacle where the obstacle generates a repulsive force.

for j = 1:size(obstacles,1)

    c = obstacles(j,1:2)';
    r = obstacles(j,3);

    dvec = [x;y] - c;
    d = norm(dvec) - r; %Vol de oiseaux between car and obstacle

    if d < influence %Influence: only react if obstacle is close enough.

        dir = dvec/(norm(dvec)+1e-6); % I normalise the vector to a vector length of 1 at most, I add a tiny number to prevent division by zero

        gain = (1/max(d,0.3) - 1/influence)/(max(d,0.3)^2);

        rep = rep + dir*gain;%Push away from obstacles,% Repulsion force

          %far obstacle → tiny force
        %close obstacle → HUGE force
        %rep is a force vector with x and y components

    end
end

%% Attractive + repulsive
goal_v = [cos(goal); sin(goal)];

desired_v = 6*goal_v + 30*rep;   % All are normalised to 1 (the angle is an angle from 0-1 as always and rep is normialised to 1

desired_angle = atan2(desired_v(2),desired_v(1));

heading_err = wrapToPi(desired_angle - theta);

steer = clamp(2.0*heading_err,...     % I turn the car towards desired direction
              -steering_max,...
               steering_max);

%% Speed control
distgoal = norm(vec);

if distgoal < 4
    throttle = 0.3*throttle_max;
else
    throttle = 0.8*throttle_max;
end

if abs(heading_err) > 0.8      
    throttle = 0.3*throttle_max;
end

u = [steer; throttle];

end