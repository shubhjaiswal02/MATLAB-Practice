% Example usage of the function
target_lat = 39.7749; % Target latitude
target_lon = -2.4194; % Target longitude
target_alt = 4; % Target altitude
platform_lat = 17.7749; % Platform latitude
platform_lon = 125.4194; % Platform longitude
platform_alt = 35; % Platform altitude
sensor_angles = [4  , 45    , 2]; % Sensor angles (roll, pitch, yaw)

% Call the function to get azimuth and elevation angles
[azimuth, elevation] = final_geo_pointing(target_lat, target_lon, target_alt, platform_lat, platform_lon, platform_alt, sensor_angles);

% Create a polar plot for azimuth
polarplot(deg2rad(azimuth), ones(size(azimuth)), 'ro', 'MarkerSize', 5);
hold on;

% Create a polar plot for elevation
polarplot(deg2rad(elevation), ones(size(elevation)), 'bo', 'MarkerSize', 5);

% Add legend
legend('Azimuth', 'Elevation');

hold off;
