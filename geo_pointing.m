function [azimuth, elevation] = geo_pointing(target_lat, target_lon, target_alt, platform_lat, platform_lon, platform_alt)
    % Convert target and platform coordinates to ECEF frame
    target_ecef = lla2ecef([target_lat, target_lon, target_alt]);
    platform_ecef = lla2ecef([platform_lat, platform_lon, platform_alt]);

    % Calculate range between target and platform
    range = norm(target_ecef - platform_ecef);

    % Calculate LOS pointing vector in ECEF frame
    los_vector_ecef = (target_ecef - platform_ecef) / range;

    % Rotate LOS ECEF pointing vector into platform frame
    % Assuming platform frame is aligned with the ECEF frame initially
    los_vector_platform = los_vector_ecef;

    % Solve for azimuth and elevation angles
    azimuth = atan2(los_vector_platform(2), los_vector_platform(1)); % azimuth angle
    elevation = atan2(los_vector_platform(3), sqrt(los_vector_platform(1)^2 + los_vector_platform(2)^2)); % elevation angle
end