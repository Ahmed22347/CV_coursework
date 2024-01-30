%% Task 1 Q3 %%

% Specify the file path
filePath = 'C:\Users\3ahme\Documents\Computer Vision\F0_PVT.mat'; % Update with your actual file path

% Load the PVT data
load(filePath); % This will load the data from the specified file

% Assuming the data is stored in a cell array named 'dataVectors'
% with Pressure in column 1, Vibration in column 2, Temperature in column 3

% Define colors for the six unique objects
colors = [0 0 1;        %blue
          0 0 0;        % Black
          1 1 0;        % Yellow
          0.5 0 0.5;    % Purple
          0 1 0;        % Green
          1 0 0];       % Red

% Create the 3D scatter plot
figure;
hold on; % Hold on to plot multiple sets of data in the same figure
for i = 1:6 % Loop over the six unique objects
    % Extract the rows for each object
    rows = (i-1)*10 + (1:10);

    % Convert cell to numeric array for scatter3
    x = cell2mat(dataVectors(rows, 1));
    y = cell2mat(dataVectors(rows, 2));
    z = cell2mat(dataVectors(rows, 3));
    
    scatter3(x, y, z, 36, colors(i,:), 'filled');
end
hold off;

% Label the axes
xlabel('Pressure');
ylabel('Vibration');
zlabel('Temperature');

% Optionally, add a legend
legend('acrylic', 'black foam', 'car sponge', 'flour sack', 'kitchen sponge', 'Steel vase');

% Provide a title
title('3D Scatter Plot of PVT Data');

% Adjust the view angle for better 3D visualization
view(3); % Sets the default 3D view
% Add grid lines
grid on;
