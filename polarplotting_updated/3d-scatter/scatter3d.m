% Prompt user to select an Excel file
[filename, pathname] = uigetfile('*.xlsx', 'Select an Excel file');
fullpath = fullfile(pathname, filename);

% Read the Excel file
data = readmatrix(fullpath);

% Extract data from the table
elevation = data(:, 1);
azimuth = data(:, 2);
time = data(:, 3);

% Define time interval between each value
time_interval = 2; % in seconds

% Create scatter plot
figure;
scatter3(time(1), azimuth(1), elevation(1), 'filled');
xlabel('Time (seconds)');
ylabel('Azimuth');
zlabel('Elevation');
title('3D Scatter Plot');

% Plot first point
hold on;

for i = 2:size(data, 1)
    % Plot current data point
    scatter3(time(i), azimuth(i), elevation(i), 'filled');
    
    % Connect the previous point with the current point using a dotted line
    line([time(i-1), time(i)], [azimuth(i-1), azimuth(i)], [elevation(i-1), elevation(i)], 'LineStyle', '--', 'Color', 'k');
    
      % Set axis limits
    xlim([0 20]);
    ylim([0 360]);
    zlim([0 360]);
    % Pause for time_interval seconds
    pause(time_interval);
end

hold off;
