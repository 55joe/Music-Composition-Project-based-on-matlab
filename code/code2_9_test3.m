%fine the most suitable envelop
sampfreq = 8000;

wave = audioread('fmt.wav');

wave1 = wave .^ 2;

window1 = rectwin(1000);
    subplot(5,2,1);
    plot(window1);
    wave2 = conv(window1, wave1);
    subplot(5,2,2);
    plot([0:length(wave2)-1]/sampfreq, wave2);
window1 = triang(1000);
    subplot(5,2,3);
    plot(window1);
    wave2 = conv(window1, wave1);
    subplot(5,2,4);
    plot([0:length(wave2)-1]/sampfreq, wave2);
window1 = chebwin(1000);
    subplot(5,2,5);
    plot(window1);
    wave2 = conv(window1, wave1);
    subplot(5,2,6);
    plot([0:length(wave2)-1]/sampfreq, wave2);
window1 = barthannwin(1000);
    subplot(5,2,7);
    plot(window1);
    wave2 = conv(window1, wave1);
    subplot(5,2,8);
    plot([0:length(wave2)-1]/sampfreq, wave2);
window1 = gausswin(1000);
    subplot(5,2,9);
    plot(window1);
    wave2 = conv(window1, wave1);
    subplot(5,2,10);
    plot([0:length(wave2)-1]/sampfreq, wave2);