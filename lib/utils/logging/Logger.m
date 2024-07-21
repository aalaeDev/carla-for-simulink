classdef Logger
    methods (Static)
        function debug(msg)
            Logger.log('DEBUG', msg, 'blue');
        end
        
        function info(msg)
            Logger.log('INFO', msg,  'black');
        end
        
        function success(msg)
            Logger.log('SUCCESS', msg, '*[0.55, 0.8, 0.36]');
        end
        
        function warning(msg)
            Logger.log('WARNING', msg, '*[1, 0.5, 0]');
        end
        
        function error(msg)
            Logger.log('ERROR', msg, '*red');
        end
        
        function critical(msg)
            Logger.log('CRITICAL', msg, '*dark red');
        end
    end
    
    methods (Static, Access = private)
        function log(level, msg, style)
            % Construct the formatted message
            timestamp = datestr(datetime("now"), 'HH:MM:SS');
            formattedMsg = sprintf('[%s] [%-8s] %s\n', timestamp, level, msg);
            
            % Print the message with color and styles
            cprintf(style, formattedMsg);
        end
    end
end
