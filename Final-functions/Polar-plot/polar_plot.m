% Prompt the user for input
angle_degrees = input('Enter an angle in degrees: ');

% Convert angle from degrees to radians
angle_radians = deg2rad(angle_degrees);

% Create a polar plot
theta = linspace(0, 2*pi, 360); % angles from 0 to 360 degrees
rho = ones(size(theta)); % set the radius to 1 for all angles
polarplot(theta, rho);

hold on;

% Plot the user input angle
polarplot(angle_radians, 1, 'ro', 'MarkerSize', 10); % 'ro' for red circles

% Add a legend
legend('Angles', 'Your Input');

hold off;
