function disconnect(world)
    currentFilePath = mfilename('fullpath');
    modulePath = fileparts(currentFilePath);
    
    if count(py.sys.path, modulePath) == 0
        insert(py.sys.path, int32(0), modulePath);
    end
    
    eval(strcat("py.disconnect.destroy(world)"));
    
    % Reset to async
    settings = world.get_settings();
    settings.synchronous_mode = false;
    world.apply_settings(settings);
end