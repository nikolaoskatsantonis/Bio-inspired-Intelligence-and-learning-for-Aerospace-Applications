function actor_n = train_actor_RL(actor_n,critic_n,s,uGuide,controllerpercent,steering_max,throttle_max,lr_actor)
z1 = actor_n.W1*s + actor_n.b1; 
h1 = tanh(z1);
z2 = actor_n.W2*h1 + actor_n.b2;
h2 = tanh(z2);
z3 = actor_n.W3*h2 + actor_n.b3;
a_raw = tanh(z3);
uactor = [steering_max*a_raw(1); throttle_max*a_raw(2)];
%u=uActor;
u = controllerpercent*uGuide + (1-controllerpercent)*uactor;
%I use u like that because: learning is usually based on the actual command being executed, not on an imaginary actor-only command.
input = [s;u];
c1 = tanh(critic_n.W1*input + critic_n.b1);
c2 = tanh(critic_n.W2*c1 + critic_n.b2);
dJ_dinput = critic_n.W1' *((critic_n.W2' * ((critic_n.W3').*(1-c2.^2))) .* (1-c1.^2));
dJ_du = dJ_dinput(end-1:end);
dEa_du = -(1-controllerpercent)*dJ_du;
%dE_du = -dJ_du;

dEa_da = dEa_du .* [steering_max; throttle_max];

du_da3 = dEa_da .* (1-a_raw.^2); 
dEa_dWa3 = du_da3*h2'; 
dEa_dba3 = du_da3;

du_da2 = (actor_n.W3'*du_da3).*(1-h2.^2);
dEa_dWa2 = du_da2*h1'; 
dEa_dba2 = du_da2;

du_da1 = (actor_n.W2'*du_da2).*(1-h1.^2);
dEa_dWa1 = du_da1*s';
dEa_dba1 = du_da1;


actor_n.W3 = actor_n.W3 - lr_actor*dEa_dWa3;
actor_n.b3 = actor_n.b3 - lr_actor*dEa_dba3;
actor_n.W2 = actor_n.W2 - lr_actor*dEa_dWa2;
actor_n.b2 = actor_n.b2 - lr_actor*dEa_dba2;
actor_n.W1 = actor_n.W1 - lr_actor*dEa_dWa1; 
actor_n.b1 = actor_n.b1 - lr_actor*dEa_dba1;
end