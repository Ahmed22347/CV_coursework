%% Task 2 Q1 %%

%%%%%  A %%%%%%
% Specify the file path
filePath = '..\..\Computer Vision\output_files\F0_PVT.mat'; % Update with your actual file path

% Load the PVT data
load(filePath); % This will load the data from the specified file


%Standardize the Data
standardised_data = zscore(cell2mat(dataVectors));

% Step 3: Calculate the Covariance Matrix
cov_matrix = cov(standardised_data);

% Step 4: Find Eigenvalues and Eigenvectors
[eigenvectors, eigenvalues] = eig(cov_matrix);

% The diagonal of eigenvalues matrix contains the eigenvalues
eigenvalues = diag(eigenvalues);

% Step 5: Report the Results
disp('Covariance Matrix:');
disp(cov_matrix);
disp('Eigenvalues:');
disp(eigenvalues);
disp('Eigenvectors:');
disp(eigenvectors);

%%%%  B  %%%%%
% Standardize the Data
standardised_data = zscore(cell2mat(dataVectors));

% Perform PCA
[coeff, score, ~] = pca(standardised_data);

colors = [0 0 1;        %blue
          0 0 0;        % Black
          1 1 0;        % Yellow
          0.5 0 0.5;    % Purple
          0 1 0;        % Green
          1 0 0];       % Red
figure;
hold on;

for i = 1:6
    % Selecting the data for each object
    object_data = standardised_data((i-1)*10 + 1:i*10, :);

    % Plotting the data
    scatter3(object_data(:,1), object_data(:,2), object_data(:,3), 'filled','MarkerFaceColor', colors(i,:));
end

% Step 4: Overlay the Principal Components
% Adjust the scale factor as needed
scale_factor = 4;
quiver3(mean(standardised_data(:,1)), mean(standardised_data(:,2)), mean(standardised_data(:,3)), scale_factor*coeff(1,1), scale_factor*coeff(2,1), scale_factor*coeff(3,1), 'k', 'LineWidth', 2);
quiver3(mean(standardised_data(:,1)), mean(standardised_data(:,2)), mean(standardised_data(:,3)), scale_factor*coeff(1,2), scale_factor*coeff(2,2), scale_factor*coeff(3,2), 'k', 'LineWidth', 2);

% Adding labels and title for clarity
xlabel('Pressure');
ylabel('Vibration');
zlabel('Temerature');
title('Standardized Data with Principal Components');
grid on;
hold off;



%% 
%%%%%  C %%%%%%

% Reduce the Data to 2 Dimensions
reduced_data = score(:, 1:2);
figure;
hold on;

for i = 1:6
    % Selecting the data for each object
    object_data = reduced_data((i-1)*10 + 1:i*10, :);

    % Plotting the data
    scatter(object_data(:,1), object_data(:,2), 'filled', 'MarkerFaceColor', colors(i,:));
end

% Adding labels and title for clarity
xlabel('Principal Component 1');
ylabel('Principal Component 2');
title('2D PCA of Standardized Data with Different Objects');
grid on;
hold off;

%%%%%  D %%%%%%


% Number of Principal Components
numPCs = size(score, 2);

% Step 3: Create Separate 1D Plots for Each Principal Component
for i = 1:numPCs
    figure; % Create a new figure for each principal component
    hold on;

    for j = 1:6
        % Selecting the data for each object
        object_data = score((j-1)*10 + 1:j*10, i);

        % Plotting the data for each object in its respective color
        scatter(object_data, zeros(size(object_data)), 36, colors(j,:), 'filled');
    end

    % Adding labels and title for clarity
    xlabel(['Principal Component ', num2str(i)]);
    title(['Distribution along Principal Component ', num2str(i)]);
    grid on;
    hold off;
end