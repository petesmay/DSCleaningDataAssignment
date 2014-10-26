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

### Column 1: Subject
Integer.

Range: 1-30

Identifies the subject who performed the activity

### Column 2: Activity
Factor.

Values: 
* walking
* walking upstairs
* walking downstairs
* sitting
* standing
* laying

Indicates the activity performed by the subject

### Columns 3-68:
Numeric.

Values: Each column's value is a normalised values in the range [-1, 1]

Each variable represents either the Mean or Standard Deviations as described by each column heading (in order):

* "TimeBodyAccelerationMeanXAxis"                          
* "TimeBodyAccelerationMeanYAxis"                          
* "TimeBodyAccelerationMeanZAxis"                          
* "TimeBodyAccelerationStandardDeviationXAxis"             
* "TimeBodyAccelerationStandardDeviationYAxis"             
* "TimeBodyAccelerationStandardDeviationZAxis"             
* "TimeGravityAccelerationMeanXAxis"                       
* "TimeGravityAccelerationMeanYAxis"                       
* "TimeGravityAccelerationMeanZAxis"                       
* "TimeGravityAccelerationStandardDeviationXAxis"          
* "TimeGravityAccelerationStandardDeviationYAxis"          
* "TimeGravityAccelerationStandardDeviationZAxis"          
* "TimeBodyAccelerationJerkMeanXAxis"                      
* "TimeBodyAccelerationJerkMeanYAxis"                      
* "TimeBodyAccelerationJerkMeanZAxis"                      
* "TimeBodyAccelerationJerkStandardDeviationXAxis"         
* "TimeBodyAccelerationJerkStandardDeviationYAxis"         
* "TimeBodyAccelerationJerkStandardDeviationZAxis"         
* "TimeBodyGyroscopeMeanXAxis"                             
* "TimeBodyGyroscopeMeanYAxis"                             
* "TimeBodyGyroscopeMeanZAxis"                             
* "TimeBodyGyroscopeStandardDeviationXAxis"                
* "TimeBodyGyroscopeStandardDeviationYAxis"                
* "TimeBodyGyroscopeStandardDeviationZAxis"                
* "TimeBodyGyroscopeJerkMeanXAxis"                         
* "TimeBodyGyroscopeJerkMeanYAxis"                         
* "TimeBodyGyroscopeJerkMeanZAxis"                         
* "TimeBodyGyroscopeJerkStandardDeviationXAxis"            
* "TimeBodyGyroscopeJerkStandardDeviationYAxis"            
* "TimeBodyGyroscopeJerkStandardDeviationZAxis"            
* "TimeBodyAccelerationMagnitudeMean"                      
* "TimeBodyAccelerationMagnitudeStandardDeviation"         
* "TimeGravityAccelerationMagnitudeMean"                   
* "TimeGravityAccelerationMagnitudeStandardDeviation"      
* "TimeBodyAccelerationJerkMagnitudeMean"                  
* "TimeBodyAccelerationJerkMagnitudeStandardDeviation"     
* "TimeBodyGyroscopeMagnitudeMean"                         
* "TimeBodyGyroscopeMagnitudeStandardDeviation"            
* "TimeBodyGyroscopeJerkMagnitudeMean"                     
* "TimeBodyGyroscopeJerkMagnitudeStandardDeviation"        
* "FrequencyBodyAccelerationMeanXAxis"                     
* "FrequencyBodyAccelerationMeanYAxis"                     
* "FrequencyBodyAccelerationMeanZAxis"                     
* "FrequencyBodyAccelerationStandardDeviationXAxis"        
* "FrequencyBodyAccelerationStandardDeviationYAxis"        
* "FrequencyBodyAccelerationStandardDeviationZAxis"        
* "FrequencyBodyAccelerationJerkMeanXAxis"                 
* "FrequencyBodyAccelerationJerkMeanYAxis"                 
* "FrequencyBodyAccelerationJerkMeanZAxis"                 
* "FrequencyBodyAccelerationJerkStandardDeviationXAxis"    
* "FrequencyBodyAccelerationJerkStandardDeviationYAxis"    
* "FrequencyBodyAccelerationJerkStandardDeviationZAxis"    
* "FrequencyBodyGyroscopeMeanXAxis"                        
* "FrequencyBodyGyroscopeMeanYAxis"                        
* "FrequencyBodyGyroscopeMeanZAxis"                        
* "FrequencyBodyGyroscopeStandardDeviationXAxis"           
* "FrequencyBodyGyroscopeStandardDeviationYAxis"           
* "FrequencyBodyGyroscopeStandardDeviationZAxis"           
* "FrequencyBodyAccelerationMagnitudeMean"                 
* "FrequencyBodyAccelerationMagnitudeStandardDeviation"    
* "FrequencyBodyAccelerationJerkMagnitudeMean"             
* "FrequencyBodyAccelerationJerkMagnitudeStandardDeviation"
* "FrequencyBodyGyroscopeMagnitudeMean"                    
* "FrequencyBodyGyroscopeMagnitudeStandardDeviation"       
* "FrequencyBodyGyroscopeJerkMagnitudeMean"                
* "FrequencyBodyGyroscopeJerkMagnitudeStandardDeviation"