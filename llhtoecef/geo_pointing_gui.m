function geo_pointing_gui()
    % Create figure
    fig = figure('Position', [200, 200, 400, 300], 'MenuBar', 'none', 'ToolBar', 'none', 'NumberTitle', 'off', 'Name', 'Geo Pointing GUI');

    % Create input boxes
    uicontrol('Style', 'edit', 'Position', [150, 240, 200, 20], 'Tag', 'target_lat', 'String', 'Target Latitude');
    uicontrol('Style', 'edit', 'Position', [150, 210, 200, 20], 'Tag', 'target_lon', 'String', 'Target Longitude');
    uicontrol('Style', 'edit', 'Position', [150, 180, 200, 20], 'Tag', 'target_alt', 'String', 'Target Altitude');
    uicontrol('Style', 'edit', 'Position', [150, 150, 200, 20], 'Tag', 'platform_lat', 'String', 'Platform Latitude');
    uicontrol('Style', 'edit', 'Position', [150, 120, 200, 20], 'Tag', 'platform_lon', 'String', 'Platform Longitude');
    uicontrol('Style', 'edit', 'Position', [150, 90, 200, 20], 'Tag', 'platform_alt', 'String', 'Platform Altitude');
    uicontrol('Style', 'edit', 'Position', [150, 60, 60, 20], 'Tag', 'roll', 'String', 'Roll');
    uicontrol('Style', 'edit', 'Position', [220, 60, 60, 20], 'Tag', 'pitch', 'String', 'Pitch');
    uicontrol('Style', 'edit', 'Position', [290, 60, 60, 20], 'Tag', 'yaw', 'String', 'Yaw');

    % Create Compute button
    uicontrol('Style', 'pushbutton', 'Position', [150, 30, 100, 20], 'String', 'Compute', 'Callback', @compute_callback);

    % Callback function for Compute button
    function compute_callback(~, ~)
        % Get input values
        target_lat = str2double(get(findobj(fig, 'Tag', 'target_lat'), 'String'));
        target_lon = str2double(get(findobj(fig, 'Tag', 'target_lon'), 'String'));
        target_alt = str2double(get(findobj(fig, 'Tag', 'target_alt'), 'String'));
        platform_lat = str2double(get(findobj(fig, 'Tag', 'platform_lat'), 'String'));
        platform_lon = str2double(get(findobj(fig, 'Tag', 'platform_lon'), 'String'));
        platform_alt = str2double(get(findobj(fig, 'Tag', 'platform_alt'), 'String'));
        roll = str2double(get(findobj(fig, 'Tag', 'roll'), 'String'));
        pitch = str2double(get(findobj(fig, 'Tag', 'pitch'), 'String'));
        yaw = str2double(get(findobj(fig, 'Tag', 'yaw'), 'String'));

        % Call the function
        [azimuth, elevation] = final_geo_pointing(target_lat, target_lon, target_alt, platform_lat, platform_lon, platform_alt, [roll, pitch, yaw]);

        % Display results
        msgbox(sprintf('Azimuth: %.2f\nElevation: %.2f', azimuth, elevation), 'Results');
    end
end

function [azimuth, elevation] = final_geo_pointing(target_lat, target_lon, target_alt, platform_lat, platform_lon, platform_alt, sensor_angles)
    % Place your function code here
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
    R_roll = [1, 0, 0; 0, cosd(roll), -sind(roll); 0, sind(roll), cosd(roll)];
    R_pitch = [cosd(pitch), 0, sind(pitch); 0, 1, 0; -sind(pitch), 0, cosd(pitch)];
    R_yaw = [cosd(yaw), -sind(yaw), 0; sind(yaw), cosd(yaw), 0; 0, 0, 1];

    % Combine rotation matrices to get the total rotation matrix
    R_total = R_yaw * R_pitch * R_roll;

    % Rotate LOS vector into sensor frame
    los_vector_frame = R_total' .* los_vector_ecef;

    % Calculate azimuth and elevation angles
    azimuth = atan2d(los_vector_frame(2), los_vector_frame(1)); % azimuth angle
    elevation = atan2d(los_vector_frame(3), sqrt(los_vector_frame(1)^2 + los_vector_frame(2)^2)); % elevation angle
end
