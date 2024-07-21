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

    % Get vehicles List
%     vehiclesList = jsondecode(fileread(config.VehiclesDbPath));
%     vehicleName = get_param(launchCarlaBlk, 'Vehicle');
%     simConfig.vehicle = vehiclesList.(findFieldByValue(vehiclesList, 'name', vehicleName)).blueprint_id;

    % Retrieve parameters from the model
    launchCarlaBlk = [mdl '/' LAUNCH_CARLA_BLK_NAME];
    simConfig.port = uint16(str2double(get_param(launchCarlaBlk, 'Port')));
    simConfig.path = get_param(launchCarlaBlk, 'CarlaPath');
    simConfig.screen.width = get_param(launchCarlaBlk, 'Width');
    simConfig.screen.height = get_param(launchCarlaBlk, 'Height');
    simConfig.mode = get_param(launchCarlaBlk, 'SimulationMode');
    simConfig.quality = get_param(launchCarlaBlk, 'Quality');
    simConfig.map = get_param(launchCarlaBlk, 'Map');
end