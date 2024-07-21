function RADAR(block)
    setup(block)
end

function setup(block)
    INPORTS_COUNT  = 1;
    OUTPORTS_COUNT = 2;

    % Register number of input and output ports
    block.NumInputPorts  = INPORTS_COUNT ;% No direct input
    block.NumOutputPorts = OUTPORTS_COUNT;  

    % Setup functional port properties to dynamically inherited
    block.SetPreCompInpPortInfoToDynamic;
    block.SetPreCompOutPortInfoToDynamic;

    % Configure the input port properties
    block.InputPort(1).Dimensions        = 1;
    block.InputPort(1).DatatypeID        = 5;          % uint16
    block.InputPort(1).Complexity        = 'Real';
    block.InputPort(1).DirectFeedthrough = true;
    block.InputPort(1).SamplingMode      = 'Sample';

    % Configure the output ports properties
    for i = 1:OUTPORTS_COUNT
        block.OutputPort(i).DatatypeID     = 0;        % double
        block.OutputPort(i).Complexity     = 'Real';
        block.OutputPort(i).SamplingMode   = 'Sample'; % Explicitly set to non-frame
    end
    block.OutputPort(1).Dimensions         = 1;
    block.OutputPort(1).DatatypeID         = 5;        % uint16
    block.OutputPort(2).DatatypeID         = 3;        % uint8

    % Register parameters (none in this example)
    block.NumDialogPrms = 0;

    % Set sample times
    block.SampleTimes = [0 0];  % Inherited sample time
    
    % Get world and vehicle object
    world = getWorldFromWS();
    
    % Register methods
    block.RegBlockMethod('PostPropagationSetup', @PostPropagationSetup);
    block.RegBlockMethod('SetInputPortSamplingMode', @SetInputPortSamplingMode); 
    block.RegBlockMethod('SetOutputPortDimensions', @SetOutputPortDimensions);
    % Create the Sensor on the first step then re-route the Output block method to the actual Output fcn 
    block.RegBlockMethod('Outputs', @(block) CreateSensor(block, world)); 
     
    % Set block simStateCompliance to default
    block.SimStateCompliance = 'DefaultSimState';
end

function CreateSensor(block, world)
    % Get actor object
    actor =  world.get_actor(uint16(block.InputPort(1).Data));

    % Attach RADAR sensor to the actor
    RADARBp = world.get_blueprint_library().find("sensor.other.radar");
    RADAR = world.spawn_actor(RADARBp, py.carla.Transform(), world.get_actor(actor.id));

    block.OutputPort(1).Data = uint16(double(RADAR.id));     % SensorID
    
    moduleRADAR = bindRADARData(RADAR);

    block.RegBlockMethod('Outputs', @(block) Outputs(block, moduleRADAR));
    block.RegBlockMethod('Terminate', @(block) Terminate(block, RADAR));
end

function Outputs(block, moduleLIDAR)
    % This code executes at each simulation step
    sensor_data = py.getattr(moduleLIDAR, 'data');
    raw_data = uint8(sensor_data.raw_data);
    disp(raw_data)
    block.OutputPort(1).Dimensions = size(raw_data);
    block.OutputPort(2).Data = raw_data; % RawData
end

function PostPropagationSetup(block)
    % Set the output port dimensions
    block.OutputPort(1).Dimensions = -1; % Initially dynamic
end

function SetInputPortSamplingMode(block, ~, fd)
    % No input ports to set, but must define this function
    % Propagate the sampling mode to all output ports
    for i = 1:block.NumOutputPorts
        block.OutputPort(i).SamplingMode = fd;
    end
end

function SetOutputPortDimensions(block, port, dims)
    % Set the dimensions of the output port
    if port == 1
        block.OutputPort(port).Dimensions = dims;
    end
end

function Terminate(~, sensor)
    sensor.destroy();
end


