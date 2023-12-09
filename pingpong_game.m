
clear; clc; close all;

% Game Setup
pongFigure = figure('color', [.1 .8 .8],'KeyPressFcn',@keyboardFunction);
pongAxes = axes('color','black', 'XLim',[0 100],'YLim',[-5 100], 'XTickLabels', [],...
    'YTickLabels',[], 'position', [.05 .05 .9 .9]);

pongBallVel= [0.8  1.2];
pongBallPos = [20,50];
pongBall = line(pongBallPos(1),pongBallPos(2),'marker','.','markersize',50, 'color',[.8 .1 .1]);
global pongBlockCenter;
pongBlockCenter = 45;
pongBlock = line([pongBlockCenter-15, pongBlockCenter+15], [0 0], 'linewidth', 10, 'color', [.1 .1 .8]);


% Add Enemy blocks
enemycenter = 5; n = 95;
for k = 1:5
    for j = 1:7
        enemy(j,k) = line([enemycenter-5, enemycenter+5], [n n], 'linewidth', 10, 'color', [.9 .9 .1]);
        X(j,k) = enemycenter; Y(j,k) = n;
        enemycenter = enemycenter+15;
    end
    n = n-5;
    enemycenter = 5;
end
x = [5 20 35 50 65 80 95];y = [95 90 85 80 75];
for i = 1:7
    for j = 1:5
        A(i,j) = x(i); % holds x values in grid
        B(i,j) = y(j); % hold y values in grid
    end
end

% Game Loop
while 1
    if pongBallPos(1)<0 || pongBallPos(1)>100;
        pongBallVel(1) = -pongBallVel(1);
    end
    if pongBallPos(2)<2 || pongBallPos(2)>100;
        pongBallVel(2) = - pongBallVel(2);
    end
    
    % Bounce the ball
    if pongBallPos(2) < 5
        if abs(pongBallPos(1)-pongBlockCenter)<10
            poingBallvel(2) = - pongBallVel(2);
     
            
        else
            pongBallPos = [50 70];
            pongBallvel(2) = - pongBallVel(2);
        end
    end 
    
    % Bounce enemy JJ
   for i = 1:7
       for j = 1:5
           if abs(pongBallPos(1)-A(i,j))<5 && abs(pongBallPos(2)-B(i,j))<5
               A(i,j) = 1000;B(i,j)=1000;
               pongBallVel(2) = - pongBallVel(2);
               set(enemy(i,j),'XData',0,'YData',0);
           end
       end
   end
           
    pongBallPos = pongBallPos + pongBallVel;
    set(pongBall,'XData',pongBallPos(1),'YData',pongBallPos(2));
    set(pongBlock,'XData', [pongBlockCenter-5, pongBlockCenter+5]);
    pause(.03);
end

% Game keyboard input function
function keyboardFunction(figure, event)
global pongBlockCenter;
switch event.Key
    case 'leftarrow'
        if pongBlockCenter > 5
            pongBlockCenter = pongBlockCenter - 5;
        end
    case 'rightarrow'
        if pongBlockCenter < 95
            pongBlockCenter = pongBlockCenter +5;
        end
end
end