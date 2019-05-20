function exportAudio(subjectName)
    % This function can be used to convert a .mat file to a list of .wav
    % files. The files are stred in a folder specified by the user.
    % Input: 
    %       subjectName: The name of the .mat file to be converted
    % The output is a list of per location .wav files.
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

    disp('Select an output directory');
    
    folderPath = uigetdir;
    warning off;
    load(sprintf('../HRIRrepository/%s', subjectName));
    fs = specs.sampleRate;
    for i = 1:length(data)
        ir = data(i).IR;
        ITD = data(i).ITD;
        if ITD < 0
            leftEar = [ir(:, 1); zeros(round(abs(ITD)), 1)];
            rightEar = [zeros(round(abs(ITD)), 1); ir(:, 2)];
        else
            leftEar = [zeros(round(abs(ITD)), 1); ir(:, 1)];
            rightEar = [ir(:, 2); zeros(round(abs(ITD)), 1)];
        end
        
        filename = sprintf('%s/%s_Az%g_El%g', folderPath, subjectName(1:4), data(i).azimuth, data(i).elevation);
        if (fs == 96000)
            wavwrite([leftEar,rightEar]*.99, fs, 24, filename);
        else
            wavwrite([leftEar,rightEar]*.99, fs, filename);
        end           
    end
    warning on;
end

