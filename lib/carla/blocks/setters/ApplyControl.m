function ApplyControl(block)
    % Initialization setup
    setup(block);
end

function setup(block)
    INPORTS_COUNT  = 6;
    OUTPORTS_COUNT = 0;

    % Register number of input and output ports
    block.NumInputPorts  = INPORTS_COUNT;
    block.NumOutputPorts = OUTPORTS_COUNT;  % No direct output

    % Setup functional port properties to dynamically inherited
    block.SetPreCompInpPortInfoToDynamic;

    % Configure the input port properties
    for i = 1:INPORTS_COUNT
        block.InputPort(i).Dimensions        = 1;
        block.InputPort(i).DatatypeID        = 0;          % double
        block.InputPort(i).Complexity        = 'Real';
        block.InputPort(i).DirectFeedthrough = true;
        block.InputPort(i).SamplingMode      = 'Sample';
    end
    block.InputPort(1).DatatypeID            = 5;          % uint16

    % Register parameters (none in this example)
    block.NumDialogPrms = 0;

    % Set sample times
    block.SampleTimes = [0 0];  % Inherited sample time
    
    % Get world object
    world = getWorldFromWS();
    
    % Register methods
    block.RegBlockMethod('Outputs', @(block) Outputs(block, world));  
    
    % Set block simStateCompliance to default
    block.SimStateCompliance = 'DefaultSimState';
end

function Outputs(block, world)
    % Get vehicle object
    vehicle =  world.get_actor(uint16(24));
    control = py.carla.VehicleControl();

    throttle    = block.InputPort(2).Data; % Throttle
    brake       = block.InputPort(3).Data; % SteerAng
    steer       = block.InputPort(4).Data; % Brake
    hand_brake  = block.InputPort(5).Data; % HandBrake
    reverse     = block.InputPort(6).Data; % isRevGear

    % Apply constraints
    throttle    = max(0.0, min(1.0, throttle));
    steer       = max(-1.0, min(1.0, steer));
    brake       = max(0.0, min(1.0, brake));
    hand_brake  = logical(hand_brake);
    reverse     = logical(reverse);

    control.steer = steer;
    control.throttle = throttle;
    control.brake = brake;
    control.hand_brake = hand_brake;
    control.reverse = reverse;

    vehicle.apply_control(control)
end

