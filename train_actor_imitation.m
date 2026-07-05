function actor_n = train_actor_imitation(actor_n,s,utarget,steering_max,throttle_max,lr)
z1 = actor_n.W1*s + actor_n.b1; 
h1 = tanh(z1);
z2 = actor_n.W2*h1 + actor_n.b2;
h2 = tanh(z2);
z3 = actor_n.W3*h2 + actor_n.b3;
a_raw = tanh(z3);
u = [steering_max*a_raw(1); throttle_max*a_raw(2)];
error = u - utarget;

dEa_du = error; 
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

actor_n.W3 = actor_n.W3 - lr*dEa_dWa3; 
actor_n.b3 = actor_n.b3 - lr*dEa_dba3;
actor_n.W2 = actor_n.W2 - lr*dEa_dWa2;
actor_n.b2 = actor_n.b2 - lr*dEa_dba2;
actor_n.W1 = actor_n.W1 - lr*dEa_dWa1; 
actor_n.b1 = actor_n.b1 - lr*dEa_dba1;
end