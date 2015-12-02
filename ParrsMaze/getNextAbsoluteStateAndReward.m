function [nextState,reward] = getNextAbsoluteStateAndReward(maze,currentState,action)

if length(currentState)~=3
    error('Incorrect current state')
end
if currentState(1)<1 || currentState(1)>size(maze,1) || currentState(2)<1 || currentState(2)>size(maze,2) || currentState(3)<1 || currentState(3)>4
    error('Incorrect current state')
end

% Make maze boolean (if not already so)
% walls are TRUE
maze        = (maze>0);
if ~maze(1,1) %make walls TRUE
    maze=~maze;
end

if maze(currentState(1),currentState(2))
    error('Current state in wall')
end

% Define actions
FORWARD     = 1;
TURNLEFT    = 2;
TURNRIGHT   = 3;

% Define headings
NORTH       = 1;
EAST        = 2;
SOUTH       = 3;
WEST        = 4;

%Rewards:
WALLPENALTY = -2;
GOALREWARD  = 10;

r           = currentState(1);
c           = currentState(2);
h           = currentState(3);

% default
nextState   = currentState;
reward      = -1;



switch action
    case FORWARD
        switch h %Current heading
            case NORTH
                if maze(currentState(1)-1,currentState(2))
                    % Moved into wall, keep state, change direction 180
                    % degrees
                    reward          = WALLPENALTY;
                    nextState(3)    = SOUTH;
                else
                    nextState(1)    = currentState(1)-1;
                    if nextState(1)>73 && nextState(2)>73
                        % Goal reached
                        reward = GOALREWARD;
                    end
                end
            case EAST
                if maze(currentState(1),currentState(2)+1)
                    % Moved into wall, keep state, change direction 180
                    % degrees
                    reward          = WALLPENALTY;
                    nextState(3)    = WEST;
                else
                    nextState(2)    = currentState(2)+1;
                    if nextState(1)>73 && nextState(2)>73
                        % Goal reached
                        reward = GOALREWARD;
                    end
                end
            case SOUTH
                if maze(currentState(1)+1,currentState(2))
                    % Moved into wall, keep state, change direction 180
                    % degrees
                    reward          = WALLPENALTY;
                    nextState(3)    = NORTH;
                else
                    nextState(1)    = currentState(1)+1;
                    if nextState(1)>73 && nextState(2)>73
                        % Goal reached
                        reward = GOALREWARD;
                    end
                end
            case WEST
                if maze(currentState(1),currentState(2)-1)
                    % Moved into wall, keep state, change direction 180
                    % degrees
                    reward          = WALLPENALTY;
                    nextState(3)    = EAST;
                else
                    nextState(2)    = currentState(2)-1;
                    if nextState(1)>73 && nextState(2)>73
                        % Goal reached
                        reward = GOALREWARD;
                    end
                end
            otherwise
                error('Incorrect heading')
        end
    case TURNLEFT
        switch h %Current heading
            case NORTH
                nextState(3) = WEST;
            case EAST
                nextState(3) = NORTH;
            case SOUTH
                nextState(3) = EAST;
            case WEST
                nextState(3) = SOUTH;
            otherwise
                error('Incorrect heading')
        end
    case TURNRIGHT
        switch h %Current heading
            case NORTH
                nextState(3) = EAST;
            case EAST
                nextState(3) = SOUTH;
            case SOUTH
                nextState(3) = WEST;
            case WEST
                nextState(3) = NORTH;
            otherwise
                error('Incorrect heading')
        end
    otherwise
        error('Incorrect action')
end




