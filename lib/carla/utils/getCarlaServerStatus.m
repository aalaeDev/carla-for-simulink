function isRunning = getCarlaServerStatus(port)
    arguments
        port uint16
    end

    isPortInUse = checkPortInUse(port);
    
    if ~isPortInUse
        isRunning = false;
        return;
    end
    
    % Check if a CarlaPID Already exists in the workspace
    exists = evalin('base', sprintf('exist(''%s'', ''var'') == 1', 'CarlaProcessID'));
    
    if ~exists
        isRunning = false;
        return;
    end
    
    % Check if the Carla Server is still running
    CarlaPID =  evalin('base', 'CarlaProcessID');
    isRunning = isProcessRunning(CarlaPID);
    
    if ~isRunning
        isRunning = false;
        return;
    end
    
    % Check if the Carle Server is running in the given port
    client = py.carla.Client('localhost', port);
    try
        client.get_world();
        isRunning = true;
    catch 
        isRunning = false;
    end
end