function SetLocation(block)
    % Initialization setup
    setup(block);
end

function setup(block)
    INPORTS_COUNT  = 4;
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
    % Get actor object
    actor =  world.get_actor(uint16(block.InputPort(1).Data));

    x = block.InputPort(2).Data; % PosX
    y = block.InputPort(3).Data; % PosY
    z = block.InputPort(4).Data; % PosZ
    
    actor.set_location(py.carla.Location(x, y, z));
end

