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
mag=[0.00930808038628289	1	0.293305613373285	0.169737638034249	0.200136659128818	0.0713614093045666	0.0574030722250183	0.0476608246566383	0.0258219480010000	0.00962070403063404	0.0117246781432514	0.00660190897152332	0.00663787873306357;
    0.00683811544843795	1	0.589903431516292	0.225217588311743	0.120908594179619	0.0414767387527344	0.0620724697615562	0.0555673159281592	0.0150107042986480	0.0111667169860774	0.0130522097694273	0.0136587055573310	0.00813215512486264;
    0.00160033781401032	1	0.724176810750910	0.143502871488931	0.0137855587349455	0.0157206847694420	0.157302217749932	0.0218538587744230	0.00377371610844771	0.0273966113108815	0.0195473989837485	0.00587000785870979	0.00121309826400934;
    0.00824243763425350	1	0.936438892205545	0.663051804966922	0.127356362268576	0.0768475434830169	0.120255217743459	0.239426298458058	0.0539896001983075	0.0124054029852894	0.0232947374921988	0.0225785637864416	0.0673596188324538;
    0.00195293527086090	1	1.00785860838882	0.176592172737911	0.0837916724525666	0.100761499977147	0.132040570233770	0.0556155936327517	0.0426280958105933	0.107763374601203	0.108217230714556	0.00537480151113308	0.00874585328923001];%amplitude of harmonics

music = [];
j=1;
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
    if(i == 1)
        j = 2;
    elseif(i == 2)
        j = 2; 
    elseif(i == 3)
        j = 3;
    elseif(i == 4)
        j = 4;
    elseif(i == 5)
        j = 1;
    elseif(i == 6)
        j = 1;
    elseif(i == 7)
        j = 5;
    elseif(i == 8)
        j = 4;
    else
        j = 1;
    end

    music = [music, mag(j,1)*z1.* envfunct+mag(j,2)*z2.* envfunct+mag(j,3)*z3.* envfunct+mag(j,4)*z4.* envfunct+mag(j,5)*z5.* envfunct+mag(j,6)*z6.* envfunct+mag(j,7)*z7.* envfunct+mag(j,8)*z8.* envfunct+mag(j,9)*z9.* envfunct+mag(j,10)*z10.* envfunct+mag(j,11)*z11.* envfunct+mag(j,12)*z12.* envfunct+mag(j,13)*z13.* envfunct];%multiply
end

sound(music,sampfreq);
audiowrite('C:\Users\LJW\Desktop\音乐合成大作业\hw_result\result3_11.wav', music, sampfreq,'BitsPerSample',32);%cut down to save
plot([0:length(music)-1],music);title('Plot of music');