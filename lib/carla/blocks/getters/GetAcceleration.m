function GetAcceleration(block)
    setup(block)
end

function setup(block)
    INPORTS_COUNT  = 1;
    OUTPORTS_COUNT = 3;

    % Register number of input and output ports
    block.NumInputPorts  = INPORTS_COUNT ;
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
        block.OutputPort(i).Dimensions     = 1;
        block.OutputPort(i).DatatypeID     = 0;        % double
        block.OutputPort(i).Complexity     = 'Real';
        block.OutputPort(i).SamplingMode   = 'Sample'; % Explicitly set to non-frame
    end

    % Register parameters (none in this example)
    block.NumDialogPrms = 0;

    % Set sample times
    block.SampleTimes = [0 0];  % Inherited sample time
    
    % Get world object
    world = getWorldFromWS();
    
    % Register methods
    block.RegBlockMethod('SetInputPortSamplingMode', @SetInputPortSamplingMode);
    block.RegBlockMethod('Outputs', @(block) Outputs(block, world));  
     
    % Set block simStateCompliance to default
    block.SimStateCompliance = 'DefaultSimState';
end

function Outputs(block, world)
    % Get actor object
    actor =  world.get_actor(uint16(block.InputPort(1).Data));

    % Get Transform
    acceleration = actor.get_acceleration();
    
    block.OutputPort(1).Data = acceleration.x;     % AccX
    block.OutputPort(2).Data = acceleration.y;     % AccY
    block.OutputPort(3).Data = acceleration.z;     % AccZ
end

function SetInputPortSamplingMode(block, ~, fd)
    % Propagate the sampling mode to all output ports
    for i = 1:block.NumOutputPorts
        block.OutputPort(i).SamplingMode = fd;
    end
end


