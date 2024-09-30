inter = 2^(1/12);
basefreq = 220 * inter^8; %baseFreq=F4 in this song

sampfreq = 8000;
beat = 0.6;

%freq used in this song
sound1 = basefreq;
sound5 = basefreq * inter^7;
sound6 = basefreq * inter^9;
sound2 = basefreq * inter^2;
sound6low = basefreq / (inter^3);

%  play the music
mfreq = [
    sound5;sound5;sound6;
    sound2;
    sound1;sound1;sound6low;
    sound2
];%frequnce sequnce of the song

beats= [
    1;0.5;0.5;
    2;
    1;0.5;0.5;
    2;
];%beats sequnce of the song

%parameters
a=100;
b=10;
c=2.5;
d=0.0082;
mag=[1 0.2 0.3];%amplitude of harmonics

music = [];
for i=1:8
    t = linspace(0,beat*beats(i),sampfreq*beat*beats(i));
    z1 = sin(2*pi*mfreq(i)*t);
    z2 = sin(4*pi*mfreq(i)*t);
    z3 = sin(6*pi*mfreq(i)*t);

    %envelop function
    %func1
    x1 = linspace(0, beat/6, sampfreq*beat*beats(i)/6);
    y1 = x1 .* (exp(-b*x1) .^c);
    %func2
    x2 = linspace(beat/6, beat*4.5/6, sampfreq*beat*beats(i)*3.5/6);
    dd = linspace(d, d, sampfreq*beat*beats(i)*3.5/6);
    y2 = dd;
    %func3
    x3 = linspace(beat*4.5/6, beat, sampfreq*beat*beats(i)*1.5/6);
    y3 = (x3-0.35) .* (exp(-b*(x3-0.35)) .^c);
    %combination
    envfunct = a*[y1 y2 y3];

    music = [music, mag(1)*z1.* envfunct+mag(2)*z2.* envfunct+mag(3)*z3.* envfunct];%multiply
end

sound(music,sampfreq);
%audiowrite('C:\Users\LJW\Desktop\音乐合成大作业\hw_result\result1_4.wav', music, sampfreq,'BitsPerSample',32);%cut down to save
plot([0:length(music)-1],music);title('Plot of music');