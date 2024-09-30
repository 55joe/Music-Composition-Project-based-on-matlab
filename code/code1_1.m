inter = 2^(1/12);
basefreq = 220 * inter^8; %baseFreq=F4 in this song

sampfreq = 8000;
beat = 0.5;

%freq used in this song
sound1 = basefreq;
sound5 = basefreq * inter^7;
sound6 = basefreq * inter^9;
sound2 = basefreq * inter^2;
sound6low = basefreq / (inter^3);

%  test the sounds
%{
t = linspace(0,beat,sampfreq*beat);
y = sin(2*pi*sound1*t);
sound(y,sampfreq);
pause(0.8);

y = sin(2*pi*sound5*t);
sound(y,sampfreq);
pause(0.8);

y = sin(2*pi*sound6*t);
sound(y,sampfreq);
pause(0.8);

y = sin(2*pi*sound2*t);
sound(y,sampfreq);
pause(0.8);

y = sin(2*pi*sound6low*t);
sound(y,sampfreq);
pause(0.8);
%}

%  play the music
mfreq = [
    sound5;sound5;sound6;
    sound2;
    sound1;sound1;sound6low;
    sound2
];%frequnce sequnce of the song

beats= [
    beat;0.5*beat;0.5*beat;
    2*beat;
    beat;0.5*beat;0.5*beat;
    2*beat;
];%beats sequnce of the song

music = [];
for i=1:8
    t = linspace(0,beats(i),sampfreq*beats(i));
    y = sin(2*pi*mfreq(i)*t);
    music = [music, y];
end

sound(music,sampfreq);
audiowrite('C:\Users\LJW\Desktop\音乐合成大作业\hw_result\result1_1.wav', music, sampfreq);
