%(1)
T = tenrand(20,20,20);
%(2)
tenmat(T,1);
%(3)
A = rand(4,20);
B = rand(10,20);
C = rand(8,20);
%(4)
D = ttm(T,{A,B,C});

%visualizing
%(1)
%(2)

Hs = squeeze(density(1024,:,:));
%Hs = reshape(Hs,[256,256]);
Ls = squeeze(density(:,128,:));
%Ls = reshape(Ls,[2048,256]);
Fs = squeeze(density(:,:,128));
%Fs = reshape(Fs, [2048,256]);

figure;
subplot(1,3,1);
imagesc(Fs);
subplot(1,3,2);
imagesc(Hs);
subplot(1,3,3);
imagesc(Ls);

%(3) yes

%(4) Hs turns to single color when using 1 and 2048


%% 

%low rank
%(1)
%(2)
T1 = HOSVD(T,3,3,3);





