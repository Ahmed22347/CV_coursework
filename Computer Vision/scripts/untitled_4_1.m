%%%%%% Task 4 Q1 %%%% 
filePath = '..\..\Computer Vision\output_files\F0_PVT.mat'; % Update with your actual file path

% Load the PVT data
load(filePath); % Load file

data_ = cell2mat(dataVectors);
X=data_;
% Compute Euclidean distances between points
Y = pdist(X, 'euclidean');
% Perform hierarchical clustering
Z = linkage(Y, 'single'); % 

% Plot the hierarchical clustering as a dendrogram
figure;
dendrogram(Z);
title('Hierarchical Clustering Dendrogram');
xlabel('Sample index');
ylabel('Distance');

% Cut the dendrogram to form clusters
T = cluster(Z, 'maxclust', 6); % For example, to divide data into 4 clusters
% Plot the clusters in 3D
figure;
%colors = lines(max(T)); % Generate a colormap with a distinct color for each cluster
colors = [0.5 0 0.5;        %blue purple
          0 0 0;        % Black
          1 1 0;        % Yellow
          0 0 1;    % Purple blue
          0 1 0;        % Green
          1 0 0];       % Red
% Map cluster indices to custom colors
colorMap = colors(T, :);
scatter3(X(:,1), X(:,2), X(:,3), 100, colorMap, 'filled'); % Map T to colors

title('3D Data Clusters');
xlabel('Pressure');
ylabel('Vibration');
zlabel('Temperature');
grid on;
view(3); % Adjust the viewing angle for better visualization
