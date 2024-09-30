sampfreq = 8000;

%plot the original waves
load Guitar.MAT
figure;
subplot(1,3,1);
plot([0:length(realwave)-1]/sampfreq, realwave);
title('realwave');

subplot(1,3,2);
plot([0:length(wave2proc)-1]/sampfreq, wave2proc);
title('wave2proc');

%eliminate the noise
%resample
resamwave = resample(realwave, 10, 1)/10;
averawave = zeros(length(resamwave)/10,1);
%average
for i = 0:9
    averawave = averawave + resamwave(i*length(resamwave)/10+1:(i+1)*length(resamwave)/10);
end
%copy
resamwave = repmat(averawave, 10, 1);
%reresample
resamwave = resample(resamwave, 1, 10);
subplot(1,3,3);
plot([0:length(resamwave)-1]/sampfreq, resamwave);
title('resamwave');