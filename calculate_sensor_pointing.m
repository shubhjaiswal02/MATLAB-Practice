function [azimuth, elevation] = calculate_sensor_pointing(platform_coords, sensor_angles, target_coords)
    % Extract platform coordinates (x, y, z)
    x_p = platform_coords(1);
    y_p = platform_coords(2);
    z_p = platform_coords(3);
    
    % Extract sensor angles (roll, pitch, yaw)
    roll = sensor_angles(1);
    pitch = sensor_angles(2);
    yaw = sensor_angles(3);
    
    % Extract target coordinates (x, y, z)
    x_t = target_coords(1);
    y_t = target_coords(2);
    z_t = target_coords(3);
    
    % Calculate LOS vector from platform to target
    los_vector = [x_t - x_p; y_t - y_p; z_t - z_p];
    
    % Define rotation matrices for sensor attitude
    R_roll = [1, 0, 0; 0, cos(roll), -sin(roll); 0, sin(roll), cos(roll)];
    R_pitch = [cos(pitch), 0, sin(pitch); 0, 1, 0; -sin(pitch), 0, cos(pitch)];
    R_yaw = [cos(yaw), -sin(yaw), 0; sin(yaw), cos(yaw), 0; 0, 0, 1];
    
    % Combine rotation matrices to get the total rotation matrix
    R_total = R_yaw * R_pitch * R_roll;
    
    % Rotate LOS vector into sensor frame
    los_vector_sensor_frame = R_total' * los_vector;
    
    % Calculate azimuth and elevation angles
    azimuth = atan2(los_vector_sensor_frame(2), los_vector_sensor_frame(1)); % azimuth angle
    elevation = atan2(los_vector_sensor_frame(3), sqrt(los_vector_sensor_frame(1)^2 + los_vector_sensor_frame(2)^2)); % elevation angle
end
