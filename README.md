Coursera Getting Data Course - Final Assignment

Stephane Major
May 14th, 2016

Acknowledgement:
================

The data for this assignment is from the work referenced in the following paper:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on  Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient  Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Description of the Datasents (from original author):
====================================================

The experiments have been carried out with a group of 30 volunteers (only 9 of which are represented in the assignment data) within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

The assignment contains the following files:
============================================

- <b>README.md</b> (this file)

- <b>run_analysis.R</b>

    Script file containing series of command to produce the 2 required datasets. To prepare the tidy datasets,execute the command source("run_analysis.R") from a folder that contains the unzipped assignment data (folder named "UCI HAR Datset"). More details about how the script is structured is contained as comments within the script itself. Note that several intermediate variables are left in the environment once the script completes for further inspection of intermediate data if necessary.

- <b>features_info.txt</b>

    The detailed code book for all variables contained in the main analysis dataset (<b>analysis_data</b> produced by the script)

- <b>averaged_info.txt</b>

    The detailed code book for all variables contained in the summary dataset (<b>averaged_data</b> produced by the script)
    