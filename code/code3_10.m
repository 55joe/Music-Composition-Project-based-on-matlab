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
mag=[0.07 1 1.46 0.96 1.10 0.05 0.11 0.36 0.12 0.14 0.06 0.01 0.01];%amplitude of harmonics

music = [];
for i=1:8
    t = linspace(0,beat*beats(i),sampfreq*beat*beats(i));

    z1 = cos(0*pi*mfreq(i)*t);
    z2 = sin(1*pi*mfreq(i)*t);
    z3 = sin(2*pi*mfreq(i)*t);
    z4 = sin(3*pi*mfreq(i)*t);
    z5 = sin(4*pi*mfreq(i)*t);
    z6 = sin(5*pi*mfreq(i)*t);
    z7 = sin(6*pi*mfreq(i)*t);
    z8 = sin(7*pi*mfreq(i)*t);
    z9 = sin(8*pi*mfreq(i)*t);
    z10 = sin(9*pi*mfreq(i)*t);
    z11 = sin(10*pi*mfreq(i)*t);
    z12 = sin(11*pi*mfreq(i)*t);
    z13 = sin(12*pi*mfreq(i)*t);

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

    music = [music, mag(1)*z1.* envfunct+mag(2)*z2.* envfunct+mag(3)*z3.* envfunct+mag(4)*z4.* envfunct+mag(5)*z5.* envfunct+mag(6)*z6.* envfunct+mag(7)*z7.* envfunct+mag(8)*z8.* envfunct+mag(9)*z9.* envfunct+mag(10)*z10.* envfunct+mag(11)*z11.* envfunct+mag(12)*z12.* envfunct+mag(13)*z13.* envfunct];%multiply
end

sound(music,sampfreq);
audiowrite('C:\Users\LJW\Desktop\音乐合成大作业\hw_result\result3_10.wav', music, sampfreq,'BitsPerSample',32);%cut down to save
plot([0:length(music)-1],music);title('Plot of music');