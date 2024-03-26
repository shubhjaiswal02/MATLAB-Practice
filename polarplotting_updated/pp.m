% Ask user to browse and select an Excel file
[filename, filepath] = uigetfile({'*.xlsx','Excel Files (*.xlsx)';'*.xls','Excel 97-2003 Files (*.xls)'},'Select the Excel file');
if isequal(filename,0)
    disp('User selected Cancel');
    return;
else
    disp(['User selected ', fullfile(filepath, filename)]);
end

% Read the Excel file
data = xlsread(fullfile(filepath, filename));

% Extract data
angles = data(:);  % Flatten the data into a column vector

% Create a figure for the polar plot
figure;
ax = polaraxes;    
   
title(ax, 'Azimuth for geopointing');
% Plot iteratively with a delay of 1 second for each value
hold(ax, 'on');
 % Add legend
   
for i = 1:8:numel(angles)
    % Clear the plot after every set of 8 values
    if i > 1
        delete(findall(gcf, 'type', 'line'));
    end
    
    % Plot the new set of 8 values
    for j = i:min(i+7, numel(angles))
        polarplot(ax, deg2rad(angles(j)), 1, 'o');  % Plot the point
        if j > i
            % Connect the current point with the previous point using a dotted line
            line([deg2rad(angles(j-1)), deg2rad(angles(j))], [1, 1], 'LineStyle', '--', 'Color', 'k');
        end
        pause(1);  % Delay of 1 second between each value
    end
    
    pause(1);  % Delay of 1 second after plotting each set of 8 values
end

hold(ax, 'off');
