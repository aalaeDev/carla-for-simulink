% Clear Everything
clc;
clear;

% Params
CONFIG_FILE = "config.json";

% Paths
paths = {'src',...
         'lib',...
         'assets'};
cellfun(@(p) addpath(genpath(p)), paths, 'UniformOutput', false);

% Load config.json
config = jsondecode(fileread(CONFIG_FILE));
[~, mdl, ~] = fileparts(config.MainModel);

% Load the model
if ~bdIsLoaded(mdl)
    Logger.info(['Loading the model "', mdl, '"...']);
    try
        open_system(config.MainModel);
        Logger.success(['"', mdl, '" is successfully loaded']);
    catch e
        Logger.error(['Failed to load "', mdl, '"']);
        disp(getReport(e));
    end
end

% Update Carla Path
launchCarlaBlk = [mdl '/' config.LaunchBlockName];
launchCarlaBlkHandle = get_param(launchCarlaBlk, 'handle');
carlaPath = fullfile(config.CarlaPath, config.CarlaLauncher);
set_param(launchCarlaBlkHandle, 'CarlaPath', ['"' carlaPath '"']);

% Check if the port is free
port = findClosestFreePort(get_param(launchCarlaBlkHandle, 'Port'));
set_param(launchCarlaBlkHandle, 'Port', port);

% Get enviroment list
loadMapsList(launchCarlaBlkHandle);
loadVehiclesList(launchCarlaBlkHandle);

clear port maskObj param;
