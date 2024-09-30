sampfreq = 8000;

load Guitar.MAT

%fft to the waves with different cycles
%cycle=1
wave1 = wave2proc(1:round(length(wave2proc)/10));
res1 = fft(wave1);
subplot(3,2,1);
plot([0:length(res1)-1]*sampfreq/length(res1),abs(res1));
title('cycle:1');

%cycle=10
res2 = fft(wave2proc);
subplot(3,2,2);
plot([0:length(res2)-1]*sampfreq/length(res2),abs(res2));
title('cycle:10');

%cycle=100
wave3 = repmat(wave2proc, 10, 1);
res3 = fft(wave3);
subplot(3,2,3);
plot([0:length(res3)-1]*sampfreq/length(res3),abs(res3));
title('cycle:100');

%cycle=1000
wave = repmat(wave2proc, 100, 1);
res = fft(wave);
subplot(3,2,4);
plot([0:length(res)-1]*sampfreq/length(res),abs(res));
title('cycle:1000');

%cycle=10000
wave4 = repmat(wave2proc, 1000, 1);
res4 = fft(wave4);
subplot(3,2,5);
plot([0:length(res4)-1]*sampfreq/length(res4),abs(res4));
title('cycle:10000');

%cycle=100000
wave5 = repmat(wave2proc, 10000, 1);
res5 = fft(wave5);
subplot(3,2,6);
plot([0:length(res5)-1]*sampfreq/length(res5),abs(res5));
title('cycle:100000');

%find the base frequency
left = 0;
right = 500*length(res)/sampfreq;%look up range
[value, freq] = max(abs(res((left + 1):round(right))));
basefreq = (freq-1)/length(res)*sampfreq;
disp(['basefreq = ', num2str(basefreq)]);

%find the harmonics frequncies by multiplying
for i=0:12
    testfreq = freq*i - i + 1; %transformed frequency
    testvalue = abs(res(testfreq));
    disp([i,basefreq*i,testvalue/value]);
end

%find the harmonics frequncies by maxing
for i =0:12
    left = 333*(i-1)*length(res)/sampfreq;
    if i<=1
        left=1;
    end
    right = 333*(i)*length(res)/sampfreq+1;%look up range
    [testvalue, freq] = max(abs(res(round(left):round(right))));
    testfreq = (freq+round(left)-2)/length(res)*sampfreq;
    disp([i,testfreq,testvalue/value]);
end









