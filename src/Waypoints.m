classdef Waypoints
    properties
        waypoints
        waypoints_distance
        waypoints_interp
        waypoints_interp_hash
        
        current_waypoints
        closest_index
        desired_speed
        
        INTERP_DISTANCE_RES
        INTERP_LOOKAHEAD_DISTANCE
    end
    
    methods
        function obj = Waypoints(filename, INTERP_DISTANCE_RES, INTERP_LOOKAHEAD_DISTANCE)
            arguments
                filename
                INTERP_DISTANCE_RES = 0.01
                INTERP_LOOKAHEAD_DISTANCE = 10
            end
            
            obj.waypoints = [];
            obj.waypoints_distance = [];
            obj.waypoints_interp = [];
            obj.waypoints_interp_hash = [];
            
            obj.current_waypoints = [];
            obj.closest_index = 1;
            obj.desired_speed = 0;
            obj.INTERP_DISTANCE_RES = INTERP_DISTANCE_RES;
            obj.INTERP_LOOKAHEAD_DISTANCE = INTERP_LOOKAHEAD_DISTANCE;

            obj.read_waypoints(filename);
            obj.interpolate_waypoints();
        end
        
        function obj = read_waypoints(obj, filename)
            try
                waypoints = csvread(filename);
                obj.waypoints = waypoints;
                obj.waypoints(:, 3) = obj.waypoints(:, 3) + 0;
                fprintf('Successfully loaded %d waypoints 📍\n', size(obj.waypoints, 1));
            catch ME
                if strcmp(ME.identifier, 'MATLAB:load:couldNotReadFile')
                    fprintf('FileNotFoundError: %s\n', ME.message);
                    error('File not found');
                else
                    rethrow(ME);
                end
            end
        end

        function obj = interpolate_waypoints(obj)
            obj.waypoints_distance = [];
            for i = 2:size(obj.waypoints, 1)
                dist = sqrt((obj.waypoints(i, 1) - obj.waypoints(i - 1, 1))^2 + ...
                            (obj.waypoints(i, 2) - obj.waypoints(i - 1, 2))^2);
                obj.waypoints_distance = [obj.waypoints_distance; dist];
            end
            obj.waypoints_distance = [obj.waypoints_distance; 0];
            
            interp_counter = 0;
            for i = 1:size(obj.waypoints, 1) - 1
                obj.waypoints_interp = [obj.waypoints_interp; obj.waypoints(i, :)];
                obj.waypoints_interp_hash = [obj.waypoints_interp_hash; interp_counter];
                interp_counter = interp_counter + 1;
                
                num_pts_to_interp = floor(obj.waypoints_distance(i) / obj.INTERP_DISTANCE_RES) - 1;
                wp_vector = obj.waypoints(i + 1, :) - obj.waypoints(i, :);
                wp_uvector = wp_vector / norm(wp_vector);
                for j = 1:num_pts_to_interp
                    next_wp_vector = obj.INTERP_DISTANCE_RES * j * wp_uvector;
                    obj.waypoints_interp = [obj.waypoints_interp; obj.waypoints(i, :) + next_wp_vector];
                    interp_counter = interp_counter + 1;
                end
            end
            obj.waypoints_interp = [obj.waypoints_interp; obj.waypoints(end)];
            obj.waypoints_interp_hash = [obj.waypoints_interp_hash; interp_counter];
        end

        function obj = update_waypoints(obj, current_x, current_y)
            waypoints = obj.waypoints;
            closest_distance = norm([waypoints(obj.closest_index, 1) - current_x, ...
                                     waypoints(obj.closest_index, 2) - current_y]);
            new_distance = closest_distance;
            new_index = obj.closest_index;
            
            while new_distance <= closest_distance
                closest_distance = new_distance;
                obj.closest_index = new_index;
                new_index = new_index + 1;
                if new_index > size(waypoints, 1)
                    obj.current_waypoints = [];
                    obj.closest_index = NaN;
                    return;
                end
                new_distance = norm([waypoints(new_index, 1) - current_x, ...
                                     waypoints(new_index, 2) - current_y]);
            end
            
            new_distance = closest_distance;
            new_index = obj.closest_index;
            
            while new_distance <= closest_distance
                closest_distance = new_distance;
                obj.closest_index = new_index;
                new_index = new_index - 1;
                if new_index < 1
                    break;
                end
                new_distance = norm([waypoints(new_index, 1) - current_x, ...
                                     waypoints(new_index, 2) - current_y]);
            end
            
            waypoint_subset_first_index = obj.closest_index - 1;
            if waypoint_subset_first_index < 1
                waypoint_subset_first_index = 1;
            end
            
            waypoint_subset_last_index = obj.closest_index;
            total_distance_ahead = 0;
            while total_distance_ahead < obj.INTERP_LOOKAHEAD_DISTANCE
                total_distance_ahead = total_distance_ahead + obj.waypoints_distance(waypoint_subset_last_index);
                waypoint_subset_last_index = waypoint_subset_last_index + 1;
                if waypoint_subset_last_index > size(obj.waypoints, 1)
                    waypoint_subset_last_index = size(obj.waypoints, 1);
                    break;
                end
            end
            
            obj.current_waypoints = obj.waypoints_interp(...
                obj.waypoints_interp_hash(waypoint_subset_first_index):...
                obj.waypoints_interp_hash(waypoint_subset_last_index));
            
            obj.closest_index = new_index;
            obj.closest_distance = new_distance;
        end

        function desired_speed = update_desired_speed(obj, x, y)
            min_idx = 1;
            min_dist = inf;
            desired_speed = 0;
            for i = 1:length(obj.current_waypoints)
                dist = norm([obj.current_waypoints(i, 1) - x, ...
                             obj.current_waypoints(i, 2) - y]);
                if dist < min_dist
                    min_dist = dist;
                    min_idx = i;
                end
            end
            if min_idx < length(obj.current_waypoints)
                desired_speed = obj.current_waypoints(min_idx, 3);
            else
                desired_speed = obj.current_waypoints(end, 3);
            end
            obj.desired_speed = desired_speed;
        end
    end
end