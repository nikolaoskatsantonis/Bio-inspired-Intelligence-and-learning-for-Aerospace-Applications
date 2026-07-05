function [critic_n,loss] = train_critic(critic_n,s,u,r,s_next,u_next,done,gamma,lr_critic)
input = [s;u]; input_next = [s_next;u_next];
h1 = tanh(critic_n.W1*input + critic_n.b1);
h2 = tanh(critic_n.W2*h1 + critic_n.b2);
J = critic_n.W3*h2 + critic_n.b3;
if done
    Jnext = 0;
else
    h1n = tanh(critic_n.W1*input_next + critic_n.b1);
    h2n = tanh(critic_n.W2*h1n + critic_n.b2);
    Jnext = critic_n.W3*h2n + critic_n.b3;
end
% ec = clamp((r + gamma*Jnext) - J,-20,20);

ec = (r + gamma*Jnext) - J;

loss = 0.5*ec^2;
dE_dJ = -ec;




dJ_W3 = h2';
dJ_b3 =  1;
dE_W3 = dE_dJ * dJ_W3;
dE_b3 = dE_dJ * dJ_b3;

% dJ_dz2 = (critic_n.W3'*dE_de).*(1-h2.^2);
dJ_dz2 = critic_n.W3' .* (1-h2.^2);
dJ_W2 = dJ_dz2*h1';
dJ_b2 = dJ_dz2;
dE_W2 = dE_dJ * dJ_W2;
dE_b2 = dE_dJ * dJ_b2;


% dJ_dz2 = critic_n.W3' .* (1-h2.^2);
dJ_dh1 = critic_n.W2' * dJ_dz2;
dJ_dz1 = dJ_dh1 .* (1-h1.^2);
dJ_W1 = dJ_dz1 * input';
dJ_b1 = dJ_dz1;
dE_W1 = dE_dJ * dJ_W1;
dE_b1 = dE_dJ * dJ_b1;


critic_n.W3 = critic_n.W3 - lr_critic*dE_W3; 
critic_n.b3 = critic_n.b3 - lr_critic*dE_b3;
critic_n.W2 = critic_n.W2 - lr_critic*dE_W2; 
critic_n.b2 = critic_n.b2 - lr_critic*dE_b2;
critic_n.W1 = critic_n.W1 - lr_critic*dE_W1; 
critic_n.b1 = critic_n.b1 - lr_critic*dE_b1;

end