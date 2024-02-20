function plotGraphGUI()
    % Create figure and UI components
    fig = figure('Name', 'Graph Plotter', 'Position', [200, 200, 600, 400]);
    ax = axes('Parent', fig, 'Position', [0.1, 0.1, 0.8, 0.7]);

    % Callback function for the Load Data button
    uicontrol('Style', 'pushbutton', 'String', 'Load Data', 'Position', [450, 350, 100, 20], 'Callback', @loadDataCallback);

    % Callback function for plotting the data
    function plotData(data, columnHeaders, selectedCols)
        xData = data(:, selectedCols(1));
        yData = data(:, selectedCols(2));
        
        plot(ax, xData, yData, '-r'); % Changed to a red solid line
        xlabel(ax, sprintf('%s', columnHeaders{selectedCols(1)}));
        ylabel(ax, sprintf('%s', columnHeaders{selectedCols(2)}));
        title(ax, 'Plot');
    end

    % Callback function for the Load Data button
    function loadDataCallback(~, ~)
        [filename, pathname] = uigetfile('*.txt', 'Select a data file');
        if filename == 0
            return;
        end
        fid = fopen(fullfile(pathname, filename), 'r');
        headerLine = fgetl(fid);
        fclose(fid);
        
        columnHeaders = strsplit(headerLine);
        
        disp('Data loaded successfully.');
        disp(size(data)); % Debugging print statement
        
        % Create checkboxes for each column
        numColumns = length(columnHeaders);
        dataCheckbox = gobjects(1, numColumns); % Initialize checkbox array
        for i = 1:numColumns
            dataCheckbox(i) = uicontrol('Style', 'checkbox', 'String', columnHeaders{i}, 'Position', [20+(i-1)*100, 350, 100, 20]);
        end
        
        uicontrol('Style', 'pushbutton', 'String', 'Plot Data', 'Position', [450, 300, 100, 20], 'Callback', {@plotDataCallback, columnHeaders});
    end

    % Callback function for the Plot Data button
    function plotDataCallback(~, ~, columnHeaders)
        selectedCols = find([dataCheckbox.Value]);
        if length(selectedCols) ~= 2
            disp('Please select exactly 2 columns for plotting.');
            return;
        end
        
        % Here you should load the actual data from the file using any
        % appropriate function such as importdata, textscan, etc.
        % For simplicity, let's assume data is a dummy matrix.
        data = magic(5);  % Replace this line with your data loading code
        
        plotData(data, columnHeaders, selectedCols);
    end
end
