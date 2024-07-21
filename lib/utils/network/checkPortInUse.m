function isPortInUse = checkPortInUse(port)
    % Function to check if a specific TCP port is in use on the local machine
    % Input:
    %   port - Port number to check (e.g., 8080)
    % Output:
    %   isPortInUse - Boolean indicating if the port is in use (true) or not (false)

    isPortInUse = false;
    
    % Use the netstat command to check for active connections on the specified port
    [~, result] = system(sprintf('netstat -aon | find ":%d"', port));
    
    % Check if the result contains any lines
    if contains(result, sprintf(':%d', port))
        isPortInUse = true;
    end
end
