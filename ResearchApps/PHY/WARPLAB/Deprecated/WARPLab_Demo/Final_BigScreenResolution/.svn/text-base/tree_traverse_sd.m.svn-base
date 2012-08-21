function [Current_Rad,Current_Loc,Depth_Count,Radius_Track,Node_Track] = tree_traverse_sd (yprime, Current_Rad, Current_Loc, R, Num_Branch, Depth_Count, Radius_Track, Node_Track)

Depth_Count = Depth_Count - 1;   % Traverse down the tree by one level
Radius_Track_Temp = Radius_Track;   % Vector used to calculate the new distance

% Calculating the PED of all the children nodes
storage = abs(yprime(Depth_Count)-R(Depth_Count,:)*qammod(Node_Track(:,1:Num_Branch),Num_Branch,0,'gray')).^2;

% Repeat until all the children of one parent have been tested
for child=1:Num_Branch

    [value,loc] = min(storage);   % Finding the minimum
    Radius_Track_Temp(Depth_Count) = value;
    
    % Check for the PED
    if sum(Radius_Track_Temp) <= Current_Rad
        Radius_Track(Depth_Count) = value;   % Update the distance in the vector
        Node_Track(Depth_Count,:) = loc-1;   % Update the node in the vector
    else
        break   % If even the minimum node is greater, then all the rest are greater too
    end
    
    % If we've reached the bottom of the tree
    if Depth_Count == 1
        % Saving the new radius and it's location
        Current_Rad = sum(Radius_Track);
        Current_Loc = Node_Track(:,1);
        Radius_Track(Depth_Count) = 0;
        Node_Track(Depth_Count,:) = 0:Num_Branch-1;     

        break   % Cut off no matter what since it's the bottom of the tree
    end
    
    % Call itself to check for all the children if the PED is lesser
    [Current_Rad,Current_Loc,Depth_Count,Radius_Track,Node_Track] = tree_traverse_sd (yprime,Current_Rad,Current_Loc,R,Num_Branch,Depth_Count,Radius_Track,Node_Track);
    
    storage(loc) = Inf;   % Once a child is checked, eliminate that child
end

% If all the children are checked, go back up one level
Depth_Count = Depth_Count + 1;

