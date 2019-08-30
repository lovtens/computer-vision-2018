% problem 1.2

img = imread('scene.pgm');

row = size(img, 1); % # rows
col = size(img, 2); % # col

filt_hor = [-1 1];
filt_ver = [-1; 1];

Ix = conv2(img, filt_hor,'same');
Iy = conv2(img, filt_ver,'same');

Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy = Ix.*Iy;

win3 = ones(3,3);
win5 = ones(5,5);
win9 = ones(9,9);

%by window 3x3
Ix2_3 = filter2(win3, Ix2,'same');
Iy2_3 = filter2(win3, Iy2,'same');
Ixy_3 = filter2(win3, Ixy,'same');
%by window 5x5
Ix2_5 = filter2(win5, Ix2,'same');
Iy2_5 = filter2(win5, Iy2,'same');
Ixy_5 = filter2(win5, Ixy,'same');
%by window 9x9
Ix2_9 = filter2(win9, Ix2,'same');
Iy2_9 = filter2(win9, Iy2,'same');
Ixy_9 = filter2(win9, Ixy,'same');
%for harmonic
Harmonic3 = ones(row, col);
Harmonic5 = ones(row, col);
Harmonic9 = ones(row, col);

for x=1:row
   for y=1:col
     H3 = [Ix2_3(x,y) Ixy_3(x,y); Ixy_3(x,y) Iy2_3(x,y)];
     H5 = [Ix2_5(x,y) Ixy_5(x,y); Ixy_5(x,y) Iy2_5(x,y)];
     H9 = [Ix2_9(x,y) Ixy_9(x,y); Ixy_9(x,y) Iy2_9(x,y)];
     Harmonic3(x,y) = det(H3)/trace(H3);
     Harmonic5(x,y) = det(H5)/trace(H5);
     Harmonic9(x,y) = det(H9)/trace(H9);
   end
end


figure;
subplot(2,2,1)
imshow(img,[]); title('Original');
subplot(2,2,2)
imshow(Harmonic3,[]); title('3x3');
subplot(2,2,3)
imshow(Harmonic5,[]); title('5x5');
subplot(2,2,4)
imshow(Harmonic9,[]); title('9x9');


