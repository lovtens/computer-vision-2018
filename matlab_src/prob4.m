% problem 1.4

img = imread('scene.pgm');
img = imnoise(img,'gaussian',3/255);
i = 0;
for w=3:2:9
    i = i+1;
    row = size(img, 1); % # rows
    col = size(img, 2); % # col
    
    filt_hor = [-1 1];
    filt_ver = [-1; 1];

    Ix = conv2(img, filt_hor,'same');
    Iy = conv2(img, filt_ver,'same');

    Ix2 = Ix.^2;
    Iy2 = Iy.^2;
    Ixy = Ix.*Iy;
    
    win = ones(w,w);

    sum_Ix2 = filter2(win, Ix2,'same');
    sum_Iy2 = filter2(win, Iy2,'same');
    sum_Ixy = filter2(win, Ixy,'same');

    Harmonic = ones(row, col); % for harmonic mean img
    for x=1:row
       for y=1:col
         H = [sum_Ix2(x,y) sum_Ixy(x,y); sum_Ixy(x,y) sum_Iy2(x,y)];
         R1 = det(H)/trace(H);
         Harmonic(x,y) = R1;
       end
    end
    subplot(1,4,i);imshow(Harmonic,[]); 
end



