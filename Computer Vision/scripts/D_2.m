load("/MATLAB Drive/F0_Electrodes.mat");
ElectrodeData = cell2mat(dataVectors_electrodes);
[coeff, score, latent] = pca(ElectrodeData);
electrode3D = score(:, 1:3);
trainingData = zeros(36, 3);
testData = zeros(24, 3);
trainingLabels = string(zeros(36, 1));
testLabels = string(zeros(24, 1));
labels = string(zeros(60, 1));
a=1;
b=1;
%labels: 1=acrylic, 2=blackFoam, 3=carSponge, 4=flourSack, 5=kitchenSponge,
%6=steelVase
classes = ["Acrylic" "Black Foam" "Car Sponge" "Flour Sack" "Kitchen Sponge" "Steel Vase"];
for i=1:60
    labels(i, 1) = classes(ceil(i/10));
end
for i = 1:5:60
    testData(a, :) = electrode3D(i, :);
    testLabels(a) = labels(i);
    trainingData(b, :) = electrode3D(i+1, :);
    trainingLabels(b) = labels(i+1);
    trainingData(b+1, :) = electrode3D(i+2, :);
    trainingLabels(b+1) = labels(i+2);
    trainingData(b+2, :) = electrode3D(i+3, :);
    trainingLabels(b+2) = labels(i+3);
    testData(a+1, :) = electrode3D(i+4, :);
    testLabels(a+1) = labels(i+4);
    a = a + 2;
    b=b+3;
end
rng(999393,'twister')
b = TreeBagger(50,trainingData,trainingLabels,'OOBPredictorImportance','On');
figure(1)
subplot(2, 1, 1);
plot(oobError(b))
xlabel('Number of Grown Trees')
ylabel('Out-of-Bag Classification Error')
Mdl = TreeBagger(16,trainingData,trainingLabels, Method="classification");
view(Mdl.Trees{1},Mode="graph")
view(Mdl.Trees{2},Mode="graph")
testResults = predict(Mdl, testData);
C = confusionmat(testLabels, string(testResults), 'Order', cellstr(classes));
subplot(2, 1, 2)
confusionchart(C, classes)