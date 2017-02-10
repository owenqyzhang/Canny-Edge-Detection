function visDerivatives(I, J, Jx, Jy)
%% Visualize magnitude and orientation of derivatives

figure; imagesc(J); colormap(gray);truesize;
figure; imagesc(Jx); colormap(gray);truesize;
figure; imagesc(Jy); colormap(gray);truesize;


%% Visualize orientation of derivatives
[cnt, val] = hist(J(:), 100);
thr = val(find(cumsum(cnt)/sum(cnt)<0.95, 1, 'last'));

[x, y] = meshgrid(1:size(I,2), 1:size(I,1));
Jx(J<thr) = 0; 
Jy(J<thr) = 0;
figure; imshow(I); hold on
quiver(x, y, Jx, Jy,'AutoScale', 'off');
hold off

end
