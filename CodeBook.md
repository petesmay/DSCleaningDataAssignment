The code book should contain:
1. Information about the variables (including units!) in the data set not contained in the tidy data
2. Information about the summary choices you made
3. Information about the experimental study design you used


## Study Design

### Summary Choices

#### Mean and Standard Deviation selection
Only measurements on the mean and standard deviation for each variable are provided in the tidy data set. These are extracted based on the names in the (originally supplied) features.txt file. 

Variable names with "mean()" and "std()" are the only variables included, as features_info.txt declares these to represent the mean and standard deviation values. 

Variable names with "meanFreq()" are not included as these represent "weighted average of the frequency components to obtain a mean frequency".

Any other mention of "mean" or "Mean" is also ignored and not included.

#### Subject and Test/Training Label Variables
Both these sets of data are included in the original merge of the data sets (see the MergeData function).

#### Variable Labels
Variables are labelled using CamelCase to aid readability due to long expanded names.

## Code Book
