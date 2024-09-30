sampfreq = 8000;

%plot the waves
load Guitar.MAT
figure;
subplot(1,2,1);
plot([0:length(realwave)-1]/sampfreq, realwave);
title('realwave');

subplot(1,2,2);
plot([0:length(wave2proc)-1]/sampfreq, wave2proc);
title('wave2proc');

%sound the music
music = audioread('fmt.wav');
sound(music, sampfreq);