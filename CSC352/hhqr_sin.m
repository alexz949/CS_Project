% testing with sin of sums example
clear

maxNumCompThreads(1)
addpath('tensor_toolbox-master')

% form sin of sums
d = 7; %number of modes
r = d;
maxiter = 40;
tol = 0;
rng(0)

sizes = floor(2^(3:.5:10));
ratio = zeros(1,length(sizes));
for i = 1:length(sizes)
    n = sizes(i); %dimension of tensor
    T = sinsum_full(d,n); % rank 2^(d-1) representation

    % init
    [~,U_init,~] = cp_als_t(T,r,'maxiters',1,'tol',tol,'printitn',10,'errmethod','fast');

    % CP-ALS
    [M_als,U_als,out_als] = cp_als_t(T,r,'init',U_init,'maxiters',maxiter,'tol',tol,'printitn',10,'errmethod','fast');
    
    % MGS
    [M_mgs,~,out_mgs] = cp_als_qr_mgs(T,r,'init',U_init,'maxiters',maxiter,'tol',tol,'printitn',10,'errmethod','fast');

    ratio(i) = sum(out_als.times,'all')/sum(out_mgs.times,'all');
    
    if n == 16
        err_als = out_als.relerr_vec;
        err_mgs = out_mgs.relerr_vec;
    end
end
    
save('mgs_comp.mat','ratio','err_als','err_mgs','sizes')



%% plot of iteration vs relative error

figure,
subplot(1,2,1)
semilogy(1:40,err_als,'linewidth',2), hold on
semilogy(1:40,err_mgs,'-.','linewidth',2)
%ylim([1e-12 10])
legend('CP-ALS','CP-ALS-QR-MGS')
xlabel('iteration number')
ylabel('relative error')
title('Relative Error, n = 16') 
set(gca,'fontsize',16)

subplot(1,2,2)
semilogx(sizes,ratio,'linewidth',2)
xlim([2^(2.8) sizes(end)+50])
%legend('CP-ALS','CP-ALS-QR-MGS')
xlabel('n')
ylabel('speedup factor')
xticks(sizes(1:4:end))
title('Speedup Factor of MGS over Normal Equations') 
set(gca,'fontsize',16)


