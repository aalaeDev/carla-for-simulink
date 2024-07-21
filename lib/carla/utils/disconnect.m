function disconnect(world)
%     actors = world.get_actors();
%     actorsCount = actors.size();
%     
%     for i = 1:actorsCount
%         actor = actors.at(i - 1); % MATLAB indexing starts at 1
%         disp(['Destroying actor ID: ', num2str(actor.id)]);
%         actor.destroy();
%     end
%      
    currentFilePath = mfilename('fullpath');
    modulePath = fileparts(currentFilePath);
    
    if count(py.sys.path, modulePath) == 0
        insert(py.sys.path, int32(0), modulePath);
    end
    
    eval(strcat("py.disconnect.destroy(world)"));
    
    % Reset to async
    settings = world.get_settings();
    settings.synchronous_mode = false;
    world.apply_settings(settings);
end