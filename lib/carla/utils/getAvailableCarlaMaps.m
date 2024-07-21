function maps = getAvailableCarlaMaps()
    % Get config
    config = evalin('base', 'config');

    mapsExt = "*.umap";
    mapsPath = fullfile(config.CarlaPath, config.MapsPath);
    
    mapsList = dir(fullfile(mapsPath, mapsExt));
    maps = strrep({mapsList.name}, '.umap', '');
end