function [data, specs] = findSubject(subjectName)
    % [data, specs] = findSubject(subjectName)
    % This function can be used to locate a Subject in the repository with
    % its original name. The original subject name is stored in the.mat file in
    % specs.subjectName.
    % Input:
    %       subjectName: The name of the .mat file that contains the HRIR
    % Output:
    %       data: an array of structures with all the HRIR
    %       specs: a structure with all the specification of the datase
    %
    %
    %                 %%%% Areti Andreopoulou %%%%
    %                       aa1510@nyu.edu
    %      Music and Audio Research Laboratory, New York University
    %                        October 2011

    %%Error Checking
    if (nargin ~=1)
        error('This function takes 1 input argument.');
    end
    
    if isnumeric(subjectName)
        error('subjectName must be of type string');
    end
    
    
    %%Function
    flag = 0;
    for i = 1:110
        if i < 10
            filename = sprintf('../HRIRrepository/S00%i_marl-nyu.mat', i);
        elseif i < 100
            filename = sprintf('../HRIRrepository/S0%i_marl-nyu.mat', i);
        else
            filename = sprintf('../HRIRrepository/S%i_marl-nyu.mat', i);
        end
        dataset = load(filename);
        
        if strcmpi(subjectName, dataset.specs.subjectName)
            flag = 1;
            data = dataset.data;
            specs = dataset.specs;
            return;
        end
    end
    if flag == 0
        data = NaN;
        specs = NaN;
        fprintf('Subject %s cannot be found in the HRIR repository\n', subjectName);
    end
end