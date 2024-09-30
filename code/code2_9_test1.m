%find the best way to figure out the module
sampfreq = 8000;

%the meanings can be found in the report file
%1
wave = audioread('fmt.wav');
subplot(4,2,1);
plot([0:length(wave)-1]/sampfreq,wave);
title('origin')

%2
wave1 = abs(wave);
subplot(4,2,2);
plot([0:length(wave)-1]/sampfreq,wave1);
title('abs')

%3
wave2 = zeros(length(wave),1);
for i = 1:(length(wave)-1)
wave2(i) = wave(i)-wave(i+1);
end
subplot(4,2,3);
plot([0:length(wave)-1]/sampfreq,abs(wave2));
title('differ')

%4
wave4 = wave.^2;
subplot(4,2,4);
plot([0:length(wave)-1]/sampfreq,wave4);
title('square1')

%5
wave5 = zeros(length(wave),1);
for i = 2:(length(wave)-1)
wave5(i) = (wave(i-1)+wave(i)+wave(i+1))/3;
end
subplot(4,2,5);
plot([0:length(wave)-1]/sampfreq,abs(wave5));
title('average1')

%6
wave6 = (wave+0.9).^10;
subplot(4,2,6);
plot([0:length(wave)-1]/sampfreq,wave6);
title('square2')

%7
wave7 = zeros(length(wave),1);
for i = 3:(length(wave)-2)
wave7(i) = (wave(i-2)+wave(i-1)+wave(i)+wave(i+1)+wave(i+2))/5;
end
subplot(4,2,7);
plot([0:length(wave)-1]/sampfreq,abs(wave7));
title('average2')
