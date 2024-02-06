load("/MATLAB Drive/F0_Electrodes.mat");
ElectrodeData = cell2mat(dataVectors_electrodes);
[coeff, score, latent] = pca(ElectrodeData);
figure(1); 
subplot(2, 1, 1);
plot(latent, '-o')
title("Scree Plot")
xticks(1:2:19)
xlabel("Principal Components")
ylabel("Variance")
%figure
subplot(2, 1, 2);
scatter3(score(:,1), score(:,2), score(:,3), 'filled')
xlabel("PC1")
ylabel("PC2")
zlabel("PC3")
