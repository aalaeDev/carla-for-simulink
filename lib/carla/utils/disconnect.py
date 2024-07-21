import carla

def destroy(world):
    actors = world.get_actors()

    for actor in actors:
        actor_type = actor.type_id
        if actor_type.startswith('sensor') or actor_type.startswith('vehicle'):
            actor.destroy()
