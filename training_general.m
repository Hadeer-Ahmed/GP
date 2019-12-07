
%directory where the features matrix and the corresponding labels are stored%
featureMatrixDir = 'G:\FeatureMatrix\chb03_features_labels.mat';

load(featureMatrixDir);

k_fold = 10;     % number of folds for cross-validation

%%%%% Normalization of features %%%%%
%svmtrain() normalizes the features by default



%trying exponentially growing sequences of C and gamma is a practical
%method to identify good parammeters
C_range = 2.^[-5:2:15]; %%C = [2^-5, 2^-3,...., 2^15]
sigma_renge = 2.^[-15:2:3]; %%sigma = [2^-15, 2^-13,...., 2^3]

minmimizationFunction = @(lossEstimate)crossval(testCriterionFunction, feature_matrix_case, label_vector_case,...
                                        'kfold', k_fold,...
                                        'boxconstraint', lossEstimate.C_range,...
                                        'rbf_sigma', lossEstimate.sigma_range);

%{
%partitioning the data for cross-validation
%%%%XXX%%partition = cvpartition(label_vector_case, 'KFold',k_fold);
cv_indices = crossvalind('KFold', label_vector_case, k_fold);



function model=trainf(x, y)
for i = 1: k_fold
    testidx = (cv_indices == i); %select one fold for testing in each iteration
    trainidx = ~testidx;        % the rest of the folds will be used for training
    
    xtest = feature_matrix_case(testidx, :);
    ytest = label_vector_case(testidx, :);
    
    xtrain = feature_matrix_case(trainidx, :);
    ytrain = label_vector_case(trainidx, :);
    
    model = svmtrain(xtrain, ytrain, 'kernel_function','rbf');
    
end
end
%}

