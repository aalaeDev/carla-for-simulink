function WorldTick(block)
    setup(block)
end

function setup(block)
    % Define the number of input and output ports
    block.NumInputPorts  = 0; % No direct input
    block.NumOutputPorts = 0;

    % Setup functional port properties to dynamically inherited
    block.SetPreCompInpPortInfoToDynamic;
    block.SetPreCompOutPortInfoToDynamic;

    % Register number of parameters
    block.NumDialogPrms = 0;

    % Set the sample time to inherited
    block.SampleTimes = [0 0];
    
    % Get the world object from the base workspace
    world = getWorldFromWS();

    % Register the methods
    block.RegBlockMethod('Outputs', @(block) Outputs(block, world));  

    % Set block simStateCompliance to default
    block.SimStateCompliance = 'DefaultSimState';

end

function Outputs(block, world)
    world.tick();
end



