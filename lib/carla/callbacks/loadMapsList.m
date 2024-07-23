function loadMapsList(blkHandle)
    try
        maskObj = Simulink.Mask.get(blkHandle);

        buttonHandle = maskObj.getDialogControl('RefreshMaps');
        buttonHandle.Enabled = 'off';
        buttonHandle.Prompt = '  Refreshing... ';
        
        availableMaps = getAvailableCarlaMaps();
        
        param = maskObj.getParameter('Map');
        param.TypeOptions = availableMaps;
        param.Value = availableMaps{1};
    catch 
        % TODO: Handle errors 
        errordlg('Cannot update the Maps list.', 'Failed to refresh')
    end
    
    buttonHandle.Enabled = 'on';
    buttonHandle.Prompt = '  Refresh Maps List  ';
end