function [success,collision,loss_hist,x_hist,y_hist,reward_hist,actor_n,critic_n,s_hist,u_now_hist] = simulateepisode( ...
    actor_n,critic_n,N,dt,L,start,goal,obstacles, ...
    steering_max,throttle_max,v_min,v_max,noise_now, ...
    distancescale,velocityscale,gamma,lr_actor,lr_critic,lr_imitation, ...
    reward_progress,negative_progress_cost,cost_dist_next,cost_heading_error, ...
    cost_steer,reward_speed,obstacle_cost,goal_reward,collision_penalty, ...
    goaltolerance,collisionmargin,ep,episodes,mode,controllerpercent,idx_start_goal,ray_max,minim_Ray,minim_front_Ray)

x = zeros(N+1,1); y = zeros(N+1,1); theta = zeros(N+1,1); v = zeros(N+1,1);
x(1)=start(1); y(1)=start(2); v(1)=0.8;

if idx_start_goal==1
    theta(1)=0;
else
    theta(1)=pi;
end



xf(1) = x(1) +  L*cos(theta(1));% x  is at forward position of car (front weel (centerr)
yf(1) = y(1) +  L*sin(theta(1));


x_hist = zeros(1,N+1); y_hist = zeros(1,N+1); reward_hist = zeros(1,N); loss_hist = zeros(1,N);
success = false; collision = false;

for k = 1:N
    s = getstate(xf(k),yf(k),theta(k),v(k),goal,distancescale,velocityscale,obstacles,ray_max);
    uRL = actor(actor_n,s,steering_max,throttle_max);
    uGuide = guideController(xf(k),yf(k),theta(k),v(k),goal,obstacles,steering_max,throttle_max);

    if mode == "IMITATION"
        uchosen = uGuide;

        actor_n = train_actor_imitation(actor_n,s,uGuide,steering_max,throttle_max,lr_imitation);

    elseif mode == "HYBRID_RL" || mode == "EVAL_HYBRID" || mode == "TEST_HYBRID"

        %hybridmode
        uchosen = controllerpercent*uGuide + (1-controllerpercent)*uRL;

        
        if mode == "HYBRID_RL"  
            imitation_weight = max(0.25,controllerpercent);
            actor_n = train_actor_imitation(actor_n,s,uGuide,steering_max,throttle_max,imitation_weight*lr_imitation);
        end



    end

    steer = clamp(uchosen(1) + noise_now*randn,-steering_max,steering_max);
    throttle = clamp(uchosen(2) + noise_now*randn,-throttle_max,throttle_max);



    x(k+1) = x(k)  + v(k)*cos(theta(k))*dt;
    y(k+1) = y(k)  + v(k)*sin(theta(k))*dt;
    theta(k+1) = wrapToPi(theta(k) + (v(k)/L)*tan(steer)*dt);
    v(k+1) = clamp(v(k) + throttle*dt,v_min,v_max);

    xf(k) = x(k) +  L*cos(theta(k));
    yf(k) = y(k) +  L*sin(theta(k));

    xf(k+1) = x(k+1) +  L*cos(theta(k+1));
    yf(k+1) = y(k+1) +  L*sin(theta(k+1));


    if norm([xf(k+1);yf(k+1)] - goal) < 6
        v(k+1) = min(v(k+1),0.45);
    end

    s_next = getstate(xf(k+1),yf(k+1),theta(k+1),v(k+1),goal,distancescale,velocityscale,obstacles,ray_max);
    u_now = [steer; throttle];


    r = rewardFunction(u_now,s_next,s,distancescale,velocityscale,reward_progress,negative_progress_cost,cost_dist_next,cost_heading_error,cost_steer,reward_speed,obstacle_cost,ray_max,minim_Ray,minim_front_Ray);
    done = false;
    distgoal = norm([xf(k+1);yf(k+1)] - goal);
    clearance = point_obstacle_clearance(xf(k+1),yf(k+1),obstacles);


    if distgoal < goaltolerance
        r = goal_reward; success = true; done = true;


    end
    if clearance < collisionmargin
        r = collision_penalty; collision = true; done = true;


    end

    % rTrain = clamp(r/20,-80,120);
    r_train = clamp(r/300,-25,25);

   
    uRL_next = actor(actor_n,s_next,steering_max,throttle_max);
    uGuide_next = guideController(xf(k+1),yf(k+1),theta(k+1),v(k+1),goal,obstacles,steering_max,throttle_max);
    u_next = controllerpercent*uGuide_next + (1-controllerpercent)*uRL_next;

    loss = 0;
    if  mode == "HYBRID_RL"

        [critic_n,loss] = train_critic(critic_n,s,u_now,r_train,s_next,u_next,done,gamma,lr_critic);
    end

    if ~done && mode == "HYBRID_RL"  && clearance > 2.0
        actor_n = train_actor_RL(actor_n,critic_n,s,uGuide,controllerpercent,steering_max,throttle_max,lr_actor);
    end

    x_hist(k)=xf(k);
    y_hist(k)=yf(k);
    reward_hist(k)=r_train;
    loss_hist(k)=loss;
  
    s_hist(k,:)=s;
    u_now_hist(:,k)=u_now;

    if done
        x_hist(k+1)=xf(k+1);
        y_hist(k+1)=yf(k+1);
        x_hist = x_hist(1:k+1);
        y_hist = y_hist(1:k+1);
        reward_hist = reward_hist(1:k);
        loss_hist  = loss_hist(1:k);

        % s_hist(k+1,:)=s(k+1,:);
        % u_now_hist(:,k+1)=u_now(:,k+1);
        % s_hist = s_hist(1:k+1,:);
        % u_now_hist =  u_now_hist(:,1:k+1);
        break;
    end
    if k==N
        x_hist(k+1)=xf(k+1); 
        y_hist(k+1)=yf(k+1);

    end
end
end

