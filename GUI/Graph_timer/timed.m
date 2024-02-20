% Browse and select the .xlsx file
[file, path] = uigetfile('*.xlsx', 'Select the Excel file');
if isequal(file, 0)
    disp('No file selected.');
    return;
end
filename = fullfile(path, file);

% Load data from the selected .xlsx file
data = xlsread(filename);

% Extracting columns from the data
column1 = data(:, 1);
column2 = data(:, 2);
column3 = data(:, 3);
column4 = data(:, 4);

% Set up the figure for plotting
figure;
xlabel('X-axis');
ylabel('Y-axis');
title('Real-time Plot');
grid on;
hold on;

% Create checkboxes for column selection
uicontrol('Style', 'checkbox', 'String', 'Column 1', 'Value', 1, ...
    'Position', [10 50 100 20]);
uicontrol('Style', 'checkbox', 'String', 'Column 2', 'Value', 1, ...
    'Position', [110 50 100 20]);
uicontrol('Style', 'checkbox', 'String', 'Column 3', 'Value', 1, ...
    'Position', [210 50 100 20]);
uicontrol('Style', 'checkbox', 'String', 'Column 4', 'Value', 1, ...
    'Position', [310 50 100 20]);

% Get handles to the checkboxes
checkboxes = findobj('Style', 'checkbox');

% Plot the data points one by one with a 1-second interval
for row = 1:size(data, 1)
    % Clear the plot
    clf;
    
    % Plot the data points based on checkbox selection
    for col = 1:numel(checkboxes)
        if get(checkboxes(col), 'Value')
            plot(data(row, 2*col-1), data(row, 2*col), 'o', 'MarkerFaceColor', 'auto', 'MarkerEdgeColor', 'auto');
            hold on;
        end
    end
    
    % Set plot properties
    xlabel('X-axis');
    ylabel('Y-axis');
    title('Real-time Plot');
    grid on;
    legendInfo = {};
    for col = 1:numel(checkboxes)
        if get(checkboxes(col), 'Value')
            legendInfo = [legendInfo, sprintf('Column %d', col)];
        end
    end
    legend(legendInfo);
    
    % Adjust the axes limits to accommodate the data
    xlim([min(data(:, 1:2:end)), max(data(:, 1:2:end))]);
    ylim([min(data(:, 2:2:end)), max(data(:, 2:2:end))]);
    
    % Pause for 1 second before plotting the next row
    pause(1);
end
