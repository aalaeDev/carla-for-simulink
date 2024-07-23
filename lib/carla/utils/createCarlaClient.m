function [client, world] = createCarlaClient()
    mdl = evalin('base', 'mdl');
    simConfig = getSimulationConfig();

    % Setup client and world
    client = py.carla.Client('localhost', simConfig.port);
    client.set_timeout(simConfig.timeout);
    client.load_world(simConfig.map);

    world = client.get_world();
    settings = world.get_settings();

    % Apply weather preset
    watherPreset = py.getattr(py.carla.WeatherParameters, simConfig.weather);
    world.set_weather(watherPreset);

    % Change Simulation Mode
    isSynchronous = strcmp(simConfig.mode, 'Synchronous');
    settings.synchronous_mode = isSynchronous;
    
    if isSynchronous
        if strcmp(get_param(mdl, 'SolverType'), 'Fixed-step')
            sampleTime = get_param(mdl, 'FixedStep');
            if strcmp(get_param(mdl, 'SolverType'), 'auto')
                Logger.warning('Using auto sample-time with Synchronous mode can yield unexpected results.');
            else
                settings.fixed_delta_seconds = str2double(sampleTime);
            end
        else
            Logger.warning('Using Variable-Step with Synchronous mode can yield unexpected results.');
        end
    end

    world.apply_settings(settings);

    assignin('base', 'client', client);
    assignin('base', 'world', world);

    % Create NPCs
    spawnNPCs(simConfig.npcs);
end

