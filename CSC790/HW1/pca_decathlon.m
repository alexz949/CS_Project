%% load data from 1988 Olympics decathlon
%  raw is in units of seconds and meters
%  33 athletes x 10 events
%  points is computed from raw using separate formula for each event
%  athletes has labels for rows
%  events has labels for columns
%  rows are ordered from highest points (gold) to lowest
%  data from https://www.math.umd.edu/~petersd/666/html/decathlonex.html
%    and https://www.olympedia.org/results/63590
load decathlon 
[nathletes,nevents] = size(points);

%% inspect raw and points matrices
events
raw
points

%% run built-in PCA (need statistics toolbox) and check output
%  mu gives column averages (used to center the data before SVD)
[coeff,score,~,~,explained,mu] = pca(points);
rec_error = norm(score*coeff' - (points-mu)) / norm(points-mu)

%% inspect coeff matrix
%  explained gives percent of variance explained by each component
%  coeff rows correspond to events, columns to components (ordered)
%  Observations:
%    * 1st component is almost all positive (except for 1500)
%        with largest values in pole and throwing
%    * 2nd component is pos for running/jumping, neg for throwing
%    * 3rd component is neg for short running and pole, pos else
%    * 1st 5 components explain about 88% of variance
expl = explained'
coeff

%% inspect scores matrix
%  score rows correspond to athletes, columns to components (ordered)
%  Observations:
%    * 1st component separates top half (pos) from bottom half (neg)
%    * 2nd component has pos values for most of top 10
%    * 3rd component separates gold (pos) from silver and bronze (neg)
expl
score

%% visualize athletes in 2D space using 1st two components
%  observe overall horizontal pattern: low ranking to left, high to right
%  observe top 7 finishers all to the top right
%  these two components explain about 60% of variance
figure, hold on
scatter(score(:,1),score(:,2))
text(score(:,1)+5,score(:,2)+5,cellstr(num2str((1:nathletes)')),'FontSize',18)
plot([0,0],[-400,300],'k')
plot([-400,300],[0,0],'k')
title('Athlete Scores in 1st 2 PCs')
hold off

%% visualize events in 2D space using 1st two components
%  observe that short running/jumping get clustered, throwing gets clustered,
%    and 1500 and pole seem to be loners
%  observe that 1500 is only event negative in 1st component
%  observe that pole has largest loading in 1st component
%  these two components explain about 60% of variance
figure, hold on
lambda1 = norm(score(:,1));
lambda2 = norm(score(:,2));
scatter(lambda1*coeff(:,1),lambda2*coeff(:,2))
text(lambda1*coeff(:,1)+5,lambda2*coeff(:,2)+5,events,'FontSize',18)
plot([0,0],[-300,500],'k')
plot([-100,500],[0,0],'k')
title('Event Loadings in 1st 2 PCs')
hold off

%% focus on 2nd component
%  observe pos values for running/jumping, neg for throwing
second_coef = coeff(:,2)
%  observe highest and lowest scores for 2nd component
second_score = score(:,2)
[~,lowest] = min(score(:,2))
[~,highest] = max(score(:,2))
%  observe these athletes' points: they follow the component pattern
lowest_runjump = athletes{lowest}
lowest_runjump_points = points(lowest,:)
highest_runjump = athletes{highest}
highest_runjump_points = points(highest,:) 

%% focus on medal winners
%  observe score values of top 3 athletes
medal_score = score(1:3,:)
%  observe 3rd component, which differentiates gold from silver/bronze
%    and note high value in high jump
third_coeff = coeff(:,3)
%  observe point values of top 3 athletes
medal_points = points(1:3,:)


