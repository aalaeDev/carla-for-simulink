function fieldName = findFieldByValue(structure, fieldNameToSearch, targetValue)
    % Initialize the output
    fieldName = '';
    
    % Get the field names of the structure
    fieldNames = fieldnames(structure);
    
    % Iterate through each field in the structure
    for i = 1:numel(fieldNames)
        currentField = fieldNames{i};
        % Check if the current field is a structure
        if isstruct(structure.(currentField))
            % Recursively call the function for nested structures
            nestedFieldName = findFieldByValue(structure.(currentField), fieldNameToSearch, targetValue);
            if ~isempty(nestedFieldName)
                fieldName = currentField;
                return;
            end
        else
            % Check if the current field matches the target value
            if strcmp(fieldNameToSearch, currentField) && strcmp(structure.(currentField), targetValue)
                fieldName = currentField;
                return;
            end
        end
    end
end
