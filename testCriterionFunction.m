function classout = testCriterionFunction(XTRAIN, YTRAIN, XTEST, sigma, C)

%opts = statset('MaxIter',1000000, 'Display', 'iter');
model = fitcsvm(XTRAIN, YTRAIN, 'KernelFunction','rbf',...
                'KernelScale', sigma, 'BoxConstraint', C,...
                'Verbose', 1, ...
                'NumPrint', 100, ...
                'Standardize', 1);
classout = predict(model, XTEST);

%performance analysis
%CP = classperf(YTEST, classout);

%extract the error rate for later optimization
%testval = CP.ErrorRate;

end