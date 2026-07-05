clear all; clc; close all; clear;

for i_sense=1:13

i_sense   
close all
clearvars -except ...
    save_i_sense_Succ_coilis_episode_id ...
    save_i_sense_plot_success ...
    save_i_sense_plot_collision ...
    save_i_sense_reward_hist ...
    save_i_sense_x_hist ...
    save_i_sense_y_hist ...
    save_i_sense_start ...
    save_i_sense_goal ...
    save_i_sense_obstacles ...
    i_sense
%%%%%%%%%%%%%%%%%%% simulation settinggs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dt = 0.2;
episodes = 15000;
N = 1000;
mazelist = [1 2 3 4 ]; %I increase training for maze 4 and 5 to get better results


if i_sense== 1    %% NOISE SENSITIVITY

    noise_std = 0.4;  % 40 percent
    pretrainepisodes = 5000;             % imitation only

    actor_hidden_layer_size = 32;
    critic_hidden_layer_size = 64;

    goal_reward = 8000;
    collision_penalty = -8000;
    gamma = 0.95;

    lr_imitation = 1e-3;
    lr_critic    = 0.5e-6;
    lr_actor     = lr_critic*0.5;% 5e-6;

    minim_front_Ray=10;
    minim_Ray=8;

elseif i_sense==2 %% NOISE SENSITIVITY
    noise_std = 0.1; % 10 percent
    pretrainepisodes = 5000;             % imitation only

    actor_hidden_layer_size = 32;
    critic_hidden_layer_size = 64;

    goal_reward = 8000;
    collision_penalty = -8000;
    gamma = 0.95;

    lr_imitation = 1e-3;
    lr_critic    = 0.5e-6;
    lr_actor     = lr_critic*0.5;% 5e-6;

    minim_front_Ray=10;
    minim_Ray=8;

elseif i_sense==3 %% GUIDE SENSITIVITY

    noise_std = 0.01; %Currently 1 percent
    pretrainepisodes = 1000;             % imitation only

    actor_hidden_layer_size = 32;
    critic_hidden_layer_size = 64;

    goal_reward = 8000;
    collision_penalty = -8000;
    gamma = 0.95;

    lr_imitation = 1e-3;
    lr_critic    = 0.5e-6;
    lr_actor     = lr_critic*0.5;% 5e-6;

    minim_front_Ray=10;
    minim_Ray=8;

elseif i_sense==4 %% GUIDE SENSITIVITY
    noise_std = 0.01; %Currently 1 percent
    pretrainepisodes = 8000;             % imitation only

    actor_hidden_layer_size = 32;
    critic_hidden_layer_size = 64;

    goal_reward = 8000;
    collision_penalty = -8000;
    gamma = 0.95;

    lr_imitation = 1e-3;
    lr_critic    = 0.5e-6;
    lr_actor     = lr_critic*0.5;% 5e-6;

    minim_front_Ray=10;
    minim_Ray=8;

elseif i_sense==5 %% REWARD SENSITIVITY
    noise_std = 0.01; %Currently 1 percent
    pretrainepisodes = 5000;             % imitation only

    actor_hidden_layer_size = 32;
    critic_hidden_layer_size = 64;

    goal_reward = 4000;
    collision_penalty = -12000;
    gamma = 0.95;

    lr_imitation = 1e-3;
    lr_critic    = 0.5e-6;
    lr_actor     = lr_critic*0.5;% 5e-6;

    minim_front_Ray=10;
    minim_Ray=8;

elseif i_sense==6 %% REWARD SENSITIVITY
    noise_std = 0.01; %Currently 1 percent
    pretrainepisodes = 5000;             % imitation only

    actor_hidden_layer_size = 32;
    critic_hidden_layer_size = 64;

    goal_reward = 12000;
    collision_penalty = -4000;
    gamma = 0.95;

    lr_imitation = 1e-3;
    lr_critic    = 0.5e-6; %5e-7
    lr_actor     = lr_critic*0.5;% 5e-6;

    minim_front_Ray=10;
    minim_Ray=8;

elseif i_sense==7 %% LEARNING RATE
    noise_std = 0.01; %Currently 1 percent
    pretrainepisodes = 5000;             % imitation only

    actor_hidden_layer_size = 32;
    critic_hidden_layer_size = 64;

    goal_reward = 8000;
    collision_penalty = -8000;
    gamma = 0.95;

    lr_imitation = 1e-4;  % I tried sensitivity:  1e-4;
    lr_critic    = 5e-7; % I tried sensitivity:  5e-6;;
    lr_actor     = lr_critic*0.5;% 5e-6;

    minim_front_Ray=10;
    minim_Ray=8;

elseif i_sense==8 %% LEARNING RATE
    noise_std = 0.01; %Currently 1 percent
    pretrainepisodes = 5000;             % imitation only

    actor_hidden_layer_size = 32;
    critic_hidden_layer_size = 64;

    goal_reward = 8000;
    collision_penalty = -8000;
    gamma = 0.95;

    lr_imitation = 1e-4;  % I tried sensitivity:  1e-4;
    lr_critic    = 1e-6;  % I tried sensitivity:  1e-5;;
    lr_actor     = lr_critic*0.5;% 5e-6;

    minim_front_Ray=10;
    minim_Ray=8;

elseif i_sense==9 %% RAY SENSITIVITY, 50 percent less FOV
    noise_std = 0.01; %Currently 1 percent
    pretrainepisodes = 5000;             % imitation only

    actor_hidden_layer_size = 32;
    critic_hidden_layer_size = 64;

    goal_reward = 8000;
    collision_penalty = -8000;
    gamma = 0.95;

    lr_imitation = 1e-3;
    lr_critic    = 0.5e-6;
    lr_actor     = lr_critic*0.5;% 5e-6;

    minim_front_Ray=5;
    minim_Ray=4;

elseif i_sense==10 %% RAY SENSITIVITY , 50 percent more FOV
    noise_std = 0.01; %Currently 1 percent
    pretrainepisodes = 5000;             % imitation only

    actor_hidden_layer_size = 32;
    critic_hidden_layer_size = 64;

    goal_reward = 8000;
    collision_penalty = -8000;
    gamma = 0.95;

    lr_imitation = 1e-3;
    lr_critic    = 0.5e-6;
    lr_actor     = lr_critic*0.5;% 5e-6;

    minim_front_Ray=15;
    minim_Ray=12;

elseif i_sense==11 %% NN SENSITIVITY
    noise_std = 0.01; %Currently 1 percent
    pretrainepisodes = 5000;             % imitation only

    actor_hidden_layer_size = 16;
    critic_hidden_layer_size = 32;

    goal_reward = 8000;
    collision_penalty = -8000;
    gamma = 0.95;

    lr_imitation = 1e-3;
    lr_critic    = 0.5e-6;
    lr_actor     = lr_critic*0.5;% 5e-6;

    minim_front_Ray=10;
    minim_Ray=8;

elseif i_sense==12 %% NN SENSITIVITY
    noise_std = 0.01; %Currently 1 percent
    pretrainepisodes = 5000;             % imitation only

    actor_hidden_layer_size = 64;
    critic_hidden_layer_size = 128;

    goal_reward = 8000;
    collision_penalty = -8000;
    gamma = 0.95;

    lr_imitation = 1e-3;
    lr_critic    = 0.5e-6;
    lr_actor     = lr_critic*0.5;% 5e-6;

    minim_front_Ray=10;
    minim_Ray=8;


elseif i_sense==13 %% GAMMA sensititivity
    noise_std = 0.01; %Currently 1 percent
    pretrainepisodes = 5000;             % imitation only

    actor_hidden_layer_size = 32;
    critic_hidden_layer_size = 64;

    goal_reward = 8000;
    collision_penalty = -8000;
    gamma = 0.5;

    lr_imitation = 1e-3;
    lr_critic    = 0.5e-6;
    lr_actor     = lr_critic*0.5;% 5e-6;

    minim_front_Ray=10;
    minim_Ray=8;


end


 
    




hybridepisodes   = episodes - pretrainepisodes;  %hybrid

controller_output_percentage_end = 0;
test_controller_percent = controller_output_percentage_end;  % thefinal test is actor only





L = 2;


steering_max = 1;
throttle_max = 1;
v_min = 0.15;
v_max = 1;

goal1 = [50; -25];
goal2 = [0; 0];

start1 = [0; 0];
start2 = [50; -25];

start_all=[start1,start2];
goal_all=[goal1,goal2];


goaltolerance = 2.5;
collisionmargin = 1;


distancescale = 70;
velocityscale = v_max;

reward_progress = 250;
negative_progress_cost = 350;
cost_dist_next = 3;
cost_heading_error = 12;
cost_steer = 0.4;
reward_speed = 0.2;

obstacle_cost = 120;

ray_max = 35;

nstate = 10;
naction = 2;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% neural netwrok%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[mazes,testmazes] = mazesmade();

actor_n.W1 = 0.1*randn(actor_hidden_layer_size,nstate);
actor_n.b1 = zeros(actor_hidden_layer_size,1);
actor_n.W2 = 0.1*randn(actor_hidden_layer_size,actor_hidden_layer_size);
actor_n.b2 = zeros(actor_hidden_layer_size,1);
actor_n.W3 = 0.05*randn(naction,actor_hidden_layer_size);
actor_n.b3 = zeros(naction,1);

critic_n.W1 = 0.1*randn(critic_hidden_layer_size,nstate+naction);
critic_n.b1 = zeros(critic_hidden_layer_size,1);
critic_n.W2 = 0.1*randn(critic_hidden_layer_size,critic_hidden_layer_size);
critic_n.b2 = zeros(critic_hidden_layer_size,1);
critic_n.W3 = 0.1*randn(1,critic_hidden_layer_size);
critic_n.b3 = 0;

bestactor_n = actor_n;
bestscore = inf;
meanreward = zeros(episodes,1);
meanLoss = zeros(episodes,1);
finaldistance_hist = zeros(episodes,1);
controllerpercent_hist = zeros(episodes,1);

%% TRAINING
fprintf('Training started. Hybrid controller fades to 0%%.');
iter_eval=0;

for ep = 1:episodes

  

    maze_id = mazelist(randi(numel(mazelist)));

    obstacles = mazes{maze_id};

    idx_start_goal= randi(2);
    goal=goal_all(:,idx_start_goal);
    start=start_all(:,idx_start_goal);


    noise_now = max(0.001, noise_std*(0.9995^ep));

    if ep <= pretrainepisodes
        mode = "IMITATION";
        controllerpercent = 1.00;
    else
        mode = "HYBRID_RL";
        hybridprogress = (ep - pretrainepisodes)/max(1,hybridepisodes);
        controllerpercent = max(controller_output_percentage_end, 1.00 - 1.00*hybridprogress);  % from 100% down to 0%
    end
    controllerpercent_hist(ep) = controllerpercent;

    [success,collision,loss_hist,x_hist,y_hist,reward_hist,actor_n,critic_n,s_hist,u_now_hist] = simulateepisode( ...
        actor_n,critic_n,N,dt,L,start,goal,obstacles, ...
        steering_max,throttle_max,v_min,v_max,noise_now, ...
        distancescale,velocityscale,gamma,lr_actor,lr_critic,lr_imitation, ...
        reward_progress,negative_progress_cost,cost_dist_next,cost_heading_error, ...
        cost_steer,reward_speed,obstacle_cost,goal_reward,collision_penalty, ...
        goaltolerance,collisionmargin,ep,episodes,mode,controllerpercent,idx_start_goal,ray_max,minim_Ray,minim_front_Ray);

    finaldistance = norm([x_hist(end); y_hist(end)] - goal);
    finaldistance_hist(ep) = finaldistance;
    meanreward(ep) = mean(reward_hist);
    meanLoss(ep) = mean(loss_hist);


    % Save best actor using actor only evaluation on ALL!! mazes!.

    %% Here we print after every 50 episodes, could lower it but computationally very expensive
    if ep > pretrainepisodes && (mod(ep,50)==0 || ep==episodes) %%&& controllerPercent <= 0.35
        [evalscore,evalsuccess,evalcollision,save_collision] = evaluate_actor_all_mazes(actor_n,critic_n,mazes,N,dt,L,start_all,goal_all, ...
            steering_max,throttle_max,v_min,v_max,distancescale,velocityscale,gamma, ...
            reward_progress,negative_progress_cost,cost_dist_next,cost_heading_error, ...
            cost_steer,reward_speed,obstacle_cost,goal_reward,collision_penalty, ...
            goaltolerance,collisionmargin,test_controller_percent,ray_max,minim_Ray,minim_front_Ray);



        if evalscore < bestscore
            iter_eval=iter_eval+1;

            plot_success(iter_eval)=evalsuccess;
            plot_collision(iter_eval)=evalcollision;
            store_at_what_ep(iter_eval)=ep;

            bestscore = evalscore;
            bestactor_n = actor_n;
           
            fprintf('NEW BEST for all mazes! Hybrid evaluation: Successes %d/8 , Colisions %d/8 , Score %.3f\n', ...
                evalsuccess,evalcollision,evalscore);
            save_collision


        end
    end


    if mod(ep,200)==0 || ep==1
        if maze_id==1
            figure(11);
            hold on;
            axis equal;


            

            if idx_start_goal==1
            LL1=  plot(x_hist,y_hist,'b-','LineWidth',1.3);
                plot(x_hist(1:10:end),y_hist(1:10:end),'bs');
            OL1=plot(start(1),start(2),'bo','MarkerSize',12,'LineWidth',2);
            OL2= plot(goal(1),goal(2),'bx','MarkerSize',12,'LineWidth',2);
            else
            LL2=  plot(x_hist,y_hist,'k-','LineWidth',1.3);
                plot(x_hist(1:10:end),y_hist(1:10:end),'ks');
            OL1=plot(start(1),start(2),'ko','MarkerSize',12,'LineWidth',2);
            OL2= plot(goal(1),goal(2),'kx','MarkerSize',12,'LineWidth',2);
            end

            th = linspace(0,2*pi,100);
            for j = 1:size(obstacles,1)
                fill(obstacles(j,1)+obstacles(j,3)*cos(th), obstacles(j,2)+obstacles(j,3)*sin(th),'r');
            end
 

            if exist('LL1','var') && exist('LL2','var')
            legend([OL1 OL2 LL1 LL2], {'START','GOAL','Path 1','Path 2'}, 'Location','northeast');
            end

            grid on;
            xlim([-10,70])
            ylim([-30,15])
            xlabel('x [m]');
            ylabel('y [m]');
            title('Maze 1', 'FontWeight', 'bold');
            drawnow;
            fprintf('Episode %d | Mode %s | Guide %.1f%% | Reward %.3f | Loss %.3f | Distanse %.3f | Success %d | Colision %d\n', ...
                ep,mode,100*controllerpercent,meanreward(ep),meanLoss(ep),finaldistance,success,collision);
            %text(x_hist(end),y_hist(end), sprintf('%.2f', controllerpercent), 'FontSize', 10, 'Color', 'red')
            set(gca,'FontSize',12)

        elseif maze_id==2
            figure(12);
            hold on;
            axis equal;

            if idx_start_goal==1
            LL3=  plot(x_hist,y_hist,'b-','LineWidth',1.3);
                plot(x_hist(1:10:end),y_hist(1:10:end),'bs');
            OL3=plot(start(1),start(2),'bo','MarkerSize',12,'LineWidth',2);
            OL4= plot(goal(1),goal(2),'bx','MarkerSize',12,'LineWidth',2);
            else
            LL4=  plot(x_hist,y_hist,'k-','LineWidth',1.3);
                plot(x_hist(1:10:end),y_hist(1:10:end),'ks');
            OL3=plot(start(1),start(2),'ko','MarkerSize',12,'LineWidth',2);
            OL4= plot(goal(1),goal(2),'kx','MarkerSize',12,'LineWidth',2);
            end

            th = linspace(0,2*pi,100);
            for j = 1:size(obstacles,1)
                fill(obstacles(j,1)+obstacles(j,3)*cos(th), obstacles(j,2)+obstacles(j,3)*sin(th),'r');
            end


            if exist('LL3','var') && exist('LL4','var')
            legend([OL3 OL4 LL3 LL4], {'START','GOAL','Path 1','Path 2'}, 'Location','northeast');
            end

            grid on;
            xlim([-10,70])
            ylim([-30,15])
            xlabel('x [m]');
            ylabel('y [m]');
            title('Maze 2', 'FontWeight', 'bold');
            drawnow;
            fprintf('Episode %d | Mode %s | Guide %.1f%% | Reward %.3f | Loss %.3f | Distanse %.3f | Success %d | Colision %d\n', ...
                ep,mode,100*controllerpercent,meanreward(ep),meanLoss(ep),finaldistance,success,collision);
            %text(x_hist(end),y_hist(end), sprintf('%.2f', controllerpercent), 'FontSize', 10, 'Color', 'red')
            set(gca,'FontSize',12)

        elseif maze_id==3
            figure(13);
            hold on;
            axis equal;

            if idx_start_goal==1
            LL5=  plot(x_hist,y_hist,'b-','LineWidth',1.3);
                plot(x_hist(1:10:end),y_hist(1:10:end),'bs');
            OL5=plot(start(1),start(2),'bo','MarkerSize',12,'LineWidth',2);
            OL6= plot(goal(1),goal(2),'bx','MarkerSize',12,'LineWidth',2);
            else
            LL6=  plot(x_hist,y_hist,'k-','LineWidth',1.3);
                plot(x_hist(1:10:end),y_hist(1:10:end),'ks');
            OL5=plot(start(1),start(2),'ko','MarkerSize',12,'LineWidth',2);
            OL6= plot(goal(1),goal(2),'kx','MarkerSize',12,'LineWidth',2);
            end

            th = linspace(0,2*pi,100);
            for j = 1:size(obstacles,1)
                fill(obstacles(j,1)+obstacles(j,3)*cos(th), obstacles(j,2)+obstacles(j,3)*sin(th),'r');
            end

            if exist('LL5','var') && exist('LL6','var')
                legend([OL5 OL6 LL5 LL6], {'START','GOAL','Path 1','Path 2'}, 'Location','northeast');
            end

            grid on;
            xlim([-10,70])
            ylim([-30,15])
            xlabel('x [m]');
            ylabel('y [m]');
            title('Maze 3', 'FontWeight', 'bold');
            drawnow;
            fprintf('Episode %d | Mode %s | Guide %.1f%% | Reward %.3f | Loss %.3f | Dist %.3f | Success %d | Collision %d\n', ...
                ep,mode,100*controllerpercent,meanreward(ep),meanLoss(ep),finaldistance,success,collision);
            %text(x_hist(end),y_hist(end), sprintf('%.2f', controllerpercent), 'FontSize', 10, 'Color', 'red')
            set(gca,'FontSize',12)

        elseif maze_id==4

            figure(14);
            hold on;
            axis equal;

            if idx_start_goal==1
            LL7=  plot(x_hist,y_hist,'b-','LineWidth',1.3);
                plot(x_hist(1:10:end),y_hist(1:10:end),'bs');
            OL7=plot(start(1),start(2),'bo','MarkerSize',12,'LineWidth',2);
            OL8= plot(goal(1),goal(2),'bx','MarkerSize',12,'LineWidth',2);
            else
            LL8=  plot(x_hist,y_hist,'k-','LineWidth',1.3);
                plot(x_hist(1:10:end),y_hist(1:10:end),'ks');
            OL7=plot(start(1),start(2),'ko','MarkerSize',12,'LineWidth',2);
            OL8= plot(goal(1),goal(2),'kx','MarkerSize',12,'LineWidth',2);
            end

            th = linspace(0,2*pi,100);
            for j = 1:size(obstacles,1)
                fill(obstacles(j,1)+obstacles(j,3)*cos(th), obstacles(j,2)+obstacles(j,3)*sin(th),'r');
            end
            
            if exist('LL7','var') && exist('LL8','var')
            legend([OL7 OL8 LL7 LL8], {'START','GOAL','Path 1','Path 2'}, 'Location','northeast');
            end

            grid on;
            xlim([-10,70])
            ylim([-30,15])
            xlabel('x [m]');
            ylabel('y [m]');
            title('Maze 4', 'FontWeight', 'bold');
            drawnow;
            fprintf('Episode %d | Mode %s | Guide %.1f%% | Reward %.3f | Loss %.3f | Dist %.3f | Success %d | Collision %d\n', ...
                ep,mode,100*controllerpercent,meanreward(ep),meanLoss(ep),finaldistance,success,collision);
            %text(x_hist(end),y_hist(end), sprintf('%.2f', controllerpercent), 'FontSize', 10, 'Color', 'red')
            set(gca,'FontSize',12)


        end

    end
end

% close all
%exportgraphics(figure(11), 'images/Maze1_iter.png');
%exportgraphics(figure(12), 'images/Maze2_iter.png');
%exportgraphics(figure(13), 'images/Maze3_iter.png');
%exportgraphics(figure(14), 'images/Maze4_iter.png');



%% TEST BEST ACTOR WITH 0% GUIDE / ACTOR ONLY
actor_n = bestactor_n;
iter_test=0;
maze_loop=0;
for maze_id = 1:length(mazes)+1
    if maze_id==5
        obstacles =     testmazes;

    else
        obstacles = mazes{maze_id};
    end

    for idx_start_goal= 1:2
        goal=goal_all(:,idx_start_goal);
        start=start_all(:,idx_start_goal);
        iter_test=iter_test+1;

        [success,collision,loss_hist,x_hist,y_hist,reward_hist,actor_n,critic_n,sHist,uHist] = simulateepisode( ...
            actor_n,critic_n,N,dt,L,start,goal,obstacles, ...
            steering_max,throttle_max,v_min,v_max,0, ...
            distancescale,velocityscale,gamma,0,0,0, ...
            reward_progress,negative_progress_cost,cost_dist_next,cost_heading_error, ...
            cost_steer,reward_speed,obstacle_cost,goal_reward,collision_penalty, ...
            goaltolerance,collisionmargin,episodes,episodes,"TEST_HYBRID",test_controller_percent,idx_start_goal,ray_max,minim_Ray,minim_front_Ray);

        figure(iter_test); clf(iter_test);
        hold on;
        axis equal;
        plot(x_hist,y_hist,'k-o','LineWidth',1.3);
        plot(goal(1),goal(2),'rx','MarkerSize',14,'LineWidth',2);
        plot(start(1),start(2),'ro','MarkerSize',14,'LineWidth',2);
        if idx_start_goal==1
            text(start(1)+1.5,start(2)+1.5,'START','Color','r','FontSize',14,'FontWeight','bold');
            text(goal(1) -7 ,goal(2)-1.5,'GOAL','Color','r','FontSize',14,'FontWeight','bold');
        else
            text(start(1) -7.5,start(2)-2,'START','Color','r','FontSize',14,'FontWeight','bold');
            text(goal(1)+1.5 ,goal(2)+1.5,'GOAL','Color','r','FontSize',14,'FontWeight','bold');

        end

        th = linspace(0,2*pi,100);
        for j = 1:size(obstacles,1)
            fill(obstacles(j,1)+obstacles(j,3)*cos(th), obstacles(j,2)+obstacles(j,3)*sin(th),'r');
        end
        grid on;

        xlabel('x [m]', 'FontSize', 16, 'FontWeight', 'bold');
        ylabel('y [m]', 'FontSize', 16, 'FontWeight', 'bold');

        set(gca, 'FontSize', 14);

        %title(['Maze ',num2str(maze_id)']);
        %exportgraphics(figure(iter_test), sprintf('images/Maze%d_Results.png', iter_test));


        figure(30+iter_test); clf(30+iter_test);
        set(gcf,'Position',[100 100 1000 850]);

        subplot(3,1,1)
        hold on
        plot(1:length(sHist(:,1)),distancescale.*sHist(:,1),'k-','LineWidth',1.4);
        plot(1:length(sHist(:,2)),((180/pi).*pi).*sHist(:,2),'r--','LineWidth',1.4);
        plot(1:length(uHist(1,:)),(180/pi).*uHist(1,:),'b-','LineWidth',1.4);

        grid on;

        if idx_start_goal==1
            legend('Distance','Heading error','Steering','Location','northeast')
        else
            legend('Distance','Heading error','Steering','Location','southwest')
        end
        %title('Telemetry states and inputs', 'FontWeight', 'bold');
        xlabel('Simulation steps', 'FontWeight', 'bold');
        ylabel({'Distance [m]'; 'Heading/Steering [deg]'}, 'FontWeight','bold')
        ylim([-100,55])
        set(gca,'FontSize',14)

        subplot(3,1,2)
        hold on
        plot(1:length(sHist(:,3)),velocityscale.*sHist(:,3),'r-','LineWidth',1.4);
        plot(1:length(uHist(2,:)),uHist(2,:),'b-','LineWidth',1.4);
        grid on;
        legend('Velocity','Throttle','Location','southwest')
        %title('Telemetry throttle input and velocity state', 'FontWeight', 'bold');
        xlabel('Simulation steps', 'FontWeight', 'bold');
        ylabel({'Throttle [m/s^2]'; 'Velocity [m/s]'}, 'FontWeight','bold')
        % legend('x','distance','heading_error','velocity','Front_obst','45_deg_obst','-45_deg_obst')
        set(gca,'FontSize',14)


        subplot(3,1,3)
        hold on
        plot(1:length(reward_hist(1:end)),reward_hist(1:end),'b-','LineWidth',1.4);
        grid on;
        %title('Reward per step', 'FontWeight', 'bold');
        xlabel('Simulation steps', 'FontWeight', 'bold');
        ylabel('Reward', 'FontWeight', 'bold');
        ylim([-28,28])
        set(gca,'FontSize',14)

        %exportgraphics(figure(30+iter_test), sprintf('images/Maze%d_telemetry.png', iter_test));

        if  maze_id > 4 %I only do sensitivity on the results, the unseen mazes
            maze_loop=maze_loop+1;
            
            i_sense_reward_hist(:,maze_loop)=NaN(N+2,1);
            i_sense_x_hist(:,maze_loop)=NaN(N+2,1);
            i_sense_y_hist(:,maze_loop)=NaN(N+2,1);

            i_sense_reward_hist(1:length(reward_hist(:)),maze_loop) =  reward_hist(:);
            i_sense_x_hist(1:length(x_hist(:)),maze_loop)  = x_hist(:);
            i_sense_y_hist(1:length(y_hist(:)),maze_loop)= y_hist(:);

            i_sense_start(:,maze_loop) = start(:);
            i_sense_goal(:,maze_loop) = goal(:);
            i_sense_obstacles(:,1:3,maze_loop) =obstacles(:,1:3);



        end

    end
end

% figure(50); clf(50);
% subplot(2,1,1)
% hold on
% plot(finaldistance_hist,'LineWidth',1.5); grid on;
% xlabel('Episode');
% ylabel('Final distance to goal');
% title('Training final distance');
%
% subplot(2,1,2)
% hold on
% plot(1:length(meanreward(:)),meanreward(1:end),'b-','LineWidth',1.4);
% grid on;
% % legend('Steer','Throttle (acceler)')
% title('Mean Reward per episode');
% legend('Mean Reward','Mean Loss')
% xlabel('Episode')
% exportgraphics(figure(50), 'images/Mean_Rewards_loss_per_iter.png');

figure(51);  clf(51);
hold on
plot(store_at_what_ep(:),(plot_success(1:end)./8).*100,'b-','LineWidth',1.6);
plot(store_at_what_ep(:),(plot_collision(1:end)./8).*100,'k-','LineWidth',1.6);
grid on;
% legend('Steer','Throttle (acceler)')
title('Success and Collision Percentage During Evaluation', 'FontWeight', 'bold');
legend('Success','Collision','Location','northwest')
xlabel('Episode', 'FontWeight', 'bold');
ylabel('Percentage [%]', 'FontWeight', 'bold');
set(gca, 'FontSize', 14);  
ylim([-1,101])
%exportgraphics(figure(51), 'images/Success_colission.png');


figure(52); clf(52);
plot(100*controllerpercent_hist,'LineWidth',2);
grid on;
xlabel('Episode', 'FontWeight', 'bold');
ylabel('Guide controller %', 'FontWeight', 'bold');
title('Guide controller fades to 0%', 'FontWeight', 'bold');
set(gca, 'FontSize', 14); 
ylim([-1,101])
%exportgraphics(figure(52), 'images/Controller_decline_slope.png');


save_i_sense_Succ_coilis_episode_id(:,i_sense)=NaN(300,1);
save_i_sense_plot_success(:,i_sense)=NaN(300,1);
save_i_sense_plot_collision(:,i_sense)=NaN(300,1);

success_senssi=(plot_success(1:end)./8).*100;
colission_senssi=(plot_collision(1:end)./8).*100;

save_i_sense_Succ_coilis_episode_id(1:length(store_at_what_ep(:)),i_sense)=store_at_what_ep(:);
save_i_sense_plot_success(1:length(success_senssi),i_sense)=success_senssi;
save_i_sense_plot_collision(1:length(colission_senssi),i_sense)=colission_senssi;


save_i_sense_reward_hist(:,:,i_sense)=i_sense_reward_hist(:,:);
save_i_sense_x_hist(:,:,i_sense)= i_sense_x_hist(:,:);
save_i_sense_y_hist(:,:,i_sense) = i_sense_y_hist(:,:);
save_i_sense_start(:,:,i_sense) = i_sense_start(:,:);
save_i_sense_goal(:,:,i_sense) = i_sense_goal(:,:);
save_i_sense_obstacles(:,1:3,:,i_sense)= i_sense_obstacles(:,:,:);


%title(sprintf('Sensitivity id: %d ', i_sense))

end

save('i_sense_results.mat', ...
    'save_i_sense_Succ_coilis_episode_id', ...
    'save_i_sense_plot_success', ...
    'save_i_sense_plot_collision', ...
    'save_i_sense_reward_hist', ...
    'save_i_sense_x_hist', ...
    'save_i_sense_y_hist', ...
    'save_i_sense_start', ...
    'save_i_sense_goal', ...
    'save_i_sense_obstacles');

iter_test=0;
LOOPA=0;
for maze_id = 1
    for idx_start_goal= 1:2
        %goal=goal_all(:,idx_start_goal);
        % start=start_all(:,idx_start_goal);
        iter_test=iter_test+1;
        LOOPA=LOOPA+1;

        figure(60+iter_test); clf(60+iter_test);
        hold on;
        axis equal;
        plot(save_i_sense_x_hist(:,LOOPA,1),save_i_sense_y_hist(:,LOOPA,1),'k-','LineWidth',1.5);
        plot(save_i_sense_x_hist(:,LOOPA,2),save_i_sense_y_hist(:,LOOPA,2),'b-','LineWidth',1.5);
        plot(save_i_sense_x_hist(:,LOOPA,5),save_i_sense_y_hist(:,LOOPA,5),'r-','LineWidth',1.5);
        plot(save_i_sense_x_hist(:,LOOPA,6),save_i_sense_y_hist(:,LOOPA,6),'m-.','LineWidth',1.5);
        plot(save_i_sense_x_hist(:,LOOPA,9),save_i_sense_y_hist(:,LOOPA,9),'g--','LineWidth',1.5);
        plot(save_i_sense_x_hist(:,LOOPA,10),save_i_sense_y_hist(:,LOOPA,10),'c--','LineWidth',1.5);
        plot(save_i_sense_x_hist(:,LOOPA,13),save_i_sense_y_hist(:,LOOPA,13),'--','Color',[0.13 0.55 0.13],'LineWidth',1.5);

        plot(save_i_sense_goal(1,LOOPA,1),save_i_sense_goal(2,LOOPA,1),'rx','MarkerSize',14,'LineWidth',2);
        plot(save_i_sense_start(1,LOOPA,1),save_i_sense_start(2,LOOPA,1),'ro','MarkerSize',14,'LineWidth',2);
        if idx_start_goal==1
            text(save_i_sense_start(1,LOOPA,1)+1.5,save_i_sense_start(2,LOOPA,1)+1.5,'START','Color','r','FontSize',14,'FontWeight','bold');
            text(save_i_sense_goal(1,LOOPA,1) -7 ,save_i_sense_goal(2,LOOPA,1)-2.5,'GOAL','Color','r','FontSize',14,'FontWeight','bold');
        else
            text(save_i_sense_start(1,LOOPA,1) -7.5,save_i_sense_start(2,LOOPA,1)-2.5,'START','Color','r','FontSize',14,'FontWeight','bold');
            text(save_i_sense_goal(1,LOOPA,1)+1.5 ,save_i_sense_goal(2,LOOPA,1)+1.5,'GOAL','Color','r','FontSize',14,'FontWeight','bold');

        end

        th = linspace(0,2*pi,100);
        for j = 1:size(save_i_sense_obstacles,1)
            fill(save_i_sense_obstacles(j,1,LOOPA,1)+save_i_sense_obstacles(j,3,LOOPA,1)*cos(th), save_i_sense_obstacles(j,2,LOOPA,1)+save_i_sense_obstacles(j,3,LOOPA,1)*sin(th),'r');
        end
        grid on;

        xlabel('x [m]', 'FontSize', 16, 'FontWeight', 'bold');
        ylabel('y [m]', 'FontSize', 16, 'FontWeight', 'bold');


        set(gca, 'FontSize', 14);   

        legend( 'Noise=40%','Noise=10%', 'Collision +50%', 'Goal +50%', 'FOV -50%', 'FOV +50%', '\gamma=0.5','Location','northeast')
        
        xlim([-6,59])
        ylim([-29,10])


        figure(62+iter_test); clf(62+iter_test);
        hold on;
        axis equal;

        plot(save_i_sense_x_hist(:,LOOPA,3),save_i_sense_y_hist(:,LOOPA,3),'k-','LineWidth',1.5);
        plot(save_i_sense_x_hist(:,LOOPA,4),save_i_sense_y_hist(:,LOOPA,4),'b-','LineWidth',1.5);
        plot(save_i_sense_x_hist(:,LOOPA,7),save_i_sense_y_hist(:,LOOPA,7),'r-','LineWidth',1.5);
        plot(save_i_sense_x_hist(:,LOOPA,8),save_i_sense_y_hist(:,LOOPA,8),'m-.','LineWidth',1.5);
        plot(save_i_sense_x_hist(:,LOOPA,11),save_i_sense_y_hist(:,LOOPA,11),'g--','LineWidth',1.5);
        plot(save_i_sense_x_hist(:,LOOPA,12),save_i_sense_y_hist(:,LOOPA,12),'c--','LineWidth',1.5);


        plot(save_i_sense_goal(1,LOOPA,1),save_i_sense_goal(2,LOOPA,1),'rx','MarkerSize',14,'LineWidth',2);
        plot(save_i_sense_start(1,LOOPA,1),save_i_sense_start(2,LOOPA,1),'ro','MarkerSize',14,'LineWidth',2);
        if idx_start_goal==1
            text(save_i_sense_start(1,LOOPA,1)+1.5,save_i_sense_start(2,LOOPA,1)+1.5,'START','Color','r','FontSize',14,'FontWeight','bold');
            text(save_i_sense_goal(1,LOOPA,1) -7 ,save_i_sense_goal(2,LOOPA,1)-2.5,'GOAL','Color','r','FontSize',14,'FontWeight','bold');
        else
            text(save_i_sense_start(1,LOOPA,1) -7.5,save_i_sense_start(2,LOOPA,1)-2.5,'START','Color','r','FontSize',14,'FontWeight','bold');
            text(save_i_sense_goal(1,LOOPA,1)+1.5 ,save_i_sense_goal(2,LOOPA,1)+1.5,'GOAL','Color','r','FontSize',14,'FontWeight','bold');

        end

        th = linspace(0,2*pi,100);
        for j = 1:size(obstacles,1)
            fill(save_i_sense_obstacles(j,1,LOOPA,1)+save_i_sense_obstacles(j,3,LOOPA,1)*cos(th), save_i_sense_obstacles(j,2,LOOPA,1)+save_i_sense_obstacles(j,3,LOOPA,1)*sin(th),'r');
        end
        grid on;

        xlabel('x [m]', 'FontSize', 16, 'FontWeight', 'bold');
        ylabel('y [m]', 'FontSize', 16, 'FontWeight', 'bold');

        set(gca, 'FontSize', 14);
        xlim([-6,59])
        ylim([-29,10])

        legend( 'Pretrain=1000','Pretrain=8000','LR_{imit} \downarrow','LR_{imit} \downarrow, LR_{critic} \uparrow','NN Weights -50%','NN Weights +100%','Location','northeast')

        %%%%%%%%%%% REWARDS SENSITIVITY %%%%%%%%%%%%%%%%%%

        figure(64+iter_test);clf(64+iter_test);
        hold on

        plot(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,1))),save_i_sense_reward_hist(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,1))),LOOPA,1),'k-','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,2))),save_i_sense_reward_hist(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,2))),LOOPA,2),'b-','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,5))),save_i_sense_reward_hist(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,5))),LOOPA,5),'r-','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,6))),save_i_sense_reward_hist(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,6))),LOOPA,6),'m-','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,9))),save_i_sense_reward_hist(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,9))),LOOPA,9),'g-','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,10))),save_i_sense_reward_hist(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,10))),LOOPA,10),'c--','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,13))),save_i_sense_reward_hist(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,13))),LOOPA,13),'--','Color',[0.13 0.55 0.13],'LineWidth',1.4);

        grid on;
        %title('Reward per step', 'FontWeight', 'bold');
        xlabel('Simulation steps', 'FontWeight', 'bold');
        ylabel('Reward', 'FontWeight', 'bold');
        ylim([-28,28])
        legend( 'Noise=40%','Noise=10%', 'Collision +50%', 'Goal +50%', 'FOV -50%', 'FOV +50%', '\gamma=0.5','Location','northwest')

        set(gca,'FontSize',14)

        figure(66+iter_test);clf(66+iter_test);
        hold on

        plot(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,3))),save_i_sense_reward_hist(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,3))),LOOPA,3),'k-','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,4))),save_i_sense_reward_hist(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,4))),LOOPA,4),'b-','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,7))),save_i_sense_reward_hist(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,7))),LOOPA,7),'r-','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,8))),save_i_sense_reward_hist(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,8))),LOOPA,8),'m-','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,11))),save_i_sense_reward_hist(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,11))),LOOPA,11),'g-','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,12))),save_i_sense_reward_hist(1:sum(~isnan(save_i_sense_reward_hist(:,LOOPA,12))),LOOPA,12),'c--','LineWidth',1.4);


        grid on;
        %title('Reward per step', 'FontWeight', 'bold');
        xlabel('Simulation steps', 'FontWeight', 'bold');
        ylabel('Reward', 'FontWeight', 'bold');
        ylim([-28,28])

        legend( 'Pretrain=1000','Pretrain=8000','LR_{imit} \downarrow','LR_{imit} \downarrow, LR_{critic} \uparrow','NN Weights -50%','NN Weights +100%','Location','northwest')

        set(gca,'FontSize',14)


        %% SUCCESSES SENSITIVITY  %%%%%%%%%%%%%%%%


        figure(69);clf(69);
        hold on



        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,1))),save_i_sense_plot_success(1:sum(~isnan(save_i_sense_plot_success(:,1))),1),'k--o','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,2))),save_i_sense_plot_success(1:sum(~isnan(save_i_sense_plot_success(:,2))),2),'b--d','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,5))),save_i_sense_plot_success(1:sum(~isnan(save_i_sense_plot_success(:,5))),5),'r--*','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,6))),save_i_sense_plot_success(1:sum(~isnan(save_i_sense_plot_success(:,6))),6),'m--x','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,9))),save_i_sense_plot_success(1:sum(~isnan(save_i_sense_plot_success(:,9))),9),'g:+','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,10))),save_i_sense_plot_success(1:sum(~isnan(save_i_sense_plot_success(:,10))),10),'c--^','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,13))),save_i_sense_plot_success(1:sum(~isnan(save_i_sense_plot_success(:,13))),13),'--h','Color',[0.49 0.18 0.56],'LineWidth',1.4);

        grid on;
        title('Sensitivity Analysis: Success Rate During Evaluation', 'FontWeight', 'bold');
        xlabel('Episode', 'FontWeight', 'bold');
        ylabel('Percentage [%]', 'FontWeight', 'bold');
        set(gca, 'FontSize', 14); 
        ylim([-1,101])
        legend( 'Noise=40%','Noise=10%', 'Collision +50%', 'Goal +50%', 'FOV -50%', 'FOV +50%', '\gamma=0.5','Location','southeast')

        %legend( 'Noise=40%','Noise=10%','Pretrain=1000','Pretrain=8000', 'Collision +50%', 'Goal +50%','LR_{imit} \downarrow','LR_{imit} \downarrow, LR_{critic} \uparrow',    'FOV -50%', 'FOV +50%','NN Weights -50%','NN Weights +100%', '\gamma=0.5','Location','southwest')
        set(gca,'FontSize',14)





        figure(70);clf(70);
        hold on



        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,3))),save_i_sense_plot_success(1:sum(~isnan(save_i_sense_plot_success(:,3))),3),'k-o','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,4))),save_i_sense_plot_success(1:sum(~isnan(save_i_sense_plot_success(:,4))),4),'b--d','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,7))),save_i_sense_plot_success(1:sum(~isnan(save_i_sense_plot_success(:,7))),7),'r-*','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,8))),save_i_sense_plot_success(1:sum(~isnan(save_i_sense_plot_success(:,8))),8),'m--x','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,11))),save_i_sense_plot_success(1:sum(~isnan(save_i_sense_plot_success(:,11))),11),'g:+','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,12))),save_i_sense_plot_success(1:sum(~isnan(save_i_sense_plot_success(:,12))),12), 'c--^','LineWidth',1.4);


        grid on;
        title('Sensitivity Analysis: Success Rate During Evaluation', 'FontWeight', 'bold');
        xlabel('Episode', 'FontWeight', 'bold');
        ylabel('Percentage [%]', 'FontWeight', 'bold');
        set(gca, 'FontSize', 14);
        ylim([-1,101])
        legend( 'Pretrain=1000','Pretrain=8000','LR_{imit} \downarrow','LR_{imit} \downarrow, LR_{critic} \uparrow','NN Weights -50%','NN Weights +100%','Location','southeast')

        %legend( 'Noise=40%','Noise=10%','Pretrain=1000','Pretrain=8000', 'Collision +50%', 'Goal +50%','LR_{imit} \downarrow','LR_{imit} \downarrow, LR_{critic} \uparrow',    'FOV -50%', 'FOV +50%','NN Weights -50%','NN Weights +100%', '\gamma=0.5','Location','southwest')
        set(gca,'FontSize',14)







        %% FAILURE SENSITIVITY %%%%%%%%%%%%%

        figure(71);clf(71);
        hold on



        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,1))),save_i_sense_plot_collision(1:sum(~isnan(save_i_sense_plot_collision(:,1))),1),'k--o','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,2))),save_i_sense_plot_collision(1:sum(~isnan(save_i_sense_plot_collision(:,2))),2),'b-d','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,5))),save_i_sense_plot_collision(1:sum(~isnan(save_i_sense_plot_collision(:,5))),5),'r-*','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,6))),save_i_sense_plot_collision(1:sum(~isnan(save_i_sense_plot_collision(:,6))),6),'m-.x','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,9))),save_i_sense_plot_collision(1:sum(~isnan(save_i_sense_plot_collision(:,9))),9),'g-.+','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,10))),save_i_sense_plot_collision(1:sum(~isnan(save_i_sense_plot_collision(:,10))),10),'c--^','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,13))),save_i_sense_plot_collision(1:sum(~isnan(save_i_sense_plot_collision(:,13))),13),'--h','Color',[0.49 0.18 0.56],'LineWidth',1.4);

        grid on;
        title('Sensitivity Analysis: Collision Rate During Evaluation', 'FontWeight', 'bold');
        xlabel('Episode', 'FontWeight', 'bold');
        ylabel('Percentage [%]', 'FontWeight', 'bold');
        set(gca, 'FontSize', 14);   % tick label size
        ylim([-1,101])
        legend( 'Noise=40%','Noise=10%', 'Collision +50%', 'Goal +50%', 'FOV -50%', 'FOV +50%', '\gamma=0.5','Location','northeast')

        %legend( 'Noise=40%','Noise=10%','Pretrain=1000','Pretrain=8000', 'Collision +50%', 'Goal +50%','LR_{imit} \downarrow','LR_{imit} \downarrow, LR_{critic} \uparrow',    'FOV -50%', 'FOV +50%','NN Weights -50%','NN Weights +100%', '\gamma=0.5','Location','southwest')
        set(gca,'FontSize',14)





        figure(72);clf(72);
        hold on



        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,3))),save_i_sense_plot_collision(1:sum(~isnan(save_i_sense_plot_collision(:,3))),3), 'k--o','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,4))),save_i_sense_plot_collision(1:sum(~isnan(save_i_sense_plot_collision(:,4))),4),'b-d','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,7))),save_i_sense_plot_collision(1:sum(~isnan(save_i_sense_plot_collision(:,7))),7), 'g--*','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,8))),save_i_sense_plot_collision(1:sum(~isnan(save_i_sense_plot_collision(:,8))),8), 'm--x','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,11))),save_i_sense_plot_collision(1:sum(~isnan(save_i_sense_plot_collision(:,11))),11), 'r--+','LineWidth',1.4);
        plot(1:sum(~isnan(save_i_sense_Succ_coilis_episode_id(:,12))),save_i_sense_plot_collision(1:sum(~isnan(save_i_sense_plot_collision(:,12))),12), 'c-^','LineWidth',1.4);


        grid on;
        title('Sensitivity Analysis: Collision Rate During Evaluation', 'FontWeight', 'bold');
        xlabel('Episode', 'FontWeight', 'bold');
        ylabel('Percentage [%]', 'FontWeight', 'bold');
        set(gca, 'FontSize', 14); 
        ylim([-1,101])
        legend( 'Pretrain=1000','Pretrain=8000','LR_{imit} \downarrow','LR_{imit} \downarrow, LR_{critic} \uparrow','NN Weights -50%','NN Weights +100%','Location','northeast')

        %legend( 'Noise=40%','Noise=10%','Pretrain=1000','Pretrain=8000', 'Collision +50%', 'Goal +50%','LR_{imit} \downarrow','LR_{imit} \downarrow, LR_{critic} \uparrow',    'FOV -50%', 'FOV +50%','NN Weights -50%','NN Weights +100%', '\gamma=0.5','Location','southwest')
        set(gca,'FontSize',14)
        

    end
end

exportgraphics(figure(61), 'images/sensitivity/SENSITIVITY_MAZE_TEST_1_A.png');
exportgraphics(figure(62), 'images/sensitivity/SENSITIVITY_MAZE_TEST_1_B.png');
exportgraphics(figure(63), 'images/sensitivity/SENSITIVITY_MAZE_TEST_2_A.png');
exportgraphics(figure(64), 'images/sensitivity/SENSITIVITY_MAZE_TEST_2_B.png');

exportgraphics(figure(65), 'images/sensitivity/SENSITIVITY_REWARD_TEST_1A.png');
exportgraphics(figure(66), 'images/sensitivity/SENSITIVITY_REWARD_TEST_1B.png');
exportgraphics(figure(67), 'images/sensitivity/SENSITIVITY_REWARD_TEST_2A.png');
exportgraphics(figure(68), 'images/sensitivity/SENSITIVITY_REWARD_TEST_2B.png');

exportgraphics(figure(69), 'images/sensitivity/SENSITIVITY_SUCCESS_TEST_A.png');
exportgraphics(figure(70), 'images/sensitivity/SENSITIVITY_SUCCESS_TEST_B.png');
exportgraphics(figure(71), 'images/sensitivity/SENSITIVITY_COLLISION_TEST_A.png');
exportgraphics(figure(72), 'images/sensitivity/SENSITIVITY_COLLISION_TEST_B.png');