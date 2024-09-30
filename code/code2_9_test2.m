%first attempt to find the beats
sampfreq = 8000;

wave = audioread('fmt.wav');

wave1 = wave .^ 2;

plot(wave);
hold on;

flag = zeros(length(wave1),1);
j = 1;
for i = 101:length(wave1)-100
    if(wave1(i)>wave1(i-1)&&wave1(i)>wave1(i+1))
        x=0;    
        for i1 = 1:100
            x = x+wave1(i-i1);
        end
        x=x/100;
        if(wave1(i)>x*9)%bigger than 9 times of the average of the former 100 values 
            y=0;
            for i2 = 1:100
                y = y+wave1(i+i2);
            end
            y=y/100;
            if(wave1(i)>y*4)%bigger than 4 times of the average of the following 100 values 
                flag(j) = i;
                plot(flag(j),0,'.','MarkerSize',10,'Color','r');
                hold on;
                j = j + 1;
            end
        end
    end
end
