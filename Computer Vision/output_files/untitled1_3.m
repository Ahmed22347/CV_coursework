%%Task 1 Q3 %%

% Specify the file path
filePath = 'C:\Users\3ahme\Documents\Computer Vision\F0_PVT.mat'; % Update with your actual file path

% Load the PVT data
load(filePath); % This will load the data from the specified file

% Assuming the data is stored in arrays named 'Pressure', 'Vibration', and 'Temperature'
% and there's a variable 'Objects' indicating the object each data point belongs to


% Define colors for the six unique objects
% You can choose different colors as per your preference
colors = [1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1]; % Red, Green, Blue, Yellow, Magenta, Cyan

% Create the 3D scatter plot
figure;
hold on; % Hold on to plot multiple sets of data in the same figure
for i = 1:6 % Loop over the six unique objects
    % Logical indexing to select data for each object
    idx = Objects == i;
    scatter3(Pressure(idx), Vibration(idx), Temperature(idx), 36, colors(i,:), 'filled');
end
hold off;

% Label the axes
xlabel('Pressure');
ylabel('Vibration');
zlabel('Temperature');

% Optionally, add a legend
legend('Object 1', 'Object 2', 'Object 3', 'Object 4', 'Object 5', 'Object 6');

% Provide a title
title('3D Scatter Plot of PVT Data');
