function relativeState = getRelativeState(maze,absoluteState)
%% relativeState = getRelativeState(maze,absoluteState)
% Relative state indicates distance to walls/obstacles in forward, left and
% right directions. relativeState = [LEFT,FORWARD,RIGHT]. Distance can be
% 1,2,3 when a wall/obstacle is detected 1,2,3 blocks away. If distance is
% 0, then no wall/obstacle was detected within the sense-range of 3.

%default
relativeState = zeros(1,3);

if length(absoluteState)~=3
    error('Incorrect state')
end
if absoluteState(1)<1 || absoluteState(1)>size(maze,1) || absoluteState(2)<1 || absoluteState(2)>size(maze,2) || absoluteState(3)<1 || absoluteState(3)>4
    error('Incorrect state')
end

% Make maze boolean (if not already so)
% walls are TRUE
maze        = (maze>0);
if ~maze(1,1) %make walls TRUE
    maze=~maze;
end

if maze(absoluteState(1),absoluteState(2))
    error('State in wall')
end

% Define headings
NORTH       = 1;
EAST        = 2;
SOUTH       = 3;
WEST        = 4;

% Define sensing directions
LEFT        = 1;
FORWARD     = 2;
RIGHT       = 3;

r = absoluteState(1); %row
c = absoluteState(2); %column
h = absoluteState(3); %heading

switch h
    case NORTH
        for lookLeft=1:1:3
            if c-lookLeft>0 && maze(r,c-lookLeft)
                relativeState(LEFT)=lookLeft;
                break
            end
        end
        for lookForward=1:1:3
            if r-lookForward>0 && maze(r-lookForward,c)
                relativeState(FORWARD)=lookForward;
                break
            end
        end
        for lookRight=1:1:3
            if c+lookRight<=size(maze,2) && maze(r,c+lookRight)
                relativeState(RIGHT)=lookRight;
                break
            end
        end
    case EAST
         for lookLeft=1:1:3
            if r-lookLeft>0 && maze(r-lookLeft,c)
                relativeState(LEFT)=lookLeft;
                break
            end
        end
        for lookForward=1:1:3
            if c+lookForward<=size(maze,2) && maze(r,c+lookForward)
                relativeState(FORWARD)=lookForward;
                break
            end
        end
        for lookRight=1:1:3
            if r+lookRight<=size(maze,1) && maze(r+lookRight,c)
                relativeState(RIGHT)=lookRight;
                break
            end
        end
    case SOUTH
        for lookLeft=1:1:3
            if c+lookLeft<=size(maze,2) && maze(r,c+lookLeft)
                relativeState(LEFT)=lookLeft;
                break
            end
        end
        for lookForward=1:1:3
            if r+lookForward<=size(maze,1) && maze(r+lookForward,c)
                relativeState(FORWARD)=lookForward;
                break
            end
        end
        for lookRight=1:1:3
            if c-lookRight>0 && maze(r,c-lookRight)
                relativeState(RIGHT)=lookRight;
                break
            end
        end
    case WEST
        for lookLeft=1:1:3
            if r+lookLeft<=size(maze,1) && maze(r+lookLeft,c)
                relativeState(LEFT)=lookLeft;
                break
            end
        end
        for lookForward=1:1:3
            if c-lookForward>0 && maze(r,c-lookForward)
                relativeState(FORWARD)=lookForward;
                break
            end
        end
        for lookRight=1:1:3
            if r-lookRight>0 && maze(r-lookRight,c)
                relativeState(RIGHT)=lookRight;
                break
            end
        end
    otherwise
        error('Incorrect heading')
end


