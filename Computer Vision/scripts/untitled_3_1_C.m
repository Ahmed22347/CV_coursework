%% %%%%% C %%%%%%%%%%

%%% PressureVibration

filePath = '..\..\Computer Vision\output_files\F0_PVT.mat'; % Load file

% Load the PVT data
load(filePath); % This will load the data from the specified file

data_ = cell2mat(dataVectors);


data = [data_(1:10, :); data_(51:60, :)];


% Feature pairs
pressureVibration = data(:, [1, 2]);
pressureTemperature = data(:, [1, 3]);
Vibrationtemperature = data(:, [2, 3]);

% Standardize the data
standardizedData = zscore(pressureVibration);

% Labels
labels = zeros([20,1]);
labels(1:10) = 1; % acrylic
labels(11:20) = 2; % steal vase


% Standardized Pressure vs. Vibration
X = standardizedData;
Y = labels;

% Calculate group means
m1 = mean(X(Y == 1, :));
m2 = mean(X(Y == 2, :));

% Calculate scatter matrices
S_W = zeros(2,2);
S_B = zeros(2,2);
for i = unique(Y)'
    classData = X(Y == i, :);
    S_W = S_W + cov(classData);
    S_B = S_B + (mean(classData) - mean(X))' * (mean(classData) - mean(X));
end

% Solve the eigenproblem
[eigenvectors, eigenvalues] = eig(inv(S_W) * S_B);

% Sort eigenvalues and select the largest
[~, order] = sort(diag(eigenvalues), 'descend');
eigenvectors = eigenvectors(:, order);

% Choose the top eigenvector as the LDA direction
LDA_direction = eigenvectors(:,1)


% Plot
figure;
hold on;
gscatter(X(:,1), X(:,2), Y, 'ky', '.');
% Plot the standardized means as larger filled dots
plot(m1(1), m1(2), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
plot(m2(1), m2(2), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'y');

% Plot the LDA line
refline(LDA_direction(2)/LDA_direction(1), 0);

% Plot perpendicular line as dotted
perpendicular_slope = -LDA_direction(1)/LDA_direction(2);
refline(perpendicular_slope, 0);
h = findobj(gca,'Type','line');
set(h(1),'LineStyle','--');

xlabel('Standardized Pressure');
ylabel('Standardized Vibration');
title('Standardized Data with LDA');
legend('acrylic', 'steal vase', 'acrylic Mean','steal vase Mean', 'LDA Line', 'Separation line');
hold off;


%%% PressureTemperature


% Standardize the data
standardizedData = zscore(pressureTemperature);

% Labels
labels = zeros([20,1]);
labels(1:10) = 1; % acrylic
labels(11:20) = 2; % steal vase


% Standardized Pressure vs. Vibration
X = standardizedData;
Y = labels;

% Calculate group means
m1 = mean(X(Y == 1, :));
m2 = mean(X(Y == 2, :));

% Calculate scatter matrices
S_W = zeros(2,2);
S_B = zeros(2,2);
for i = unique(Y)'
    classData = X(Y == i, :);
    S_W = S_W + cov(classData);
    S_B = S_B + (mean(classData) - mean(X))' * (mean(classData) - mean(X));
end

% Solve the eigenproblem
[eigenvectors, eigenvalues] = eig(inv(S_W) * S_B);

% Sort eigenvalues and select the largest
[~, order] = sort(diag(eigenvalues), 'descend');
eigenvectors = eigenvectors(:, order);

% Choose the top eigenvector as the LDA direction
LDA_direction = eigenvectors(:,1);


% Plot
figure;
hold on;
gscatter(X(:,1), X(:,2), Y, 'ky', '.');
% Plot the standardized means as larger filled dots
plot(m1(1), m1(2), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
plot(m2(1), m2(2), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'y');


% Plot the LDA line
refline(LDA_direction(2)/LDA_direction(1), 0);

% Plot perpendicular line as dotted
perpendicular_slope = -LDA_direction(1)/LDA_direction(2);
refline(perpendicular_slope, 0);
h = findobj(gca,'Type','line');
set(h(1),'LineStyle','--');

xlabel('Standardized Pressure');
ylabel('Standardized Temperature');
title('Standardized Data with LDA');
legend('acrylic', 'steal vase', 'acrylic Mean','steal vase Mean', 'LDA Line', 'Separation line');
hold off;




%%%VibrationTemperature

% Standardize the data
standardizedData = zscore(Vibrationtemperature);

% Labels
labels = zeros([20,1]);
labels(1:10) = 1; % acrylic
labels(11:20) = 2; % steal vase


% Standardized Pressure vs. Vibration
X = standardizedData;
Y = labels;

% Calculate group means
m1 = mean(X(Y == 1, :));
m2 = mean(X(Y == 2, :));

% Calculate scatter matrices
S_W = zeros(2,2);
S_B = zeros(2,2);
for i = unique(Y)'
    classData = X(Y == i, :);
    S_W = S_W + cov(classData);
    S_B = S_B + (mean(classData) - mean(X))' * (mean(classData) - mean(X));
end

% Solve the eigenproblem
[eigenvectors, eigenvalues] = eig(inv(S_W) * S_B);

% Sort eigenvalues and select the largest
[~, order] = sort(diag(eigenvalues), 'descend');
eigenvectors = eigenvectors(:, order);

% Choose the top eigenvector as the LDA direction
LDA_direction = eigenvectors(:,1);


% Plot
figure;
hold on;
gscatter(X(:,1), X(:,2), Y, 'ky', '.');
% Plot the standardized means as larger filled dots
plot(m1(1), m1(2), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
plot(m2(1), m2(2), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'y');

% Plot the LDA line
refline(LDA_direction(2)/LDA_direction(1), 0);

% Plot perpendicular line as dotted
perpendicular_slope = -LDA_direction(1)/LDA_direction(2);
refline(perpendicular_slope, 0);
h = findobj(gca,'Type','line');
set(h(1),'LineStyle','--');

xlabel('Standardized Vibration');
ylabel('Standardized Temperature');
title('Standardized Data with LDA');
legend('acrylic', 'steal vase', 'acrylic Mean','steal vase Mean', 'LDA Line', 'Separation line');
hold off;


%%%%%%% B %%%%%%%%%%

%%% 3D LDA

% Standardize the data
standardizedData = zscore(data);

% Labels
labels = zeros([20,1]);
labels(1:10) = 1; % acrylic
labels(11:20) = 2; % steal vase


% Standardized Pressure vs. Vibration
X = standardizedData;
Y = labels;

% Calculate group means
m1 = mean(X(Y == 1, :));
m2 = mean(X(Y == 2, :));


% Calculate scatter matrices
S_W = zeros(3,3);
S_B = zeros(3,3);
for i = unique(Y)'
    classData = X(Y == i, :);
    S_W = S_W + cov(classData);
    S_B = S_B + (mean(classData) - mean(X))' * (mean(classData) - mean(X));
end


% Solve the eigenproblem
[eigenvectors, eigenvalues] = eig(inv(S_W) * S_B);

% Sort eigenvalues and select the largest
[~, order] = sort(diag(eigenvalues), 'descend');
eigenvectors = eigenvectors(:, order);

% Choose the top eigenvector as the LDA direction
LDA_direction = eigenvectors(:,1)


% Plot

% Assuming 'data' array and 'labels' vector are already defined as described
X = standardizedData(:, [1, 2, 3]); % Selecting Pressure, Vibration, and Temperature features


% 3D Scatter Plot
% Define RGB colors for each category
colors = zeros(size(X,1), 3); % Initialize a colors matrix
colors(labels == 1, :) = repmat([0 0 0], sum(labels == 1), 1); % Black for acrylic
colors(labels == 2, :) = repmat([1 1 0], sum(labels == 2), 1); % Yellow for steal vase

% 3D Scatter Plot using RGB colors
figure;
hold on;
h1 = scatter3(X(labels == 1,1), X(labels == 1,2), X(labels == 1,3), 36, [0 0 0], 'filled'); % Black for acrylic
h2 = scatter3(X(labels == 2,1), X(labels == 2,2), X(labels == 2,3), 36, [1 1 0], 'filled'); % Yellow for steal vase

% xlabel('Pressure');
% ylabel('Vibration');
% zlabel('Temperature');
% title('3D Scatter Plot of Objects with Black and Yellow Colors');


% Plot the standardized means as larger filled dots
plot3(m1(1), m1(2), m1(3), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
plot3(m2(1), m2(2), m2(3), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'y');

scaleFactor = 2; % Adjust this value as needed
startpoint= -1*(LDA_direction * scaleFactor);
endingPoint = LDA_direction * scaleFactor;

% Plot the line in 3D

plot3([startpoint(1), endingPoint(1)], [startpoint(2), endingPoint(2)], [startpoint(3), endingPoint(3)], 'g');

% This is a bit tricky in 3D, let's use a simple approach by defining a random vector not parallel to LDA_direction
% Given vector v
e_x = [1, 0, 0];
LDA_direction2 = cross(LDA_direction, e_x);
% 
% Scale LDA_direction2 for the ending point of the line
scaleFactor = 13; % Adjust this value as needed
startpoint= -1*(LDA_direction2 * scaleFactor);
endingPoint = LDA_direction2 * scaleFactor;

% Plot the line in 3D

plot3([startpoint(1), endingPoint(1)], [startpoint(2), endingPoint(2)], [startpoint(3), endingPoint(3)], 'b--');
grid on; % Enable grid for better visualization
xlabel('Standardized Pressure');
ylabel('Standardized Vibration');
zlabel('Standardized Temperature');
title('Standardized Data with LDA');
legend('acrylic', 'steal vase', 'acrylic Mean', 'steal vase Mean', 'LDA Direction', 'Separation Line');
hold off;

