load("/MATLAB Drive/F0_Electrodes.mat");
ElectrodeData = cell2mat(dataVectors_electrodes);
[coeff, score, latent] = pca(ElectrodeData);
colours = [0 0 1; %blue = acrylic
           0 0 0; %black = black foam
           1 1 0; %yellow = car sponge
           0.5 0 0.5; %purple = flour sack 
           0 1 0; %green = kitchen sponge
           1 0 0]; %red = steel vase
figure(1); 
subplot(2, 1, 1);
plot(latent, '-o')
title("Scree Plot")
xticks(1:2:19)
xlabel("Principal Components")
ylabel("Variance")
subplot(2, 1, 2);
for i=0:5
    scatter3(score(i*10+1:(i+1)*10,1), score(i*10+1:(i+1)*10,2), score(i*10+1:(i+1)*10), 20, colours(i+1, :), 'filled')
    hold on;
end
xlabel("PC1")
ylabel("PC2")
zlabel("PC3")
