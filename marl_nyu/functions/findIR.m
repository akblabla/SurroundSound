function [IR, fs, ITD] = findIR(subjectName, azimuthPosition, elevationPosition)
    % [IR, fs, ITD] = findIR(subjectName, azimuthPosition, elevationPosition)
    % The findIR function can be used to return a specific
    % azimuth-elevation location in a given .mat file
    % Input:
    %       subjectName: The name of the .mat file that contains the HRIR
    %       azimuthPosition : Azimuth location
    %       elevationPosition : Elevation location
    % Output:
    %       IR: an N by 2 matrix with the HRIR pair
    %       fs: the sample frequency
    %       ITD: the corresponding ITD value
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
    load(sprintf('../HRIRrepository/%s',subjectName));
    flag = 0;
    
    elevations = zeros(1, length(data));
    azimuths = zeros(1, length(data));
    
    for i = 1:length(data)
        elevations(i) = data(i).elevation;
        if (data(i).azimuth == azimuthPosition) && (data(i).elevation == elevationPosition)
            flag = 1;
            IR = zeros(length(data(i).IR), 2);
            IR(:, 1) = data(i).IR(:, 1);
            IR(:, 2) = data(i).IR(:, 2);
            fs  = specs.sampleRate;
            ITD = data(i).ITD;
        end
    end
    if (flag == 0)
       IR = NaN;
       fs = NaN;
       ITD = NaN;
       
       % find the closest location with respect to elevation
       
       
       % elevation
       difference = 360; %initialize variable to the greatest possible value
       bestMatchingIndex = 0;
       uniqueElevations = unique(elevations);
       for ndx = 1:length(uniqueElevations)
               tempDifference = abs(uniqueElevations(ndx) - elevationPosition);
               if (tempDifference <= difference)
                   difference = tempDifference;
                   bestMatchingIndex = ndx;
               end
       end
       closestEl = uniqueElevations(bestMatchingIndex);
       
       % azimuth
       for index = 1:length(data)
           if (data(index).elevation == closestEl)
               azimuths(index) = data(index).azimuth;
           end
       end
       
       if azimuthPosition < 0
           azimuthPosition = 360 + azimuthPosition;
       end
       difference = 360; %initialize variable to the greatest possible value
       bestMatchingIndex = 0;
       uniqueAzimuths = unique(azimuths);
       for index = 1:length(uniqueAzimuths)
           if uniqueAzimuths(index) < 0
               tempAz = 360 + uniqueAzimuths(index);
           else
               tempAz = uniqueAzimuths(index);
           end
           if (abs(tempAz - azimuthPosition) <= difference);
               difference = abs(tempAz - azimuthPosition);
               bestMatchingIndex = index;
           end
       end       
       closestAz = uniqueAzimuths(bestMatchingIndex);
       
       
       
       
       fprintf('This position is not available. \nThe closest match to your search with respect to elevation is: \nAzimuth: %g  Elevation: %g \n', closestAz, closestEl);
       
    end
end
