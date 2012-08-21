function [s_updated radius_updated]= dfs_det (y_received, H_Channel_Matrix, modulation_order, s_i, M_T);

global RAM_Data RAM_Counter s_updated N_visited_nodes s_i radius_updated y R T_i 

% clear PD_list PD_symbol PD_symbol_sorted

set(0,'RecursionLimit',1e15)

% Number of bits per modulation symbol:
n_bits=log2(modulation_order);
% TX/RX antenna numbers:
% [M_R, M_T]= size(H_Channel_Matrix);
% QAM modulation symbol set
% s_i=qammod([0:modulation_order-1],modulation_order,0,'gray');

list_size_counter = 0;

%%%%%%%% Receiver (Detector):
% Channel pre-processing 
% S_ZF=H_Channel_Matrix^(-1)*y_received;
[Q,R]=qr(H_Channel_Matrix);
y=Q'*y_received;

% Depth-first sphere detector
i_step_sim=M_T;
T_i=0;
min_vector=modulation_order*ones(1,M_T);
estimated_s=modulation_order*ones(1,M_T);
RAM_Data=zeros(1,M_T+1+1);
RAM_Counter=0;

%tracing the tree at the first time for finding the radius. Note that at
%this stage non-visited nodes are not stored in the memory. This trace is
%just to find the radius.
for i_step_sim=M_T:-1:1    
    %% PED computations:
    b_i_plus_1=y(i_step_sim);
    sum_1=0; 
    if i_step_sim~=M_T
        for count=i_step_sim+1:M_T
            sum_1=sum_1+R(i_step_sim, count)*s_i(min_vector((count))+1);
        end
    end
    b_i_plus_1=b_i_plus_1-sum_1;
    i_step_sim;
    e_i=b_i_plus_1-R(i_step_sim,i_step_sim)*s_i;
    
    
    ABS_SQUARE_of_e_i=abs(b_i_plus_1-R(i_step_sim,i_step_sim)*s_i).^2;
%     ABS_SQUARE_of_e_i=abs(b_i_plus_1-R(i_step_sim,i_step_sim)*s_i);
    
    
    T_so_far=T_i+ABS_SQUARE_of_e_i;
    %%
    
    % Choosing the minimum among the children to continue:
    [min_value, min_index]=min(ABS_SQUARE_of_e_i);
    T_i=T_i+min_value;
    min_vector(i_step_sim)=min_index-1;

end

%updating the estimated values at the end of the tree
s_updated=min_vector;
radius_updated=T_i;

% s_updated=qamdemod(S_ZF,modulation_order,0,'gray');
% received-H_Channel_Matrix*qammod(s_updated,modulation_order,0,'gray');
% radius_updated=norm(received-H_Channel_Matrix*qammod(s_updated,modulation_order,0,'gray')).^2;
% s_updated=s_updated';

%restarting from the first layer. This time the radius is known; thus nodes
%outside the radius is not stored.
min_vector=modulation_order*ones(1,M_T);
i_step_sim=M_T;
T_i=0;

for i_step_sim=M_T:-1:1
    %Current threshold equals the radius sphere
    C_i=radius_updated;

    %% PED computations:
    b_i_plus_1=y(i_step_sim);
    sum_1=0; 
    if i_step_sim~=M_T
        for count=i_step_sim+1:M_T
            sum_1=sum_1+R(i_step_sim, count)*s_i(min_vector((count))+1);
        end
    end
    b_i_plus_1=b_i_plus_1-sum_1;
    e_i=b_i_plus_1-R(i_step_sim,i_step_sim)*s_i;
    
    
    ABS_SQUARE_of_e_i=abs(b_i_plus_1-R(i_step_sim,i_step_sim)*s_i).^2;
    
    T_so_far=T_i+ABS_SQUARE_of_e_i;
    %%
    [min_value, min_index]=min(ABS_SQUARE_of_e_i);
    T_i=T_i+min_value;
    N_visited_nodes=N_visited_nodes+1;
    
    if(T_i>C_i)
        finish=1;
        N_visited_nodes=M_T;
        break;
    end
    min_vector(i_step_sim)=min_index-1;
    
    %% Storing the non-visited admissible nodes in the memory to be visited
    %% later:
    for mod_index=0:modulation_order-1
        if (mod_index~=min_index-1 && T_so_far(mod_index+1)<=C_i && i_step_sim~=1)
            RAM_Counter=RAM_Counter+1;
            RAM_Data(RAM_Counter,M_T+1)=i_step_sim-1;
            RAM_Data(RAM_Counter,M_T+2)=T_so_far(mod_index+1);
            for g_count=1:M_T
                RAM_Data(RAM_Counter,g_count)=min_vector(g_count);
            end
            RAM_Data(RAM_Counter,i_step_sim)=mod_index;
        end
    end
end

%updating the estimated values at the end of the tree
if (i_step_sim==1 && T_i<C_i)
    s_updated=min_vector;
    radius_updated=T_i;
 end

N_visited_nodes=M_T;

% If no node is stored in the memory, detection is done --> return
if (RAM_Counter==0)
    return
end

% Calling the iterative function starts from here. 'calculate_distance'
% calls itself iteratively until all the nodes in the memory visited.
% Note that during each iterative function call, depending on whether there is any new node to be stored
% in the memory, new nodes may be appended to the memory:
calculate_distance(RAM_Data(RAM_Counter,:), M_T, modulation_order);

%save tmp s_updated
%clear global RAM_Data RAM_Counter s_updated N_visited_nodes s_i radius_updated y R T_i
%clear all;
%load tmp

return

%% Recursive function body:
%% The body of this function is mostly the same as the above "for loop"
%% structure where PEDs are computed and the minimum children is chosen for
%% the next function call (i.e. continuing) provided that it is not in the
%% last level, and it is within the sphere. The rest of the admissible
%% nodes enter the tail of the unvisited nodes in the 'RAM_Data'.
function calculate_distance(saved_data, M_T, modulation_order)
global RAM_Data RAM_Counter s_updated N_visited_nodes s_i radius_updated y R T_i 

n_bits=log2(modulation_order);
RAM_Counter=RAM_Counter-1;

for m_count=1:M_T
    min_vector(m_count)=saved_data(m_count);
end
i_step_sim=saved_data(M_T+1);
T_i=saved_data(M_T+2);

C_i=radius_updated;

if T_i<C_i
    N_visited_nodes = N_visited_nodes + 1;
end

b_i_plus_1=y(i_step_sim);
sum_1=0;
if i_step_sim~=M_T
   for count=i_step_sim+1:M_T
      sum_1=sum_1+R(i_step_sim, count)*s_i(min_vector((count))+1);
   end
end
sum_1;
b_i_plus_1=b_i_plus_1-sum_1;
e_i=b_i_plus_1-R(i_step_sim,i_step_sim)*s_i;


ABS_SQUARE_of_e_i=abs(b_i_plus_1-R(i_step_sim,i_step_sim)*s_i).^2;

T_so_far=T_i+ABS_SQUARE_of_e_i;
[min_value, min_index]=min(ABS_SQUARE_of_e_i);
T_i=T_i+min_value;
min_vector(i_step_sim)=min_index-1;

for mod_index=0:modulation_order-1
    if (mod_index~=min_index-1 && T_so_far(mod_index+1)<=C_i && i_step_sim~=1)
            RAM_Counter=RAM_Counter+1;
            RAM_Data(RAM_Counter,M_T+1)=i_step_sim-1;
            RAM_Data(RAM_Counter,M_T+2)=T_so_far(mod_index+1);
            for g_count=1:M_T
                RAM_Data(RAM_Counter,g_count)=min_vector(g_count);
            end
            RAM_Data(RAM_Counter,i_step_sim)=mod_index;
    end
end

if (i_step_sim==1 && T_i<C_i)
    s_updated=min_vector;
    radius_updated=T_i;
    C_i=T_i;
end

if (T_i>=C_i || i_step_sim==1)
    RAM_Counter=RAM_Counter;
    if (RAM_Counter==0)
        return
    else
    calculate_distance(RAM_Data(RAM_Counter,:), M_T, modulation_order);
    end
    return
end
    
if (T_i<C_i || i_step_sim~=1)
    RAM_Counter=RAM_Counter+1;
    calculated_s=[min_vector i_step_sim-1 T_i];
    calculate_distance(calculated_s, M_T, modulation_order);
end

