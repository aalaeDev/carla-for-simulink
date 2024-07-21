function freePort = findClosestFreePort(startPort)
    % Function to find the closest free TCP port starting from a given port
    % Input:
    %   startPort - Starting port number to check (e.g., 8080)
    % Output:
    %   freePort - Closest free port number

    port = startPort;
    while true
        if ~checkPortInUse(port)
            freePort = port;
            return;
        end
        port = port + 1;
    end
end