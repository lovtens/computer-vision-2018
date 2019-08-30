% problem 1.2b (gaussian noise case)

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

win5 = ones(5,5);

Ix2_5 = filter2(win5, Ix2,'same');
Iy2_5 = filter2(win5, Iy2,'same');
Ixy_5 = filter2(win5, Ixy,'same');

Harmonic = ones(row, col);
for x=1:row
   for y=1:col
     H5 = [Ix2_5(x,y) Ixy_5(x,y); Ixy_5(x,y) Iy2_5(x,y)];
     Harmonic(x,y) = det(H5)/trace(H5);
   end
end

figure;
subplot(2,2,1)
imshow(img,[]); title('Original');
subplot(2,2,2)
imshow(Harmonic,[]); title('Original detected');

%apply noise

img = imnoise(img,'gaussian',3/255);
row = size(img, 1); % # rows
col = size(img, 2); % # col

filt_hor = [-1 1];
filt_ver = [-1; 1];

Ix = conv2(img, filt_hor,'same');
Iy = conv2(img, filt_ver,'same');

Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy = Ix.*Iy;

win5 = ones(5,5);


Ix2_5 = filter2(win5, Ix2,'same');
Iy2_5 = filter2(win5, Iy2,'same');
Ixy_5 = filter2(win5, Ixy,'same');


Harmonic = ones(row, col);
for x=1:row
   for y=1:col
     H5 = [Ix2_5(x,y) Ixy_5(x,y); Ixy_5(x,y) Iy2_5(x,y)];
     Harmonic(x,y) = det(H5)/trace(H5);
   end
end


subplot(2,2,3)
imshow(img,[]); title('With noise');
subplot(2,2,4)
imshow(Harmonic,[]); title('Noise detected');


