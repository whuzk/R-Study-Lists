% Example 7.7.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Generate the data set X12
randn('seed',0)
m=[0 0; 10 0; 0 9; 9 8];
[n_clust,l]=size(m);
S(:,:,1)=eye(2);
S(:,:,2)=[1.0 .2; .2 1.5];
S(:,:,3)=[1.0 .4; .4 1.1];
S(:,:,4)=[.3 .2; .2 .5];
n_points=10*ones(1,4);
X12=[];
for i=1:n_clust
    X12=[X12; mvnrnd(m(i,:),S(:,:,i),n_points(i))];
end
X12=X12';
[l,N]=size(X12);

% Plot X12 (see Figure 7.14(a))
figure(1),plot(X12(1,:),X12(2,:),'.b')

% 2. Compute the distance matrix for the data vectors of X12
for i=1:N
    for j=i+1:N
        dista(i,j)=distan(X12(:,i),X12(:,j));
        dista(j,i)=dista(i,j);
    end
end

% Stack the computed distances to a data vector
dist_vec=[];
for i=1:N-1
    dist_vec=[dist_vec dista(i,i+1:N)];
end

% 3. Apply the single link algorithm on X12 and draw the corresponding
% dissimilarity dendrogram

Z=linkage(dist_vec,'single');
[bel,thres]=agglom(dista,1); % 1 for single, 2 for complete link
figure(2), dendrogram(Z);

% 4. Determine the clusterings of the hierarchy generated by the single link
% algorithm, that best fit the underlying structure of X12

[lambda,cut_point_tot,hist_cut] = dendrogram_cut(bel,dista,3); 
% The last input argument, i.e., 3, is the figure handle. If it is omitted, 
% then figure(1) is used.
