function realTimePlotFromExcel(filename)
    % Read data from Excel file
    data = xlsread("book1.xlsx");
    
    % Extract columns
    col1 = data(:, 1);
    col2 = data(:, 2);
    
    % Create the figure and axes
    fig = figure;
    ax = axes('Parent', fig);
    plotHandle = plot(ax, col1(1), col2(1), 'o-');
    xlabel('X Axis');
    ylabel('Y Axis');
    title('Real-time Plot from Excel');
    xlim([min(col1), max(col1)]);
    ylim([min(col2), max(col2)]);
    
    % Set up the timer
    t = timer('ExecutionMode', 'fixedRate', 'Period', 1.5, ...
        'TimerFcn', @(~,~) updatePlot(ax, plotHandle, col1, col2));
    start(t);

    % Function to update the plot
    function updatePlot(ax, plotHandle, col1, col2)
        persistent currentIndex
        if isempty(currentIndex)
            currentIndex = 1;
        end
        
        % Check if there are still data points to plot
        if currentIndex <= length(col1)
            % Update plot with next data point
            set(plotHandle, 'XData', col1(1:currentIndex), 'YData', col2(1:currentIndex));
            drawnow limitrate; % Update the plot
            currentIndex = currentIndex + 1;
        else
            % Stop the timer if all data points have been plotted
            stop(t);
            delete(t);
            disp('Real-time plot complete.');
        end
    end
end
