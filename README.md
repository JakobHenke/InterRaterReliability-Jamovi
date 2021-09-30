# Inter-Rater Reliability for jamovi
This module provides percent agreement, Holsti's reliability coefficient (average %-agreement between all rates), and Krippendorff's alpha for jamovi. 

## Data structure
Data wrangling can be a challenge in most statistical software packages.
This module is built around a typical data generating process in content analysis: 
A number of raters/coders each code a number of variables for numerous content items (e.g., newspaper articles, TV shows etc.). The resulting data has ID variables which identify the rater/coder as well as the item. 
To perform the analyses, these ID variables are needed.

## Analyses
The module is currently limited to the above-mentioned analyses. Other reliability estimates may be added in future versions. Percent agreement and Krippendorff's alpha have their own menu option because they represent two different classes of reliability estimates (non-chance corrected vs. chance corrected).

### percent agreement
This option allows users to calculate simple percent agreement and Holsti's coefficient for all variables, regardless of their type. Currently not supported is a tolerance option for interval and ratio scales, which are supported by some R packages (e.g., [the irr package](https://cran.r-project.org/web/packages/irr/index.html). This option may be added in the future. For both analyses, the user has the option to omit missing values and add information on the number of raters and cases to the output.

#### Missing Values
One challenge for reliability estimates are missing values. These can either be viewed as containing information (e.g., because there was no fitting code to assign to an item) or as true missing values (e.g., because 1 rater forgot to code some items). Krippendorff's alpha handles missing values automatically, but the same isn't true for percent agreement and the Holsti coefficient.

Missing values can be excluded in two ways:
1. Omit missing values analysis by analysis (i.e, pairwise). This option preserves the maximum amount of data, by keeping all rows and only removing the missing values. For Holsti's coefficient, the percent agreement between each pair of coders is then based on the remaining number of comparisons. This option is the default.
2. Omit missing values listwise. This option removes all cases whit at least one missing value. 


##### Example
Consider the following data set:


| Rater  | Case | Coding|
| :----: |:----:| :----:|
| 1      | 1    | 0     |
| 2      | 1    | 1     |
| 3      | 1    | 0     |
| 1      | 2    | 1     |
| 2      | 2    | 1     |
| 2      | 3    | 1     |
| 3      | 3    | 1     |


To calculate reliability estimates, the data is first converted to a matrix with each column representing a rater and each row a case.

| Rater1 |Rater2| Rater3|
| :----: |:----:| :----:|
| 0      | 1    | 0     |
| 1      | 1    | NA    |
| NA     | 1    | 1     |

We see that only one rater coded each item and only one item was coded by all raters. 


If we decided to omit NAs listwise we'd be left with only one case to compare. The resulting percent-agreement would  be zero, while Holsti's coefficient would be .33. Raters 1 and 3  have perfect agreement (i.e., 1 out of 1) but the agreement between for the other two pairs is 0, resulting in an average of .33

Crucially, the estimates under listwise deletion are based on only 1 case out the 3 we recorded. If NAs are caused by a planned process (e.g., because students decided to split the work or because only the PI coded each case and their collaborators split the work evenly) or if some raters simply forgot to rate all cases, we could decide to retain as much information as possible by omitting NAs on an analysis by analysis base i.e., pairwise.
In this case, the resulting percent-agreement would be 66.67%. There is no agreement on the first case, but perfect agreement on cases 2 and 3, if we ignore the NAs. For Holsti's coefficient, agreement for each pair is calculated based on the cases both raters coded:
- raters 1 and 2 have two cases they both coded. They agree in one of them, so the resulting agreement is .5
- raters 1 and 3 have only 1 case in common, but achieve perfect agreement, i.e. 1
- raters 2 and 3 share two cases and agree in 1. Thus, they also achieve an agreement of .5

Holsti's coefficient can then be calculated as (.5+1+.5)/3 = 2/3 = .667

#### Additional information

Users can display the number of raters and cases on demand. The values represent the data after omission of missing values. In the example above, listwise omission would result in 1 case, which would then be displayed.



## Krippendorff's Alpha
Krippendorff's Alpha (here implemented via the [krippendorffsalpha package for R by John Hughes](https://cran.r-project.org/web/packages/krippendorffsalpha/index.html) accounts for chance agreement between raters. In content analysis, it is considered best-practice to use a reliability coefficient from this class. It handles missing values automatically, thus requiring no further action by the user. The possibility to bootstrap confidence intervals is currently not implemented, but may be added in a later version.

### Variable Level
Krippendorff's Alpha uses weights to quantify observed disagreement between raters. These differ depending on the variable level. Users can choose between nominal, ordinal, interval, or ratio scaled data. The option is applied to all supplpied variables. Thus, if users want to calculate Krippendorff's Alpha for 2 differently scaled variables, the calculations should be done separately. 
