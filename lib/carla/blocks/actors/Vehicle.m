function Vehicle(block)
    setup(block)
end

function setup(block)
    % Define the number of input and output ports
    block.NumInputPorts  = 0; % No direct input
    block.NumOutputPorts = 1;

    % Setup functional port properties to dynamically inherited
    block.SetPreCompInpPortInfoToDynamic;
    block.SetPreCompOutPortInfoToDynamic;

    % Configure the output port properties
    block.OutputPort(1).Dimensions   = 1;
    block.OutputPort(1).DatatypeID   = 5;        % uint16
    block.OutputPort(1).Complexity   = 'Real';
    block.OutputPort(1).SamplingMode = 'Sample'; % Explicitly set to non-frame

    % Register number of parameters
    block.NumDialogPrms = 0;

    % Set the sample time to inherited
    block.SampleTimes = [0 0];
    
    % Initialization of the world and vehicle setup
    vehicle = initializeVehicle(block);

    % Register the methods
    block.RegBlockMethod('SetInputPortSamplingMode', @SetInputPortSamplingMode);
    block.RegBlockMethod('Outputs', @(block) Outputs(block, vehicle));  
    block.RegBlockMethod('Terminate', @(block) Terminate(block, vehicle));

    % Set block simStateCompliance to default
    block.SimStateCompliance = 'DefaultSimState';

end

function vehicle = initializeVehicle(block)
    % Get the world object from the base workspace
    world = getWorldFromWS();
    
    % Get the map and spawn points
    carlaMap = world.get_map();
    spawnPoints = carlaMap.get_spawn_points();
    
    % Get the vehicle blueprint
    blueprintLibrary = world.get_blueprint_library();
    carList = py.list(blueprintLibrary.filter('audi'));
    vehicleBp = carList{1};
    
    % Spawn the vehicle at a random spawn point
    startPoint = py.random.choice(spawnPoints);
    vehicle = world.try_spawn_actor(vehicleBp, startPoint);
    block.OutputPort(1).Data = uint16(double(vehicle.id)); 
    
    % Set the spectator view to the vehicle's start point
    spectator = world.get_spectator();
    spectator.set_transform(startPoint);
end

function Outputs(block, vehicle)
    % Output the vehicle ID
    block.OutputPort(1).Data = uint16(double(vehicle.id)); 
end

function SetInputPortSamplingMode(block, ~, fd)
    % Propagate the sampling mode to all output ports
    for i = 1:block.NumOutputPorts
        block.OutputPort(i).SamplingMode = fd;
    end
end

function Terminate(~, vehicle)
    vehicle.destroy();
end



