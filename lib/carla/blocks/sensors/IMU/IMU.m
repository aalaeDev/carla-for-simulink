function IMU(block)
    setup(block)
end

function setup(block)
    INPORTS_COUNT  = 1;
    OUTPORTS_COUNT = 8;

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
        block.OutputPort(i).Dimensions     = 1;
        block.OutputPort(i).DatatypeID     = 0;        % double
        block.OutputPort(i).Complexity     = 'Real';
        block.OutputPort(i).SamplingMode   = 'Sample'; % Explicitly set to non-frame
    end
    block.OutputPort(1).DatatypeID         = 5;        % uint16

    % Register parameters (none in this example)
    block.NumDialogPrms = 0;

    % Set sample times
    block.SampleTimes = [0 0];  % Inherited sample time
    
    % Get world and vehicle object
    world = getWorldFromWS();
    
    % Register methods
    block.RegBlockMethod('SetInputPortSamplingMode', @SetInputPortSamplingMode);
        % Create the Sensor on the first step then re-route the Output block method to the actual Output fcn
    block.RegBlockMethod('Outputs', @(block) CreateSensor(block, world));
  
    % Set block simStateCompliance to default
    block.SimStateCompliance = 'DefaultSimState';
end

function CreateSensor(block, world)
    % Get actor object
    actor =  world.get_actor(uint16(block.InputPort(1).Data));

    % Attach IMU sensor to the vehicle
    IMUBp = world.get_blueprint_library().find("sensor.other.imu");
    IMU = world.spawn_actor(IMUBp, py.carla.Transform(), world.get_actor(actor.id));
    
    block.OutputPort(1).Data = uint16(double(IMU.id));     % SensorID
    
    moduleIMU = bindIMUData(IMU); 

    block.RegBlockMethod('Outputs', @(block) Outputs(block, moduleIMU));
    block.RegBlockMethod('Terminate', @(block) Terminate(block, IMU));
end

function Outputs(block, moduleIMU)
    % This code executes at each simulation step
    sensor_data = py.getattr(moduleIMU, 'data');
    
    block.OutputPort(2).Data = sensor_data.accelerometer.x;     % AccX
    block.OutputPort(3).Data = sensor_data.accelerometer.y;     % AccY
    block.OutputPort(4).Data = sensor_data.accelerometer.z;     % AccZ
    block.OutputPort(5).Data = sensor_data.gyroscope.x;         % PitchAng
    block.OutputPort(6).Data = sensor_data.gyroscope.y;         % YawAng
    block.OutputPort(7).Data = sensor_data.gyroscope.z;         % RollAng
    block.OutputPort(8).Data = sensor_data.compass;             % Compass
end

function SetInputPortSamplingMode(block, ~, fd)
    % No input ports to set, but must define this function
    % Propagate the sampling mode to all output ports
    for i = 1:block.NumOutputPorts
        block.OutputPort(i).SamplingMode = fd;
    end
end

function Terminate(~, sensor)
    sensor.destroy();
end


