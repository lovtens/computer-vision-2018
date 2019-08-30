% problem 1.3

img = imread('scene.pgm');

Threshold = 10000;
row = size(img, 1); % # rows
col = size(img, 2); % # col

filt_hor = [-1 1];
filt_ver = [-1; 1];

Ix = conv2(img, filt_hor,'same');
Iy = conv2(img, filt_ver,'same');

Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy = Ix.*Iy;

win = ones(5,5);

sum_Ix2 = filter2(win, Ix2,'same');
sum_Iy2 = filter2(win, Iy2,'same');
sum_Ixy = filter2(win, Ixy,'same');

Harmonic = ones(row, col); % for harmonic mean img
tmp = zeros(row,col); % tmp (img cut by threshold)
Local = zeros(row,col); %for local maxima img

%harmonic mean img
for x=1:row
   for y=1:col
     H = [sum_Ix2(x,y) sum_Ixy(x,y); sum_Ixy(x,y) sum_Iy2(x,y)];
     R = det(H)/trace(H);
     Harmonic(x,y) = R;
     if(R>Threshold)
        tmp(x,y) = R;
     end
   end
end

%local maxima img
for x=1:row
   for y=1:col
    sub = zeros(5,5);
    for i=x-2:x+2
        for j=y-2:y+2
            if(row<i || i<1 || col<j || j<1)
            else
                sub(i-x+3,j-y+3) = tmp(i,j);
            end
        end
    end
    if(max(max(sub)) ~= 0)
        maxima = imregionalmax(sub);
        [r,c] = find(maxima==1,1);
        if(r==3 && c==3)
            Local(x+r,y+c) = 1;
        end
    end
   end
end

figure;
subplot(1,3,1)
imshow(img,[]); title('Original');
subplot(1,3,2)
imshow(Harmonic,[]); title('Harmonic');
subplot(1,3,3)
imshow(Local,[]); title('Local maxima');


