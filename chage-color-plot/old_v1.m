% Prompt user to select an Excel file
[filename, pathname] = uigetfile('*.xlsx', 'Select an Excel file');
fullpath = fullfile(pathname, filename);

% Read the Excel file
[num, txt, raw] = xlsread(fullpath);

% Extract data from the table
elevation = num(:, 1);
azimuth = num(:, 2);
time = num(:, 3);
key_column = num(:, 4); % Column 4 as key column

% Define time interval between each value
time_interval = 2; % in seconds

% Create a colormap for unique values in the key column
unique_keys = unique(key_column);
num_unique_keys = numel(unique_keys);
color_map = hsv(num_unique_keys);

% Create scatter plot
figure;
scatter3(time(1), azimuth(1), elevation(1), 'filled');
xlabel('Time (seconds)');
ylabel('Azimuth');
zlabel('Elevation');
title('3D Scatter Plot');
hold on;

for i = 2:size(num, 1)
    % Plot current data point with the color corresponding to its key value
    key_index = find(unique_keys == key_column(i));
    scatter3(time(i), azimuth(i), elevation(i), 'filled', 'MarkerFaceColor', color_map(key_index,:));
    
    % Connect the previous point with the current point using a dotted line
    line([time(i-1), time(i)], [azimuth(i-1), azimuth(i)], [elevation(i-1), elevation(i)], 'LineStyle', '--', 'Color', 'k');
    
    % Set axis limits
    xlim([min(time) max(time)]);
    ylim([min(azimuth) max(azimuth)]);
    zlim([min(elevation) max(elevation)]);
    
    % Pause for time_interval seconds
    pause(time_interval);
end

hold off;
