clear 
clf reset
format long
%first, plot the ellipse representing the white cell:
%% center : (0,0), Horizontal axis length : 5, Vertical axis length : 10
a = 5;
b = 10;
t = [-pi:0.01:pi];
x = a*cos(t);
y = b*sin(t);
plot(x,y);
title("White cell is the ellipse 4x^2+y^2 = 100");
hold on;
%% NOW, WE ANIMATE THE LASER TRAJECTORIES....

start = [0,10.1];
hit = [-5,0];
counter = 1;
x = [];
y = [];
t = [0:0.01:1];
inside = 1;
txt= num2str(counter);
h_annot=annotation('textbox',[0.15 0.5 0.3 0.3],'String',txt,'FitBoxToText','on','EdgeColor','red');
writerObj = VideoWriter('laserbeam.avi');
writerObj.FrameRate = 30;
open(writerObj);

while (inside == 1)
  
    %plot the current laser beam from start to hit point...
    for i=1:size(t,2) %get enough points of the segment from start to hit points, for t in [0,1]
        x(i) = start(1)+t(i)*(hit(1)-start(1));
        y(i) = start(2) +t(i)*(hit(2)-start(2));
    end
    plot(x,y,'red');
    hold on;
    txt = sprintf('%d reflections ',counter);
    set(h_annot,'String',txt);
    %Find the symmetric point of the start with respect to line perp to
    %normal line at the hitting spot;
    [n1, n2] = normalv(hit(1),hit(2));
    hold on;
    %% CALCULATE THE NEXT HIT
    %set the sytem of equations needed for it:
    [t1, t2] = tangentv(hit(1),hit(2));
    A(1,1) = t1;
    A(2,1) = t2;
    A(1,2) = (-1)*n1;
    A(2,2) = (-1)*n2;
    b(1,1) = hit(1)-start(1);
    b(2,1) = hit(2)-start(2);
    X = linsolve(A,b);
    disp(X(2))
    sym(1) = 2*(hit(1)+X(2)*n1) - start(1);
    sym(2) = 2*(hit(2)+X(2)*n2) - start(2);
    dir(1) = sym(1)-hit(1);
    dir(2) = sym(2)-hit(2);
    p(1) = 4*(dir(1)^2) + dir(2)^2;
    p(2) = 8*hit(1)*dir(1) + 2*hit(2)*dir(2);
    p(3) = 4*(hit(1)^2)+hit(2)^2-100;
    r = roots(p);
    t0 = take_biggest(r(1,1),r(2,1));%specific t value for the new hit point in the reflected beam trajectory... obtained by solving the above special quadratic equation
    %plot it to see it in the mirror as a hit point...
    plot(hit(1)+t0*dir(1),hit(2)+t0*dir(2),'.');
    hold on;
    %% ----
    %now, update value of hit and start.
    start(1) = hit(1);
    start(2) = hit(2);
    hit(1) = hit(1)+t0*dir(1);
    hit(2) = hit(2)+t0*dir(2);
    %% CHECK IF IT HAS EXITTED THE CELL
    if (hit(1)>= -0.01)&&(hit(1)<= 0.01)&&(hit(2)>0)
        inside = -1; 
        %also, colour thi last ray in green
        for i=1:size(t,2) %get enough points of the segment from start to hit points, for t in [0,1]
        x(i) = start(1)+t(i)*(hit(1)-start(1));
        y(i) = start(2) +t(i)*(hit(2)-start(2));
        end
        plot(x,y,'green');
    else
        %increment the hit counter
        counter = counter +1;
    end
    %% ----
    frame = getframe(gcf);
    writeVideo(writerObj,frame);
    pause(0.001);
 
end
close(writerObj);
fprintf("\nTHE LASER BEAM HAS BOUNCED INSIDE : %d times!",counter)
%%USEFUL FUNCTIONS :
function [u,v] = tangentv(x,y) %returns the vector tangent to the ellipse at point (x,y)
    u = (y)/(sqrt(y^2 + 16*x^2));
    v = (-4*x)/(sqrt(y^2 + 16*x^2));
end
function [u,v] = normalv(x,y) %returns the vector normal to the ellipse at point (x,y)
    u = (-4*x)/(sqrt(y^2 + 16*x^2));
    v = ((-1)*y)/(sqrt(y^2 + 16*x^2));
end
function z = take_biggest(x,y)
    if abs(x) >= abs(y)
        z = x;
    else
        z = y;
    end
end
