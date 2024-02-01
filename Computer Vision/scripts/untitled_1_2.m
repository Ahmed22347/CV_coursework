%%Task 1 Q2 %%

% Specify the folder containing the MAT files
folderPath = '..\..\Computer Vision\PR_CW_DATA\PR_CW_DATA_2021';

% Get a list of all MAT files in the folder
matFiles = dir(fullfile(folderPath, '*.mat'));

% Initialize an empty cell array to store data vectors
dataVectors = cell(60, 3);
dataVectors_electrodes = cell(60,19);   
timeinstance = 5

for i = 1:numel(matFiles)
    filePath = fullfile(folderPath, matFiles(i).name);
    
    try
        data = load(filePath);
        
        if isfield(data, 'F0pdc') && isfield(data, 'F0pac') && isfield(data, 'F0tdc')
            dataVectors{i,1} = data.F0pdc(timeinstance); % Ensure it is a column vector
            %First column Pressure
            
            dataVectors{i,2} = data.F0pac(2, timeinstance); %Vibrations
          
            dataVectors{i,3} = data.F0tdc(timeinstance); %temperature third column

            dataVectors_electrodes(i,1:19) = num2cell(data.F0Electrodes(:, timeinstance));
        else
            fprintf('Error: Missing required fields in file: %s\n', filePath);
        end
    catch exception
        fprintf('Error loading data from file: %s\n', filePath);
        fprintf('Error message: %s\n', exception.message);
    end
end
% Specify the file name for the MAT-file
outputFileName = 'F0_PVT.mat';

%change filepath
outputFilePath = fullfile('..\..\Computer Vision\output_files', outputFileName);

% Save the dataVectors variable to a MAT-file
save(outputFilePath, 'dataVectors');

% Specify the file name for the MAT-file
outputFileName = 'F0_Electrodes.mat';

%change filepath
outputFilePath = fullfile('..\..\Computer Vision\output_files', outputFileName);

% Save the dataVectors variable to a MAT-file
save(outputFilePath, 'dataVectors_electrodes');
