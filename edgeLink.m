function [ E ] = edgeLink(M, J, theta )
%edgeLink Use hysteresis to link edges based on high and low magnitude
%thresholds.
% (INPUT) M: HxW binary matrix representing the edge map after non-maximum
% suppression.
% (INPUT) J: HxW matrix representing the magnitude of derivatives.
% (INPUT) theta: HxW matrix representing the orientation of derivatives.
% (OUTPUT) E: HxW binary matrix representing the final edge map.

edge = M .* J;

[r, c] = size(M);
H = imhist(J, 64);
thresh_high = find(cumsum(H) > 0.83*r*c, 1, 'first')/64;
thresh_low = 0.4*thresh_high;

% thresh_low = 0.03;
% thresh_high = 0.1;

pix_min = min(edge(:));
pix_max = max(edge(:));

pix_thresh_low = thresh_low * (pix_max - pix_min) + pix_min;
pix_thresh_high = thresh_high * (pix_max - pix_min) + pix_min;

tri = zeros(size(J));
tri(edge >= pix_thresh_low) = 1;
tri(edge >= pix_thresh_high) = 2;

% E = imfill(tri == 0, sub2ind(size(tri), find(tri == 2)), 8) & (tri > 0);
[r, c] = size(J);
E = zeros(r, c);
theta(theta < 0) = theta(theta < 0) + pi;
quad = floor(theta * 4 / pi);
quad(quad == 4) = 0;
for i = 1: r
    for j = 1: c
%         d = tan(theta(i, j));
%         flag = 1;
        switch quad(i, j)
            case 0
                E(i, j) = ((tri(i, j)==1) & ((tri(max(1, i - 1), j)==2) | (tri(max(1, i - 1), min(c, j + 1))==2) | (tri(min(r, i + 1), j)==2) | (tri(min(r, i + 1), max(1, j - 1))==2))) | (tri(i, j) == 2);
            case 1
                E(i, j) = ((tri(i, j)==1) & ((tri(i, min(c, j + 1))==2) | (tri(max(1, i - 1), min(c, j + 1))==2) | (tri(min(r, i + 1), min(c, j + 1))==2) | (tri(i, max(1, j - 1))==2))) | (tri(i, j) == 2);
            case 2
                E(i, j) = ((tri(i, j)==1) & ((tri(i, min(c, j + 1))==2) | (tri(min(r, i + 1), min(c, j + 1))==2) | (tri(i, max(1, j - 1))==2) | (tri(max(1, i - 1), max(1, j - 1))==2))) | (tri(i, j) == 2);
            case 3
                E(i, j) = ((tri(i, j)==1) & ((tri(min(r, i + 1), j)==2) | (tri(min(r, i + 1), min(c, j + 1))==2) | (tri(max(1, i - 1), max(1, j - 1))==2) | (tri(max(1, i - 1), j)==2))) | (tri(i, j) == 2);
        end
    end
end

E = logical(E);

end

