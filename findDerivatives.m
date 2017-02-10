function [ J, theta, Jx, Jy ] = findDerivatives( I, Gx, Gy )
%findDerivatives Compute magnitude and orientation of derivatives for the
%given image I.
% (INPUT) I: HxW matrix representing grayscale image.
% (INPUT) Gx, Gy: Gaussian Filters.
% (OUTPUT) J: HxW matrix represents the magnitude of derivatives.
% (OUTPUT) theta: HxW matrix representing the orientation of derivatives.
% (OUTPUT) Jx: HxW matrix representing the magnitude of derivatives along
% x-axis.
% (OUTPUT) Jy: HxW matrix representing the magnitude of derivatives along
% y-axis.

I = imadjust(I);

dx = gradient(Gx);
dy = gradient(Gy);

Jx = conv2(double(I), dx, 'same');
Jy = conv2(double(I), dy, 'same');

J = sqrt(Jx.^2 + Jy.^2);
J = J / max(J(:));
theta = atan2(Jy, Jx);



% dx = gradient(Gx);
% pos_dx = dx > 0;
% neg_dx = dx < 0;
% dx(pos_dx) = dx(pos_dx)/sum(dx(pos_dx));
% dx(neg_dx) = dx(neg_dx)/abs(sum(dx(neg_dx)));

% dy = gradient(Gy);
% pos_dy = dy > 0;
% neg_dy = dy < 0;
% dy(pos_dy) = dy(pos_dy)/sum(dy(pos_dy));
% dy(neg_dy) = dy(neg_dy)/abs(sum(dy(neg_dy)));

% Jx = conv2(double(I), Gx, 'same');
% Jy = conv2(double(I), Gy, 'same');

% Jx = conv2(Jx, dx, 'same');
% Jy = conv2(Jy, dy, 'same');

% Jx = conv2(double(I), dx, 'same');
% Jy = conv2(double(I), dy, 'same');

% J = sqrt(Jx.^2 + Jy.^2);
% J = J / max(J(:));
% theta = atan2(Jy, Jx);

end

