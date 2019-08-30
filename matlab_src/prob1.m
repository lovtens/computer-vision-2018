% problem 1.1

img = imread('checkerboard.png');

row = size(img, 1); % # rows
col = size(img, 2); % # col

filt_hor = [-1 1];
filt_ver = [-1; 1];

Ix = conv2(img, filt_hor,'same');
Iy = conv2(img, filt_ver,'same');

Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy = Ix.*Iy;

win = ones(3,3);

sum_Ix2 = filter2(win, Ix2,'same');
sum_Iy2 = filter2(win, Iy2,'same');
sum_Ixy = filter2(win, Ixy,'same');


Harmonic = ones(row, col); 
Shitomasi = ones(row, col);

for x=1:row
   for y=1:col
     H = [sum_Ix2(x,y) sum_Ixy(x,y); sum_Ixy(x,y) sum_Iy2(x,y)];
     R1 = det(H)/trace(H);
     R2 = eigs(H,1,'smallestabs');
     Harmonic(x,y) = R1;
     Shitomasi(x,y) = R2;
   end
end


figure;
subplot(1,3,1)
imshow(img,[]); title('Original');
subplot(1,3,2)
imshow(Harmonic,[]); title('Harmonic');
subplot(1,3,3)
imshow(Shitomasi,[]); title('Shi-tomasi');


