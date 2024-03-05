function plot2()

    % Load Excel data
    [file, path] = uigetfile('*.xlsx', 'Select Excel file');
    if file == 0
        disp('No file selected.');
        return;
    end
    filename = fullfile(path, file);
    data = xlsread(filename);

    % Create figure and UI elements
    fig = figure('Name', 'Real-time Plot from Excel');
    ax = axes('Parent', fig, 'Position', [0.1, 0.3, 0.8, 0.6]);
    btnReset = uicontrol('Style', 'pushbutton', 'String', 'Reset', ...
        'Units', 'normalized', 'Position', [0.1, 0.1, 0.2, 0.1], ...
        'Callback', @(~,~) resetPlot());
    chkCol1 = uicontrol('Style', 'checkbox', 'String', 'Column 1', ...
        'Units', 'normalized', 'Position', [0.4, 0.1, 0.1, 0.1]);
    chkCol2 = uicontrol('Style', 'checkbox', 'String', 'Column 2', ...
        'Units', 'normalized', 'Position', [0.5, 0.1, 0.1, 0.1]);
    chkCol3 = uicontrol('Style', 'checkbox', 'String', 'Column 3', ...
        'Units', 'normalized', 'Position', [0.6, 0.1, 0.1, 0.1]);
    chkCol4 = uicontrol('Style', 'checkbox', 'String', 'Column 4', ...
        'Units', 'normalized', 'Position', [0.7, 0.1, 0.1, 0.1]);
    
    % Initialize plot
    plotHandle = plot(ax, nan, nan);
    xlabel(ax, 'X Axis');
    ylabel(ax, 'Y Axis');
    title(ax, 'Real-time Plot from Excel');
    
    % Set callback for checkbox and reset button
    set(chkCol1, 'Callback', @(~,~) updatePlot());
    set(chkCol2, 'Callback', @(~,~) updatePlot());
    set(chkCol3, 'Callback', @(~,~) updatePlot());
    set(chkCol4, 'Callback', @(~,~) updatePlot());
    set(btnReset, 'Callback', @(~,~) resetPlot());

    % Function to update the plot
    function updatePlot()
        % Get selected columns
        selectedCols = [chkCol1.Value, chkCol2.Value, chkCol3.Value, chkCol4.Value];
        selectedCols = find(selectedCols);
        
        % Check if exactly 2 columns are selected
        if numel(selectedCols) ~= 2
            msgbox('Please select exactly 2 columns.', 'Error', 'error');
            return;
        end

        % Extract data from selected columns
        colX = data(:, selectedCols(1));
        colY = data(:, selectedCols(2));

        % Plot the selected data
        for i = 1:length(colX)
            set(plotHandle, 'XData', colX(1:i), 'YData', colY(1:i));
            xlabel(ax, ['Column ', num2str(selectedCols(1))]);
            ylabel(ax, ['Column ', num2str(selectedCols(2))]);
            title(ax, 'Real-time Plot from Excel');
            drawnow; % Update the plot
            pause(1); % Pause for 1 second
        end
    end

    % Function to reset the plot
    function resetPlot()
        set(plotHandle, 'XData', nan, 'YData', nan);
        xlabel(ax, 'X Axis');
        ylabel(ax, 'Y Axis');
        title(ax, 'Real-time Plot from Excel');
    end

end
