function maps = getAvailableCarlaMaps()
    % Get config
    config = evalin('base', 'config');

    mapsExt = "*.bin";
    binFolder = 'Nav';
    mapsPath = fullfile(config.CarlaPath, config.MapsPath, binFolder);
    
    mapsList = dir(fullfile(mapsPath, mapsExt));
    maps = strrep({mapsList.name}, '.bin', '');
end