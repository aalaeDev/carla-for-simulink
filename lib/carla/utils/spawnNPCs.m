function spawnNPCs(count)
    if count <=0
        return
    end

    world = getWorldFromWS();

    % Get the blueprint library and filter for the vehicle blueprints
    vehicleBPs = world.get_blueprint_library().filter('*vehicle*');

    % Get the map's spawn points
    spawnPoints = world.get_map().get_spawn_points();
    spawnPointsCount = double(py.len(spawnPoints));
    
    if spawnPointsCount <= count
        count = spawnPointsCount
    end

    npcSpawnPoints = py.random.sample(spawnPoints, count);

    for i = 1:count
        try
            npc = world.try_spawn_actor(py.random.choice(vehicleBPs), py.random.choice(npcSpawnPoints));
            npc.set_autopilot(true);
            Logger.info(sprintf('NPC No. %d successfully spawned.', i));
        catch 
            Logger.warning(sprintf('NPC No. %d failed to spawn.', i));
        end
end