function viewIR(subjectName, azimuthPosition, elevationPosition)
    % viewIR(subjectName, azimuthPosition, elevationPosition)
    % This function can be used to plot an HRIR in both time and frequency domains.
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
    else
        figure;
        subplot(2, 1, 1)
        
        if ITD < 0
            leftEar = [ir(:, 1); zeros(round(abs(ITD)), 1)];
            rightEar = [zeros(round(abs(ITD)), 1); ir(:, 2)];
        else
            leftEar = [zeros(round(abs(ITD)), 1); ir(:, 1)];
            rightEar = [ir(:, 2); zeros(round(abs(ITD)), 1)];
        end
        
        plot(leftEar, 'b')
        hold on;
        plot(rightEar, 'r')
        hold off;
        legend('Left Ear', 'Right Ear', 'Location', 'Best');
        axis tight;
        title({sprintf('Azimuth: %d   Elevation: %g \n', azimuthPosition, elevationPosition), 'Time Domain'},'FontSize', 11, 'FontWeight','bold');
        ylabel('Amplitude');
        xlabel('Time (samples)');
        
        
        subplot(2, 1, 2)
        IRl = 20*log(abs(fft(ir(:, 1))));
        IRr = 20*log(abs(fft(ir(:, 2))));
        plot([0:ceil(length(IRl)/2)-1]/ceil(length(IRl)/2)*fs/2/1000,IRl(1:ceil(length(IRl)/2)), 'b')
        hold on;
        plot([0:ceil(length(IRr)/2)-1]/ceil(length(IRr)/2)*fs/2/1000,IRr(1:ceil(length(IRr)/2)), 'r')
        hold off;
        axis tight;
        title('Magnitude Representation', 'FontSize', 11, 'FontWeight','bold'); 
        ylabel('Magnitude (dB)');
        xlabel('Frequency (kHz)');
        

    end
end