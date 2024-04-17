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
fig = figure;
scatter3(time(1), azimuth(1), elevation(1), 'filled', 'MarkerFaceColor', 'k');
xlabel('Time (seconds)');
ylabel('Azimuth');
zlabel('Elevation');
title('3D Scatter Plot');
hold on;

i = 2; % Start index for plotting

while i <= size(num, 1)
    % Plot current data point in black
    scatter3(time(i), azimuth(i), elevation(i), 'filled', 'MarkerFaceColor', 'k');
    
    % Connect the previous point with the current point using a dotted line
    line([time(i-1), time(i)], [azimuth(i-1), azimuth(i)], [elevation(i-1), elevation(i)], 'LineStyle', '--', 'Color', 'k');
    
    % Change color of previous point according to key column
    prev_key_index = find(unique_keys == key_column(i-1));
    scatter3(time(i-1), azimuth(i-1), elevation(i-1), [], color_map(prev_key_index,:));
    
    % Set axis limits
    xlim([min(time) max(time)]);
    ylim([min(azimuth) max(azimuth)]);
    zlim([min(elevation) max(elevation)]);
    
    % Pause for time_interval seconds
    pause(time_interval);
    
    % Check if plot window is closed
    if ~ishandle(fig)
        break;
    end
    
    i = i + 1; % Move to the next data point
end

% Add refresh button
uicontrol('Style', 'pushbutton', 'String', 'Refresh', 'Position', [20 20 70 20], 'Callback', 'refreshdata(gcf)');
