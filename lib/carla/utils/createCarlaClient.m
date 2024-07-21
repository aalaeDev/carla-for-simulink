function [client, world] = createCarlaClient(timeout)
    arguments
        timeout = 20.0
    end

    % Setup client and world
    simConfig = getSimulationConfig();
    port = simConfig.port;
    client = py.carla.Client('localhost', port);
    client.set_timeout(timeout);
    world = client.get_world();
end

