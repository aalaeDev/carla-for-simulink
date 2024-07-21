function launchCarlaServer()
    % Get config
    config = evalin('base', 'config');
    LAUNCH_CARLA_BLK_NAME = config.LaunchBlockName;
    mdl = evalin('base', 'mdl');

    % Check if the model is loaded
    if ~bdIsLoaded(mdl)
       Logger.error(['The main model"', mdl, '" is not loaded.']);
       return;
    end

    % Retrieve parameters from the model
    launchCarlaBlk = [mdl '/' LAUNCH_CARLA_BLK_NAME];
    PORT    = get_param(launchCarlaBlk, 'Port');
    PATH    = get_param(launchCarlaBlk, 'CarlaPath');
    WIDTH   = get_param(launchCarlaBlk, 'Width');
    HEIGHT  = get_param(launchCarlaBlk, 'Height');
    QUALITY = get_param(launchCarlaBlk, 'Quality');
    
    % TODO: Paramerters Validation
    
    % Check if Carla is already launched
    isRunning = getCarlaServerStatus(uint16(str2double(PORT)));
    
    if isRunning 
        Logger.warning(sprintf('A Carla Server is already running on %s', PORT));
        return;
    end
    
    % Get running Carla Processes
    prevPids = getPIDsByName(config.CarlaExecutable);
    
    % Launch Carla
    Logger.info('Launching Carla Server...');
    cmd = sprintf('%s -world-port=%s -ResX=%s -ResY=%s -quality-level=%s &',...
                  PATH, PORT, WIDTH, HEIGHT, QUALITY);
    [status, cmdout] = system(cmd);
    if status == 0
        Logger.success('Server started successfully.');
    else
        Logger.error('Failed to launch Carle Server');
        error('Failed to start server: %s', cmdout);
    end
    
    % Get lauched Carla PID
    currPids = getPIDsByName(config.CarlaExecutable);
    CarlaProcessID = currPids(~contains(currPids, prevPids));
    assignin('base', 'CarlaProcessID', uint32(str2double(CarlaProcessID{1})));
    assignin('base', 'Port', PORT);
end