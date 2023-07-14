load("six_way_err.mat")

figure,
semilogy(six_way_err(:,1),six_way_err(:,2)), hold on
semilogy(six_way_err(:,1),six_way_err(:,3))
semilogy(six_way_err(:,1),six_way_err(:,4))
semilogy(six_way_err(:,1),six_way_err(:,5))
legend('True err','Explicit QR err', 'Normal EQ err', 'Pairwise Elim err')

ylabel('relative residual')
xlabel('dimensions')
title('5-way ktensor, K = 4e11')