target_lat = 100;  
target_lon = 500;  
target_alt = 100;  

platform_lat = 100;  
platform_lon = 500;  
platform_alt = 500; 

[azimuth, elevation] = geo_pointing(target_lat, target_lon, target_alt, platform_lat, platform_lon, platform_alt);

disp(['Azimuth Angle: ', num2str(rad2deg(azimuth)), ' degrees']);
disp(['Elevation Angle: ', num2str(rad2deg(elevation)), ' degrees']);
