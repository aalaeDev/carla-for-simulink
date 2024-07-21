function success = killProcess(pid)
    % Terminate a process given a PID
    % pid: Process ID to terminate
    % success: Returns true if the process was successfully terminated, otherwise false
    
    if ispc
        % Windows-specific command
        [status, ~] = system(sprintf('taskkill /PID %d /F', pid));
        success = (status == 0);
    else
        error('Unsupported operating system');
    end
end
