function Spectator(block)
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

    % Get the world object from the base workspace
    world = getWorldFromWS();

    % Get spectator ID
    spectatorID = world.get_spectator().id;

    % Register the methods
    block.RegBlockMethod('SetInputPortSamplingMode', @SetInputPortSamplingMode);
    block.RegBlockMethod('Outputs', @(block) Outputs(block, spectatorID));  

    % Set block simStateCompliance to default
    block.SimStateCompliance = 'DefaultSimState';

end

function Outputs(block, spectatorID)
    % Output the spectator ID 
    block.OutputPort(1).Data = uint16(double(spectatorID)); 
end

function SetInputPortSamplingMode(block, ~, fd)
    % Propagate the sampling mode to all output ports
    for i = 1:block.NumOutputPorts
        block.OutputPort(i).SamplingMode = fd;
    end
end