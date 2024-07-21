function pids = getPIDsByName(processName)
    % Get all PIDs of processes with a given name
    % processName: Name of the process to search for
    % pids: Returns an array of PIDs of the processes with the given name
    
    if ispc
        % Windows-specific command
        [~, result] = system(sprintf('wmic process where (name="%s") get ProcessId', processName));
        pids = regexp(result, '\d+', 'match');
    else
        error('Unsupported operating system');
    end
end
