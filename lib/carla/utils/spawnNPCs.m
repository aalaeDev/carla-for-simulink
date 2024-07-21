function spawnNPCs(count)
    world = getWorldFromWS();

    % Get the map's spawn points
    spawn_points = world.get_map().get_spawn_points();
    
    % Spawn 50 vehicles randomly distributed throughout the map 
    % for each spawn point, we choose a random vehicle from the blueprint library
    for i = 1:count
        world.try_spawn_actor(random.choice(vehicle_blueprints), random.choice(spawn_points))
end