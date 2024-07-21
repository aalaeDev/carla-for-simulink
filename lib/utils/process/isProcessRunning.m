function isRunning = isProcessRunning(pid)
    % Check if a process is running given a PID
    % pid: Process ID to check
    % isRunning: Returns true if the process is running, otherwise false
    
    if ispc
        % Windows-specific command
        [~, result] = system(sprintf('tasklist /FI "PID eq %d"', pid));
        isRunning = contains(result, sprintf('%d', pid));
    else
        error('Unsupported operating system');
    end
end
