% main.m
% Main script to read data from Stratux ADS-B receiver

% Define the IP address and port number
ipAddress = '192.168.10.1';
portNumber = 30003;

% Create a TCP/IP object
t = tcpip(ipAddress, portNumber);

% Set properties
set(t, 'InputBufferSize', 30000); % Adjust buffer size as needed

% Open the connection
fopen(t);

% Check if the connection is open
if strcmp(get(t, 'Status'), 'open')
    disp('Connection established successfully');
else
    error('Failed to establish connection');
end

% Continuously read data from the Stratux receiver
while true
    % Check if data is available
    if get(t, 'BytesAvailable') > 0
        % Read data from the receiver
        data = fscanf(t);
        
        % Process the data to extract key-value pairs
        dataStruct = parseAVRData(data);
        
        % Display specific keys if they exist
        if isfield(dataStruct, 'Altitude')
            altitude = dataStruct.Altitude;
        else
            altitude = NaN;
        end
        
        if isfield(dataStruct, 'Speed')
            speed = dataStruct.Speed;
        else
            speed = NaN;
        end
        
        fprintf('Altitude: %.2f, Speed: %.2f\n', altitude, speed);
        
        % Optional: add your own logic to use other keys here
    end
    
    % Pause for a short period to avoid overwhelming the CPU
    pause(0.1);
end

% Close the connection when done
fclose(t);
delete(t);
clear t;
