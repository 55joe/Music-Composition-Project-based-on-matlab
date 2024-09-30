% find the beats
sampfreq = 8000;

wave = audioread('fmt.wav');

wave1 = wave .^ 2;

window1 = triang(1000);
wave2 = conv(window1, wave1);
%subplot(3,1,1);
%plot([0:length(wave2)-1]/sampfreq,wave2);

%%differ way
wave3 = zeros(length(wave2),1);
for i = 2:(length(wave3))
wave3(i) = wave2(i)-wave2(i-1);
end
%subplot(3,1,2);
%plot([0:length(wave3)-1]/sampfreq,max(wave3,0));
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
        k = k + 1;
        i = j;
    end
    i = i + 100;
end

figure(1);
plot([0:length(wave)-1]/sampfreq,wave);
hold on;

i = 1;
while(x0(i) ~= 0)
    plot(x0(i)/sampfreq,0,'.','MarkerSize',10,'Color','r');
    line([x0(i)/sampfreq,x0(i)/sampfreq],[-0.6,0.6],'linestyle','--','Color','r');
    hold on;
    i = i + 1;
end

%{
%%derivation way
wave4 = diff(wave2);
%subplot(3,1,3);
%plot([0:length(wave4)-1]/sampfreq,wave4);

window1 = gausswin(1000);
wave5 = conv(window1, wave4);
wave6 = diff(wave5);

x1 = zeros(length(wave4),1);
i1 = 1;
for i = 1: length(wave4)
    if(wave5(i) == 0)
        if(wave6(i) <= -0.000000001)
            x1(i1) = i;
            i1 = i1 + 1;
        end
    end
end



figure(2);
plot([0:length(wave)-1]/sampfreq,wave);
hold on;

i = 1;
while(x1(i) ~= 0)
    plot(x1(i)*length(wave)*16.38,0,'.','MarkerSize',10,'Color','r');
    hold on;
    i = i + 1;
end
%}