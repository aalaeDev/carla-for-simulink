function weatherPresets = getWeatherPresets()
    carlaWeatherParams = cellfun(@char, cell(py.dir(py.carla.WeatherParameters)), 'UniformOutput', false);

    pattern = '.+?(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])|$';

    % Filter weather params using the regular expression pattern
    weatherPresets = carlaWeatherParams(cellfun(@(x) ~isempty(regexp(x, pattern, 'once')), carlaWeatherParams));
end