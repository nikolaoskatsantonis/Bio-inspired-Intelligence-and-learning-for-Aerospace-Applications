function u = actor(actor_n,s,steering_max,throttle_max)
h1 = tanh(actor_n.W1*s + actor_n.b1);
h2 = tanh(actor_n.W2*h1 + actor_n.b2);
a_raw = tanh(actor_n.W3*h2 + actor_n.b3);
u = [steering_max*a_raw(1); throttle_max*a_raw(2)];
end