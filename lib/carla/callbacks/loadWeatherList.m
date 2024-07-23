function loadWeatherList(blkHandle)
    try
        maskObj = Simulink.Mask.get(blkHandle);

        buttonHandle = maskObj.getDialogControl('RefreshWeather');
        buttonHandle.Enabled = 'off';
        buttonHandle.Prompt = '  Refreshing... ';
        
        weatherPresets = getWeatherPresets();
        
        param = maskObj.getParameter('Weather');
        param.TypeOptions = weatherPresets;
        param.Value = weatherPresets{1};
    catch  e
        % TODO: Handle errors 
        disp(getReport(e))
        errordlg('Cannot update the Weather list.', 'Failed to refresh')
    end
    
    buttonHandle.Enabled = 'on';
    buttonHandle.Prompt = '  Refresh Weather List  ';
end