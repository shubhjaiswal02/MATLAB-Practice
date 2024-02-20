% Input: target and platform GPS coordinates, platform pitch, roll, heading,
% azimuth and elevation angles, measured sensor LOS x-target offset, and
% measured sensor LOS y-target offset
% Output: azimuth and elevation angles for perfect pointing

% Convert target and platform GPS locations to x, y, z vectors in the ECEF frame
target_ecef = lla2ecef(target_llh);
platform_ecef = lla2ecef(platform_llh);

% Calculate the measured range or calculated distance between target and platform GPS coordinates
range = norm(target_ecef - platform_ecef);

% Calculate the LOS pointing vector in the ECEF frame
los_ecef = (target_ecef - platform_ecef) / range;

% Rotate the LOS ECEF pointing vector into a platform frame x, y, z vector
gimbal_dcm = [cosd(beta)*cosd(alpha), -sind(alpha), sind(beta)*cosd(alpha);
              cosd(beta)*sind(alpha), cosd(alpha), sind(beta)*sind(alpha);
              -sind(beta), 0, cosd(beta)];
los_gimbal = gimbal_dcm * los_ecef';

% Rotate the LOS gimbal pointing vector into a platform frame x, y, z vector
platform_dcm = [cosd(psi)*cosd(theta), cosd(psi)*sind(theta)*sind(omega)-sind(psi)*cosd(omega), cosd(psi)*sind(theta)*cosd(omega)+sind(psi)*sind(omega);
                sind(psi)*cosd(theta), sind(psi)*sind(theta)*sind(omega)+cosd(psi)*cosd(omega), sind(psi)*sind(theta)*cosd(omega)-cosd(psi)*sind(omega);
                -sind(theta), cosd(theta)*sind(omega), cosd(theta)*cosd(omega)];
los_platform = platform_dcm * los_gimbal;

% Solve for the azimuth and elevation angles that satisfy the perfect pointing equality
azimuth = atan2(los_platform(2), los_platform(1)) - delta_x * IFOV_sensor;
elevation = atan2(los_platform(3), sqrt(los_platform(1)^2 + los_platform(2)^2)) - delta_y * IFOV_sensor;