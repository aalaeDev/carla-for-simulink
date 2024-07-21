function pyModule = bindGNSSData(sensor)
    % Check if the sensor is valid
    if ~isa(sensor, 'py.carla.libcarla.ServerSideSensor')
        error("The provided sensor is not valid\n")
    end

    currentFilePath = mfilename('fullpath');
    modulePath = fileparts(currentFilePath);
    
    if count(py.sys.path, modulePath) == 0
        insert(py.sys.path, int32(0), modulePath);
    end
    
    pyModule = py.importlib.import_module("GNSS");
    eval(strcat("py.GNSS.getReadings(sensor)"));
end