% read image, get the original matrix
pic = imread('./Classification.png');

% manually define random 10 points for each class
x=zeros(3,10,5);
colors=zeros(3,5);
% class 1:Sea   class 2: Trees  class 3: Road   class 4: grass
% class 5: Empty Area

% Class 1 distinctive color. White
colors(:,1)=[255;255;255];
% class 1. Sea
x(:,1,1)= pic(100,100,:);
x(:,2,1)= pic(50,30,:);
x(:,3,1)= pic(80,50,:);
x(:,4,1)= pic(106,237,:);
x(:,5,1)= pic(151,219,:);
x(:,6,1)= pic(220,145,:);
x(:,7,1)= pic(320,65,:);
x(:,8,1)= pic(79,90,:);
x(:,9,1)= pic(131,322,:);
x(:,10,1)=pic(160,52,:);

% Class 2 Distinctive color. Black
colors(:,2)=[0;0;0];
% class 2. Trees
x(:,1,2)= pic(173,415,:);
x(:,2,2)= pic(318,336,:);
x(:,3,2)= pic(402,255,:);
x(:,4,2)= pic(445,284,:);
x(:,5,2)= pic(344,367,:);
x(:,6,2)= pic(441,182,:);
x(:,7,2)= pic(338,372,:);
x(:,8,2)= pic(286,397,:);
x(:,9,2)= pic(361,310,:);
x(:,10,2)=pic(462,153,:);

% Class 3 Distinctive color. Red
colors(:,3)=[255;0;0];
% class 3, Road
x(:,1,3)= pic(316,414,:);
x(:,2,3)= pic(162,477,:);
x(:,3,3)= pic(34,493,:);
x(:,4,3)= pic(153,538,:);
x(:,5,3)= pic(342,492,:);
x(:,6,3)= pic(379,603,:);
x(:,7,3)= pic(324,409,:);
x(:,8,3)= pic(140,563,:);
x(:,9,3)= pic(421,534,:);
x(:,10,3)=pic(471,335,:);

% Class 4 Distinctive color. Green
colors(:,4)=[0;255;0];
% class 4: Grass
x(:,1,4)= pic(334,432,:);
x(:,2,4)= pic(386,463,:);
x(:,3,4)= pic(210,580,:);
x(:,4,4)= pic(451,378,:);
x(:,5,4)= pic(189,599,:);
x(:,6,4)= pic(250,603,:);
x(:,7,4)= pic(370,412,:);
x(:,8,4)= pic(418,495,:);
x(:,9,4)= pic(88,529,:);
x(:,10,4)=pic(167,597,:);

% Class 5 Distinctive color. Blue
colors(:,5)=[0;0;255];
% class 5: Empty Area
x(:,1,5)= pic(232,421,:);
x(:,2,5)= pic(290,455,:);
x(:,3,5)= pic(198,436,:);
x(:,4,5)= pic(396,591,:);
x(:,5,5)= pic(446,595,:);
x(:,6,5)= pic(15,450,:);
x(:,7,5)= pic(304,596,:);
x(:,8,5)= pic(203,491,:);
x(:,9,5)= pic(397,577,:);
x(:,10,5)=pic(46,419,:);

% Learning Peroid
mean_vector=zeros(3,5);
cov_matrix =zeros(3,3,5);
% loop. for each class
for m=1:5
% calc the mean vector and the covariance matrix
    mean_vector(1,m)=mean(x(1,:,m));
    mean_vector(2,m)=mean(x(2,:,m));
    mean_vector(3,m)=mean(x(3,:,m));
    % To calc the covariance
    Temp=zeros(10,3);
    Temp(:,1)=x(1,:,m);
    Temp(:,2)=x(2,:,m);
    Temp(:,3)=x(3,:,m);
    cov_matrix(:,:,m)=cov(Temp);
% end loop.
end
% Copy the picture
output=pic;
% loop. go over all the pixels in the pic
for m=1:480
    for n=1:618
        point=zeros(3,1);
        point(1,1)=pic(m,n,1);
        point(2,1)=pic(m,n,2);
        point(3,1)=pic(m,n,3);
% calc the E dis and the M dis between the mean vector
        min_E_dist=255;
        min_M_dist=255;
        min_E_index=0;
        min_M_index=0;
        for k=1:5
            % Euclidean distance
            E_dist=sqrt((point(1,1)-mean_vector(1,k))^2+(point(2,1)-mean_vector(2,k))^2+(point(3,1)-mean_vector(3,k))^2);
            % Mahalanobis distance
            M_dist=(point-mean_vector(:,k))'*inv(cov_matrix(:,:,k))*(point-mean_vector(:,k))*10^(-7);
            
            % Find the min Euclidean distance
            if E_dist<min_E_dist
                min_E_dist=E_dist;
                min_E_index=k;
            end
            
            % Find the min Mahalanobis distance
            if M_dist<min_M_dist
                min_M_dist=M_dist;
                min_M_index=k;
            end
            
        end
        
% classify
% when need to use the Mahalanobis Distance to calc, replace the "min_E_index" with "min_M_index" below
    output(m,n,1)=colors(1,min_E_index);
    output(m,n,2)=colors(2,min_E_index);
    output(m,n,3)=colors(3,min_E_index);
    end
end
% end loop.

% save the result image to disk. In this case, the Eulidean Distance result.
imwrite(output,'./EuclideanDistance Result.jpg','jpg');
