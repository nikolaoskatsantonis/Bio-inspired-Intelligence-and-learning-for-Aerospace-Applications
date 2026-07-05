function [score,totalsuccess,totalcollision,save_collision] = evaluate_actor_all_mazes(actor_n,critic_n,mazes,N,dt,L,start_all,goal_all, ...
    steering_max,throttle_max,v_min,v_max,distancescale,velocityscale,gamma, ...
    reward_progress,negative_progress_cost,cost_dist_next,cost_heading_error, ...
    cost_steer,reward_speed,obstacle_cost,goal_reward,collision_penalty, ...
    goaltolerance,collisionmargin,test_controller_percent,ray_max,minim_Ray,minim_front_Ray)

score = 0;
totalsuccess = 0;
totalcollision = 0;

for mid = 1:length(mazes)

    for idx_start_goal = 1:2

        start = start_all(:,idx_start_goal);
        goal  = goal_all(:,idx_start_goal);

        obstacles = mazes{mid};
        [success,collision,~,x_hist,y_hist,~,~,~] = simulateepisode( ...
            actor_n,critic_n,N,dt,L,start,goal,obstacles, ...
            steering_max,throttle_max,v_min,v_max,0, ...
            distancescale,velocityscale,gamma,0,0,0, ...
            reward_progress,negative_progress_cost,cost_dist_next,cost_heading_error, ...
            cost_steer,reward_speed,obstacle_cost,goal_reward,collision_penalty, ...
            goaltolerance,collisionmargin,0,0,"EVAL_HYBRID",test_controller_percent,idx_start_goal,ray_max,minim_Ray,minim_front_Ray);

        finaldistance = norm([x_hist(end); y_hist(end)] - goal);
        totalsuccess = totalsuccess + success;
        totalcollision = totalcollision + collision;
        % score = score + 3*finalDistance + 3000*collision - 4000*success;
        score = score + 3*finaldistance + 12000*collision - 5000*success;

        if collision==1
            save_collision(mid,idx_start_goal)=1;

        else
            save_collision(mid,idx_start_goal)=NaN;

        end


    end
end
end