%   Example: To visualize the function x*exp(-x^2-y^2-z^2) over the
%   range -2 < x < 2, -2 < y < 2, -2 < z < 2, 
clear
[x,y,z] = meshgrid(-2:.2:2, -2:.25:2, -2:.16:2);
v = x .* exp(-x.^2 - y.^2 - z.^2);
slice(x,y,z,v,[-1.2 .8 2],2,[-2 -.2])
xlabel('x');ylabel('y');zlabel('z');