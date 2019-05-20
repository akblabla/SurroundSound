function soundIR(subjectName, azimuthPosition, elevationPosition)
    % soundIR(subjectName, azimuthPosition, elevationPosition)
    % The soundIR function can be used for listening to a specific HRIR pair.
    % The selected filter is convolved with white noise.
    % Input:
    %       subjectName: The name of the .mat file that contains the HRIR
    %       azimuthPosition : Azimuth location
    %       elevationPosition : Elevation location
    %
    %
    %                 %%%% Areti Andreopoulou %%%%
    %                       aa1510@nyu.edu
    %      Music and Audio Research Laboratory, New York University
    %                        October 2011
    
    
    %%Error Checking
    if (nargin ~=3)
        error('Not all input arguments defined');
    end
    
    if isnumeric(subjectName)
        error('subjectName must be of type string');
    end
    
    if ~isnumeric(azimuthPosition)
        error('azimuthPosition must be of type double');
    end
    
     if ~isnumeric(elevationPosition)
        error('elevationPosition must be of type double');
     end


    %%Function
    [ir, fs, ITD] = findIR(subjectName, azimuthPosition, elevationPosition);

    if isnan(ir)
        return;
    end

    disp('Test signal: white noise');
    fprintf('Azimuth position: %g \nElevation position: %g \n', azimuthPosition, elevationPosition);

    whiteNoise  = randn(fs/2,1); %half a second of real valued white noise
    if ITD < 0
        leftEar = [ir(:, 1); zeros(round(abs(ITD)), 1)];
        rightEar = [zeros(round(abs(ITD)), 1); ir(:, 2)];
    else
        leftEar = [zeros(round(abs(ITD)), 1); ir(:, 1)];
        rightEar = [ir(:, 2); zeros(round(abs(ITD)), 1)];
    end
    sig(:, 1) = conv(leftEar, whiteNoise);
    sig(:, 2) = conv(rightEar, whiteNoise);

    sound(sig*.25,fs);
    
end



