function fileList = findDatabase(databaseName)
    % fileList = findDatabase(databaseName)
    % This function can be used to identify the .mat files that originate
    % from the specific database. Currently this repository contains HRTF
    % datasets form the LISTEN, CIPIC, FIU, and KEMAR-MIT databases.
    % Input:
    %       databaseName: the name of te database in search
    % Output:
    %       fileList: A cell array of .mat file names that come from the
    %       database in search.
    %
    %
    %                 %%%% Areti Andreopoulou %%%%
    %                       aa1510@nyu.edu
    %      Music and Audio Research Laboratory, New York University
    %                        October 2011

    %%Error Checking
    if (nargin ~=1)
        error('This function takes 1 input arguement.');
    end
    
    if ~ischar(databaseName)
        error('databaseName must be of type string');
    end
    
    %%Function
    tempList = dir('../HRIRrepository');
    index = 0;
    for i  = 1:length(tempList)
        if strncmpi(tempList(i).name, 'S', 1)
            filename = sprintf('../HRIRrepository/%s', tempList(i).name);
            load(filename);
            if strcmpi(specs.database, databaseName)
                index = index + 1;
                fileList{index} = tempList(i).name;
            end
        end
    end
    if ~index
        fileList = NaN;
    end
end