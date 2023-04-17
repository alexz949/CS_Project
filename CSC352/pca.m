A1 = [47,15;93,35;53,15;45,10;67,27;42,10];
[U, S, V] = svd(A1);
disp(S);
res = S(1,1) * U(:,1) * V(:,1)';
disp(res);
disp(A1);

a = norm(res-A1) / norm(A1);
disp(a);

figure();
height = [47,46.70;93,94.03;53,52.08;45,43.39;67,68.29;42,40.70];
b = bar(height);
title("Actual Height and Approx Height");
xlabel("row index");

xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
legend(b, {'Actual', 'Approx'});

figure();
weight = [15 15.88;35 31.97 ;15 17.70;10 14.75;27 23.21;10 13.83];
w = bar(weight);
title("Actual Weight and Approx Weight");
xlabel("row index");

xtips1 = w(1).XEndPoints;
ytips1 = w(1).YEndPoints;
labels1 = string(w(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
xtips2 = w(2).XEndPoints;
ytips2 = w(2).YEndPoints;
labels2 = string(w(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
legend(w, {'Actual', 'Approx'});