ElectrodeData = cell2mat(dataVectors_electrodes);
[coeff, score, latent] = pca(ElectrodeData);
plot(latent, '-o')
title("Scree Plot")
xticks(1:2:19)
xlabel("Principal Components")
ylabel("Variance")
figure
scatter3(score(:,1), score(:,2), score(:,3))
xlabel("PC1")
ylabel("PC2")
zlabel("PC3")