# CARLA for Simulink

A small Simulink block library for co-simulation with the [CARLA](https://carla.org) driving simulator.

> **Proof of concept.** This is a quick demo that shows Simulink and CARLA working together. The blocks below work, but it isn't a complete or maintained library.
>
> It is tied to one combination of versions: MATLAB R2020a, Python 3.7.9 and CARLA 0.9.15. MATLAB only supports certain Python versions, and each CARLA release needs its own Python client, so other combinations may not work. A fuller implementation, planned separately, is meant to remove these limits.

**Documentation:** https://aalaedev.github.io/carla-for-simulink

## What's in it

| Group | Blocks |
|---|---|
| Environment | Launch CARLA (server, map, port, weather, sync mode), world tick, NPC spawning, spectator |
| Actors | Vehicle, Spectator |
| Getters | Location, Transform, Velocity, Acceleration, Angular Velocity |
| Setters | Apply Control, Set Autopilot, Set Location, Set Transform, Set Target Velocity, Set Target Angular Velocity |
| Sensors | GNSS, IMU (LiDAR and radar blocks exist but are experimental and undocumented) |

## Requirements

Developed and tested with CARLA 0.9.15, MATLAB R2020a with Simulink, and Python 3.7.9. Other versions are untested; check [MATLAB's Python compatibility table](https://www.mathworks.com/support/requirements/python-compatibility.html).

## Quick start

1. Clone this repository.
2. In `config.json`, set `CarlaPath` to your CARLA install folder.
3. In MATLAB, run `launch.m`. It adds the library to the path, opens `examples/SpectatorFollowingVhcl.slx`, picks a free port and loads the map and vehicle lists.

## Layout

| Path | Contents |
|---|---|
| `lib/carla/Carla4SL.slx` | The block library |
| `lib/carla/blocks/` | Block implementations (MATLAB System objects, Python helpers) |
| `lib/utils/` | Logging, network and process helpers |
| `examples/` | Example models |
| `docs/` | Documentation site (Next.js + Fumadocs), deployed to GitHub Pages |

## Credits

Inspired by [MATLAB-Carla-Interface](https://github.com/darkscyla/MATLAB-Carla-Interface) by darkscyla.

## Licence

MIT. See [LICENSE](LICENSE).
