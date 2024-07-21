function loadVehiclesList(blkHandle)
    try
        config = evalin('base', 'config');
        maskObj = Simulink.Mask.get(blkHandle);

        buttonHandle = maskObj.getDialogControl('RefreshVehicles');
        buttonHandle.Enabled = 'off';
        buttonHandle.Prompt = '  Refreshing... ';

        % Get Vehciles List
        vehiclesList = jsondecode(fileread(config.VehiclesDbPath));
        vehiclesIds = fields(vehiclesList);
        vehiclesNames = cell(numel(vehiclesIds), 1);

        for i = 1:numel(vehiclesNames)
            vehiclesNames{i} = vehiclesList.(vehiclesIds{i}).name;
        end

        % Update Vehicles List
        param = maskObj.getParameter('Vehicle');
        param.TypeOptions = vehiclesNames;
        param.Value = vehiclesNames{1};

        % Todo: Add Vehicles Info
    catch 
        % TODO: Handle errors 
        errordlg('Cannot update the Vehicles list.', 'Failed to refresh')
    end
    buttonHandle.Enabled = 'on';
    buttonHandle.Prompt = '  Refresh Vehicles List  ';
end