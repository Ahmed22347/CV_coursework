%%Task 1 Q1 %%

% Specify the folder containing the MAT files
folderPath = '..\..\Computer Vision\PR_CW_DATA\PR_CW_DATA_2021';

% Get a list of all MAT files in the folder
matFiles = dir(fullfile(folderPath, '*.mat'));

% Initialize an empty cell array to store data vectors
dataVectors = cell(1, 8);
k=cell(1,2);
j=0;
h=1;
% Loop through each MAT file and import the 1D array
for i = 9:50:60
    % Construct the full file path
    filePath = fullfile(folderPath, matFiles(i).name);
    k{h}=i
    h=h+1
    try
        % Load the MAT file
        data = load(filePath);
        j=j+1;
        
        % Modify the variable name accordingly based on your actual data structure
        dataVectors{j} = data.F0pdc(:); % Ensure it is a column vector
        dataVectors{j+1} = data.F0tdc(:);
        dataVectors{j+2} = data.F0Electrodes(5,:);
        dataVectors{j+3} = data.F0pac(10,:);
        j=j+3;
    catch
        fprintf('Error loading data from file: %s\n', filePath);
        continue;
    end
end

% Plotting the data from each 1D array on the same graph
figure;
hold on;

for i = 1:8
    colors = {'r', 'b', 'g', 'k'};  % Define an array of colors

    if i < 5
        if i == 1
            plot(dataVectors{i}, 'DisplayName', sprintf('%s Pressure', matFiles(k{1}).name), 'Color', colors{i});
        elseif i == 2
            plot(dataVectors{i}, 'DisplayName', sprintf('%s Temperature', matFiles(k{1}).name), 'Color', colors{i});
        elseif i == 3
            plot(dataVectors{i}, 'DisplayName', sprintf('%s Electrodes', matFiles(k{1}).name), 'Color', colors{i});
        else % i == 4
            plot(dataVectors{i}, 'DisplayName', sprintf('%s Vibrations', matFiles(k{1}).name), 'Color', colors{i});
        end
    else
        % Calculate the color index for i values from 5 to 8
        colorIndex = mod(i - 5, numel(colors)) + 1;
        if i == 5
            plot(dataVectors{i}, 'DisplayName', sprintf('%s Pressure', matFiles(k{2}).name), 'LineStyle', '--', 'Color', colors{colorIndex});
        elseif i == 6
            plot(dataVectors{i}, 'DisplayName', sprintf('%s Temperature', matFiles(k{2}).name), 'LineStyle', '--', 'Color', colors{colorIndex});
        elseif i == 7
            plot(dataVectors{i}, 'DisplayName', sprintf('%s Electrodes', matFiles(k{2}).name), 'LineStyle', '--', 'Color', colors{colorIndex});
        else % i == 8
            plot(dataVectors{i}, 'DisplayName', sprintf('%s Vibrations', matFiles(k{2}).name), 'LineStyle', '--', 'Color', colors{colorIndex});
        end
    end
end



hold off;

% Adding labels and legend
xlabel('Time');
ylabel('Data Value');
title('Sensor data of two objects');
legend('Location', 'best');
