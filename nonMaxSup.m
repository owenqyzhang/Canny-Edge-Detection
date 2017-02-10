function [ M ] = nonMaxSup( J, theta )
%nonMaxSup Find local maximum edge pixel using non-maximum suppression
%along the line of the gradient.
% (INPUT) J: HxW matrix representing the magnitude of derivatives.
% (INPUT) theta: HxW matrix representing the orientation of derivatives.
% (OUTPUT) M: HxW binary matrix representing the edge map after non-
% maximum suppression.

[r, c] = size(J);
M = zeros(size(J));

th = 0.03 * max(J(:));

theta(theta < 0) = theta(theta < 0) + pi;
quad = floor(theta * 4 / pi);
quad(quad == 4) = 0;
for i = 1: r
    for j = 1: c
        d = tan(theta(i, j));
        co = cot(theta(i, j));
        flag = 1;
        switch quad(i, j)
            case 0
                if i < r && j < c
                    I = J(i, j + 1) * (1 - d) + J(i + 1, j + 1) * d;
                    if J(i, j) < I || J (i, j) < th
                        flag = 0;
                    end
                end
                if i > 1 && j > 1
                    I = J(i, j - 1) * (1 - d) + J(i - 1, j - 1) * d;
                    if J(i, j) < I || J (i, j) < th
                        flag = 0;
                    end
                end
                M(i, j) = flag;
%                 M(i, j) = flag * J(i, j);
            case 1
                if i < r && j < c
                    I = J(i + 1, j) * (1 - co) + J(i + 1, j + 1) * co;
                    if J(i, j) < I || J (i, j) < th
                        flag = 0;
                    end
                end
                if i > 1 && j > 1
                    I = J(i - 1, j) * (1 - co) + J(i - 1, j - 1) * co;
                    if J(i, j) < I || J (i, j) < th
                        flag = 0;
                    end
                end
                M(i, j) = flag;
%                 M(i, j) = flag * J(i, j);
            case 2
                if i < r && j > 1
                    I = J(i + 1, j) * (1 + co) + J(i + 1, j - 1) * (-co);
                    if J(i, j) < I || J (i, j) < th
                        flag = 0;
                    end
                end
                if i > 1 && j < c
                    I = J(i - 1, j) * (1 + co) + J(i - 1, j + 1) * (-co);
                    if J(i, j) < I || J (i, j) < th
                        flag = 0;
                    end
                end
                M(i, j) = flag;
%                 M(i, j) = flag * J(i, j);
            case 3
                if i < r && j > 1
                    I = J(i, j - 1) * (1 + d) + J(i + 1, j - 1) * (-d);
                    if J(i, j) < I || J (i, j) < th
                        flag = 0;
                    end
                end
                if i > 1 && j < c
                    I = J(i, j + 1) * (1 + d) + J(i - 1, j + 1) * (-d);
                    if J(i, j) < I || J (i, j) < th
                        flag = 0;
                    end
                end
                M(i, j) = flag;
%                 M(i, j) = flag * J(i, j);
        end
    end
end

M = logical(M);

% M(M < 200) = 0;
% M(M > 0) = 1;

% M = M .* J;
end

