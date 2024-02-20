function [azimuth, elevation] = final_geo_pointing(target_lat, target_lon, target_alt, platform_lat, platform_lon, platform_alt, sensor_angles)
    % Convert target and platform coordinates to ECEF frame
    target_ecef = lla2ecef([target_lat, target_lon, target_alt]);
    platform_ecef = lla2ecef([platform_lat, platform_lon, platform_alt]);

    % Calculate range between target and platform
    range = norm(target_ecef - platform_ecef);

    % Calculate LOS pointing vector in ECEF frame
    los_vector_ecef = (target_ecef - platform_ecef) / range;

     % Extract sensor angles (roll, pitch, yaw)
    roll = sensor_angles(1);
    pitch = sensor_angles(2);
    yaw = sensor_angles(3);
    
    % Define rotation matrices for sensor attitude
    R_roll = [1, 0, 0; 0, cos(roll), -sin(roll); 0, sin(roll), cos(roll)];
    R_pitch = [cos(pitch), 0, sin(pitch); 0, 1, 0; -sin(pitch), 0, cos(pitch)];
    R_yaw = [cos(yaw), -sin(yaw), 0; sin(yaw), cos(yaw), 0; 0, 0, 1];
    
    % Combine rotation matrices to get the total rotation matrix
    R_total = R_yaw * R_pitch * R_roll;
    
    % Rotate LOS vector into sensor frame
    los_vector_frame = R_total' .* los_vector_ecef;

    % Calculate azimuth and elevation angles
    azimuth = atan2(los_vector_frame(2), los_vector_frame(1)); % azimuth angle
    elevation = atan2(los_vector_frame(3), sqrt(los_vector_frame(1)^2 + los_vector_frame(2)^2)); % elevation angle
end