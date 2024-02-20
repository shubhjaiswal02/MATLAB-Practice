% Test case
target_lat = 37.7749;  % Target latitude in degrees
target_lon = -122.4194;  % Target longitude in degrees
target_alt = 100;  % Target altitude in meters

platform_lat = 37.7749;  % Platform latitude in degrees
platform_lon = -122.4194;  % Platform longitude in degrees
platform_alt = 0;  % Platform altitude in meters

sensor_angles = [0, 0,0];  % Sensor angles (roll, pitch, yaw) in radians

% Call the function to get azimuth and elevation angles
[azimuth, elevation] = final_geo_pointing(target_lat, target_lon, target_alt, platform_lat, platform_lon, platform_alt, sensor_angles);

% Display the results
disp(['Azimuth Angle: ', num2str(rad2deg(azimuth)), ' degrees']);
disp(['Elevation Angle: ', num2str(rad2deg(elevation)), ' degrees']);
