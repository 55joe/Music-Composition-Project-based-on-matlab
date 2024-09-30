inter = 2^(1/12);
basefreq = 220 * inter^8; %baseFreq=C4 in this song

sampfreq = 8000;
beat = 0.6;

%read file
leflyric = [];
fid = fopen('data2.txt', 'r');
if fid == -1
    error('无法打开文件');
end

tline = fgetl(fid);
while ischar(tline)
    values = sscanf(tline, '%d %d');
    leflyric = [leflyric; values'];
    tline = fgetl(fid);
end

fclose(fid);

riglyric = [];
fid = fopen('data1.txt', 'r');
if fid == -1
    error('无法打开文件');
end

tline = fgetl(fid);
while ischar(tline)
    values = sscanf(tline, '%d %d');
    riglyric = [riglyric; values'];
    tline = fgetl(fid);
end

fclose(fid);


% translate
for i=1:208
    leflyric(i,2)=leflyric(i,2)/4;
    for k=1
    switch leflyric(i,k)
        case {12}
            leflyric(i,k)=-24;
        case {22}
            leflyric(i,k)=-22;
        case {32}
            leflyric(i,k)=-20;
        case {42}
            leflyric(i,k)=-19;
        case {52}
            leflyric(i,k)=-17;
        case {62}
            leflyric(i,k)=-15;
        case {72}
            leflyric(i,k)=-13;
        
        case {13}
            leflyric(i,k)=-12;
        case {23}
            leflyric(i,k)=-10;
        case {33}
            leflyric(i,k)=-8;
        case {43}
            leflyric(i,k)=-7;
        case {53}
            leflyric(i,k)=-5;
        case {63}
            leflyric(i,k)=-3;
        case {73}
            leflyric(i,k)=-1;

        case {14}
            leflyric(i,k)=0;
        case {24}
            leflyric(i,k)=2;
        case {34}
            leflyric(i,k)=4;
        case {44}
            leflyric(i,k)=5;
        case {54}
            leflyric(i,k)=7;
        case {64}
            leflyric(i,k)=9;
        case {74}
            leflyric(i,k)=11;
 
        case {15}
            leflyric(i,k)=12;
        case {25}
            leflyric(i,k)=14;
        case {35}
            leflyric(i,k)=16;
        case {45}
            leflyric(i,k)=17;
        case {55}
            leflyric(i,k)=19;
        case {65}
            leflyric(i,k)=21;
        case {75}
            leflyric(i,k)=23;
    end
    end
end

for i=1:216
    riglyric(i,2)=riglyric(i,2)/4;
    for k=1
    switch riglyric(i,k)
        case {12}
            riglyric(i,k)=-24;
        case {22}
            riglyric(i,k)=-22;
        case {32}
            riglyric(i,k)=-20;
        case {42}
            riglyric(i,k)=-19;
        case {52}
            riglyric(i,k)=-17;
        case {62}
            riglyric(i,k)=-15;
        case {72}
            riglyric(i,k)=-13;
        
        case {13}
            riglyric(i,k)=-12;
        case {23}
            riglyric(i,k)=-10;
        case {33}
            riglyric(i,k)=-8;
        case {43}
            riglyric(i,k)=-7;
        case {53}
            riglyric(i,k)=-5;
        case {63}
            riglyric(i,k)=-3;
        case {73}
            riglyric(i,k)=-1;

        case {14}
            riglyric(i,k)=0;
        case {24}
            riglyric(i,k)=2;
        case {34}
            riglyric(i,k)=4;
        case {44}
            riglyric(i,k)=5;
        case {54}
            riglyric(i,k)=7;
        case {64}
            riglyric(i,k)=9;
        case {74}
            riglyric(i,k)=11;
 
        case {15}
            riglyric(i,k)=12;
        case {25}
            riglyric(i,k)=14;
        case {35}
            riglyric(i,k)=16;
        case {45}
            riglyric(i,k)=17;
        case {55}
            riglyric(i,k)=19;
        case {65}
            riglyric(i,k)=21;
        case {75}
            riglyric(i,k)=23;
    end
    end
end

%parameters
a=100;
b=10;
c=2.5;
d=0.0082;
mag=[1 0.3 0.1];%amplitude of harmonics

lefmusic = [];
for i=1:208
    t = linspace(0,beat*leflyric(i,2),sampfreq*beat*leflyric(i,2));
    z1 = sin(2*pi*(inter^(leflyric(i,1)))*basefreq*t);
    z2 = sin(4*pi*(inter^(leflyric(i,1)))*basefreq*t);
    z3 = sin(6*pi*(inter^(leflyric(i,1)))*basefreq*t);

    %envelop function
    %func1
    x1 = linspace(0, beat/6, sampfreq*beat*leflyric(i,2)/6);
    y1 = x1 .* (exp(-b*x1) .^c);
    %func2
    x2 = linspace(beat/6, beat*4.5/6, sampfreq*beat*leflyric(i,2)*3.5/6);
    dd = linspace(d, d, sampfreq*beat*leflyric(i,2)*3.5/6);
    y2 = dd;
    %func3
    x3 = linspace(beat*4.5/6, beat, sampfreq*beat*leflyric(i,2)*1.5/6);
    y3 = (x3-0.35) .* (exp(-b*(x3-0.35)) .^c);
    %combination
    envfunct = a*[y1 y2 y3];

    lefmusic = [lefmusic, mag(1)*z1.* envfunct+mag(2)*z2.* envfunct+mag(3)*z3.* envfunct];%multiply
end

rigmusic = [];
for i=1:216
    t = linspace(0,beat*riglyric(i,2),sampfreq*beat*riglyric(i,2));
    z1 = sin(2*pi*(inter^(riglyric(i,1)))*basefreq*t);
    z2 = sin(4*pi*(inter^(riglyric(i,1)))*basefreq*t);
    z3 = sin(6*pi*(inter^(riglyric(i,1)))*basefreq*t);

    %envelop function
    %func1
    x1 = linspace(0, beat/6, sampfreq*beat*riglyric(i,2)/6);
    y1 = x1 .* (exp(-b*x1) .^c);
    %func2
    x2 = linspace(beat/6, beat*4.5/6, sampfreq*beat*riglyric(i,2)*3.5/6);
    dd = linspace(d, d, sampfreq*beat*riglyric(i,2)*3.5/6);
    y2 = dd;
    %func3
    x3 = linspace(beat*4.5/6, beat, sampfreq*beat*riglyric(i,2)*1.5/6);
    y3 = (x3-0.35) .* (exp(-b*(x3-0.35)) .^c);
    %combination
    envfunct = a*[y1 y2 y3];

    rigmusic = [rigmusic, mag(1)*z1.* envfunct+mag(2)*z2.* envfunct+mag(3)*z3.* envfunct];%multiply
end

%play two parts at the same time
%sound(lefmusic,sampfreq);
%plot(lefmusic);
music = lefmusic + rigmusic;
sound(music,sampfreq);
audiowrite('C:\Users\LJW\Desktop\音乐合成大作业\hw_result\result1_5.wav', music, sampfreq,'BitsPerSample',32);%cut down to save
