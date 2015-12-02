clear all
close all
clc

% Initialize maze and define headings and actions:
% defines variables: maze, NORTH, EAST, SOUTH, WEST, TURNLEFT, FORWARD,
% TURNRIGHT
initMaze;

%Initialize state [row,column,heading]:
r                       = 73; 
c                       = 75;
h                       = SOUTH;


currentAbsoluteState    = [r,c,h];

%Initialize action (FORWARD,TURNLEFT,TURNRIGHT)
action                  = FORWARD;

%Get next absilute state:
[nextAbsoluteState,reward]  = getNextAbsoluteStateAndReward(maze,currentAbsoluteState,action)

%Get relative state from absolute state. The relaive state contains only
%information about what the agent can sense.
% Relative state indicates distance to walls/obstacles in forward, left and
% right directions. relativeState = [LEFT,FORWARD,RIGHT]. Distance can be
% 1,2,3 when a wall/obstacle is detected 1,2,3 blocks away. If distance is
% 0, then no wall/obstacle was detected within the sense-range of 3.

relativeState               = getRelativeState(maze,nextAbsoluteState)

% Plot maze:
image(maze)
colormap(gray)

%Plot current position:
hold on
plot(c,r,'r*')


%Add label for heading of the current state
hStr = '';
switch h
    case NORTH
        hStr = 'NORTH';
    case EAST
        hStr = 'EAST';
    case SOUTH
        hStr = 'SOUTH';
    case WEST
        hStr = 'WEST';
    otherwise
        error('Invalid heading')
end
text(c+1,r,hStr,'BackgroundColor',[.7 .9 .7])

%Plot next position:
plot(nextAbsoluteState(2),nextAbsoluteState(1),'bo')
legend('state','nextState')
