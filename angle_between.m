function angle = angle_between(A, B)
    % Input: Two vectors A and B as 1x3 arrays [x, y, z]
    
    % Calculate the dot product of the two vectors
    dot_product = dot(A, B);
    
    % Calculate the magnitudes of the vectors
    magnitude_A = norm(A);
    magnitude_B = norm(B);
    
    % Calculate the cosine of the angle between the vectors
    cos_angle = dot_product / (magnitude_A * magnitude_B);
    
    % Calculate the angle in radians
    angle_radians = acos(cos_angle);
    
    % Convert the angle to degrees
    angle = rad2deg(angle_radians);
end