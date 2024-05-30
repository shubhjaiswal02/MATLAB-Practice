% parseAVRData.m
% Function to parse AVR formatted data and return key-value pairs as a structure

function dataStruct = parseAVRData(data)
    % Initialize an empty structure
    dataStruct = struct();
    
    % Split data into lines
    lines = textscan(data, '%s', 'Delimiter', '\n');
    lines = lines{1};  % Extract cell array from textscan output
    
    % Loop through each line
    for i = 1:length(lines)
        line = lines{i};
        if ~isempty(line)
            % Remove braces and split the line into key-value pairs
            line = strrep(line, '{', '');
            line = strrep(line, '}', '');
            keyValuePairs = textscan(line, '%s', 'Delimiter', ';');
            keyValuePairs = keyValuePairs{1};  % Extract cell array from textscan output
            
            % Loop through each key-value pair
            for j = 1:length(keyValuePairs)
                keyValue = keyValuePairs{j};
                if ~isempty(keyValue)
                    % Split key-value pair
                    kv = textscan(keyValue, '%s', 'Delimiter', ':');
                    kv = kv{1};  % Extract cell array from textscan output
                    if length(kv) == 2
                        key = strtrim(kv{1});
                        value = strtrim(kv{2});
                        
                        % Remove quotes from key and value
                        key = strrep(key, '"', '');
                        value = strrep(value, '"', '');
                        
                        % Convert value to number if possible
                        numValue = str2double(value);
                        if ~isnan(numValue)
                            value = numValue;
                        end
                        
                        % Store in structure
                        dataStruct.(key) = value;
                    end
                end
            end
        end
    end
end
