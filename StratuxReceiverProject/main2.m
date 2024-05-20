% main.m
% Main script to read data from Stratux ADS-B receiver

% Define the IP address and port number
ipAddress = '192.168.10.1';
portNumber = 30003;

% Create a TCP/IP object
t = tcpip(ipAddress, portNumber);
set(t, 'NetworkRole', 'client');

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
        
        % Process the data
        parsedData = parseAVRData(data);
        
        % Display parsed data (for debugging, can be removed or modified)
        disp(parsedData);
        
        % Optional: add your own logic to use parsed data here
    end
    
    % Pause for a short period to avoid overwhelming the CPU
    pause(0.1);
end

% Close the connection when done
fclose(t);
delete(t);
clear t;
