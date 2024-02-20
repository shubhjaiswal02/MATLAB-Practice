% Define platform coordinates (x, y, z)
platform_coords = [0, 0,0 ]; % Platform at the origin

% Define sensor angles (roll, pitch, yaw)
sensor_angles = [0, 0, 0]; % Sensor aligned with the platform

% Define target coordinates (x, y, z)
target_coords = [100,100, 0]; % Target at (100, 100, 100)

% Calculate sensor pointing
[azimuth, elevation] = calculate_sensor_pointing(platform_coords, sensor_angles, target_coords);

% Display the results
disp(['Azimuth Angle: ', num2str(rad2deg(azimuth)), ' degrees']);
disp(['Elevation Angle: ', num2str(rad2deg(elevation)), ' degrees']);
