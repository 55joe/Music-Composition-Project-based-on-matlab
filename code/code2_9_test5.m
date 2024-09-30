%fft to find the tunes
sampfreq = 8000;
%depart the beats
wave = audioread('fmt.wav');

wave1 = wave .^ 2;

window1 = triang(1000);
wave2 = conv(window1, wave1);

wave3 = zeros(length(wave2),1);
for i = 2:(length(wave3))
wave3(i) = wave2(i)-wave2(i-1);
end
x0 = zeros(length(wave3),1);
k = 1;
i = 1;

while(i <= length(wave3))
    if(wave3(i)>=0.001)
        j = i;
        while(wave3(j)>=0.001)
            j = j + 1;
        end
        [~,x0(k)]=max(wave3(i:j,1));
        x0(k) = x0(k) + i - 330;%parameter to offset the influnce of differential func
        %x0(k) = x0(k)/sampfreq;
        k = k + 1;
        i = j;
    end
    i = i + 100;
end

%fine the tunes
i = 2;

basefrequn = zeros(34,1);
harmofrequ = zeros(34,13);
harmovalue = zeros(34,13);

while(x0(i)>0)
    left = x0(i-1);
    right = x0(i);
    wavepart = wave(left:right); %avoid the first and last x0 = 0
    %plot(wavepart);
    waverep = repmat(wavepart,10,1);
    %plot(waverep);
    wavefft = fft(waverep);
    wavefft = abs(wavefft);
    plot(wavefft);
    %find the basefreq
    [value,maxfreq]=max(wavefft(1:length(wavefft)/2,1)); 
    multiples = [1/5, 1/4, 1/3, 1/2, 1];
    freqs = round(maxfreq * multiples);
    base = 1;
    j = 1;
    basevalue = 0;
    while(basevalue/value<0.1)
        [basevalue,basefreq]=max(wavefft((freqs(j)-10):(freqs(j)+10),1));
        basefreq = basefreq + freqs(j) - 10 - 1;
        j = j + 1;
    end
    
    %find the harmonies
    for ii = 1 : 12
      left = round(0.95*basefreq*(ii-1));
      if ii<=1
        left=1;
      end
      right = round(1.05*basefreq*(ii-1));%look up range
      if ii<=1
        right=10;
      end
      [harmovalue(i-1,ii), harmofrequ(i-1,ii)] = max(wavefft(left:right));
      harmofrequ(i-1,ii) = (harmofrequ(i-1,ii)+left-2)/length(wavefft)*sampfreq;
      harmovalue(i-1,ii) = harmovalue(i-1,ii)/basevalue;
    end

    basefrequn(i-1)=harmofrequ(i-1,2);
    i = i + 1;
end



