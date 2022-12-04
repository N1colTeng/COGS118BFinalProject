The six files starting with mfeat- are the original datasets.
mfeat-info contains general description of the dataset.
The sc_xxx.m are the setup codes for different dataset.
The sc_xxx_compare_two.m are the testing codes for different dataset on two numerals.
The mvsc_compare_two.m and mvsc_compare_two_test.m are the codes for two-view
spectral clustering using same algorithm but different implementations on two features
and two numerals. 
eigsort.m is from hw3. viewcolumn.m is from hw4 with a little modification on the size of 
the picture reconstructed (from 60*60 to 15*16).

In real tests, I used the mvsc_compare_two.m.