function simConfig = getSimulationConfig()
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
    simConfig.port = uint16(str2double(get_param(launchCarlaBlk, 'Port')));
    simConfig.timeout = str2double(get_param(launchCarlaBlk, 'Timeout'));
    simConfig.path = get_param(launchCarlaBlk, 'CarlaPath');
    simConfig.screen.width = get_param(launchCarlaBlk, 'Width');
    simConfig.screen.height = get_param(launchCarlaBlk, 'Height');
    simConfig.mode = get_param(launchCarlaBlk, 'SimulationMode');
    simConfig.quality = get_param(launchCarlaBlk, 'Quality');
    simConfig.map = get_param(launchCarlaBlk, 'Map');
    simConfig.weather = get_param(launchCarlaBlk, 'Weather');
    simConfig.npcs = uint16(str2double(get_param(launchCarlaBlk, 'NPCs')));
end