function [ FEATURE_MATRIX ] = featureMatrix_Construct( )

%{
This function constructs the feature matrix for all records of all cases

FEATURE_MATRIX -> lfeature matrix for all records of all cases
%}

dataDir = '.\Data';   %path to the directory where the data is stored

FEATURE_MATRIX = [];
%extract the names of all cases in the data directory(chb01 to chb24)
cases = dir(dataDir);
cases = {cases.name};   %convert the names into string cells
cases = cases([3:length(cases)]); %execlude the directories '.' and '..' 

for case_iter = cases
     if ( isdir( [dataDir '\' char(case_iter)] ) ) %check if it's a directory
         
        %extract the names of all the records for the specified case
        records = dir([dataDir '\' char(case_iter) '\ch*.mat']);
        records = {records.name};
        
        
        %loop through the records of the specified case
        for rec = [1:length(records)]
            fprintf('constructing feature matrix case: %s record: %d\n',char(case_iter), rec);
            %load the record
            load([dataDir '\' char(case_iter) '\' char(records(rec))])
            FEATURE_MATRIX = [FEATURE_MATRIX; features];
        end
     end
end

end

