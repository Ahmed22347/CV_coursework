%% Task 3 Q1 %%%% 


%%%%%%% A %%%%%%%%%%

%%% PressureVibration

filePath = '..\..\Computer Vision\output_files\F0_PVT.mat'; % Update with your actual file path

% Load the PVT data
load(filePath); % This will load the data from the specified file

data_ = cell2mat(dataVectors);


data=data_(11:30,:);

% Feature pairs
pressureVibration = data(:, [1, 2]);
pressureTemperature = data(:, [1, 3]);
Vibrationtemperature = data(:, [2, 3]);

% Standardize the data
standardizedData = zscore(pressureVibration);

% Labels
labels = zeros([20,1]);
labels(1:10) = 1; % black foam
labels(11:20) = 2; % car sponge


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
legend('Black Foam', 'Car Sponge', 'Black Foam Mean','Car Sponge Mean', 'LDA Line', 'Separation line');
hold off;


%%% PressureTemperature


% Standardize the data
standardizedData = zscore(pressureTemperature);

% Labels
labels = zeros([20,1]);
labels(1:10) = 1; % black foam
labels(11:20) = 2; % car sponge


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
legend('Black Foam', 'Car Sponge', 'Black Foam Mean','Car Sponge Mean', 'LDA Line', 'Separation line');
hold off;




%%%VibrationTemperature

% Standardize the data
standardizedData = zscore(Vibrationtemperature);

% Labels
labels = zeros([20,1]);
labels(1:10) = 1; % black foam
labels(11:20) = 2; % car sponge


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
legend('Black Foam', 'Car Sponge', 'Black Foam Mean','Car Sponge Mean', 'LDA Line', 'Separation line');
hold off;


%%%%%%% B %%%%%%%%%%

%%% 3D LDA

% Standardize the data
standardizedData = zscore(data);

% Labels
labels = zeros([20,1]);
labels(1:10) = 1; % black foam
labels(11:20) = 2; % car sponge


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
colors(labels == 1, :) = repmat([0 0 0], sum(labels == 1), 1); % Black for Black Foam
colors(labels == 2, :) = repmat([1 1 0], sum(labels == 2), 1); % Yellow for Car Sponge

% 3D Scatter Plot using RGB colors
figure;
hold on;
scatter3(X(:,1), X(:,2), X(:,3), 36, colors, 'filled'); % Use the RGB colors for each point
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

LDA_direction2 = cross(LDA_direction, e_x);
% 
% Scale LDA_direction2 for the ending point of the line
scaleFactor = 13; % Adjust this value as needed
startpoint= -1*(LDA_direction2 * scaleFactor);
endingPoint = LDA_direction2 * scaleFactor;

% Plot the line in 3D

plot3([startpoint(1), endingPoint(1)], [startpoint(2), endingPoint(2)], [startpoint(3), endingPoint(3)], 'b--');
grid on; % Enable grid for better visualization
ylabel('Standardized Vibration');
zlabel('Standardized Temperature');
title('Standardized Data with LDA');
legend( 'Car Sponge', 'Black Foam Mean', 'Car Sponge Mean', 'LDA Direction', 'Separation Line');
hold off;

