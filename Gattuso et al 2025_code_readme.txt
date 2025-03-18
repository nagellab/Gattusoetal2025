Gattuso et al 2025_code_readme
Author: Hannah Gattuso
Codes written by Hannah Gattuso(*), Karin Van Hassel(+), and Jonathan Victor(=)


MODEL CODE:
gattuso_locomotion_model.mat (*)- generates fictive walking trajectories of olfactory navigation and plots trajectories and associated angular velocity and ground speed. (Fig 3D,H, Fig S2E, Fig S3B,E)



ANALYSIS CODE:
hists_by_fly.m (*): calculates the mean distributions of angular velocity and ground speed across flies. (Fig 1D-E, Fig 4C, Fig 5B-C, Fig S2A, Fig S6B, Fig S7A

avel_nofilt.m (*): obtains unfiltered angular velocity traces and removes trials where the fly did not move. This data is then fed into automobile_errorbars.m to create autocorrelograms.

automobile_errorbars.m (*): calculates and plots mean autocorrelation and SE across flies. (Fig 1F, Fig 4C)

plotSingleTrajectory.m (*): plots trajectory of fly for a single trial, color coded for both stimulus and ground speed. also plots corresponding ground speed and angular velocity (Fig 1B-C, Fig 2A,F, Fig 5D)

RNNassess.m (*): calculates angular velocity distribution, ground speed distribution, and autocorrelation for model generated data. (Fig 3E,G, Fig S2A, FigS3C,F)

turn_gs_relation_allflies.m (*): extracts all turns. calculates the mean ground speed prior to a turn. plots angular velocity and ground speed traces of each turn, binned by mean ground speed prior to turning. (Fig 2E, Fig S1E)

change_point.m (*): runs change point detection algorithm on ground speed. plots sample ground speed and angular velocity traces, with epochs denoted by vertical cyan lines and mean ground speed denoted by horizontal red line. also plots a histogram of mean ground speeds from each epoch and a 2-dimensional histogram of mean ground speed and mean of the absolute value of angular velocity. (Fig 2B-D, Fig S1 D)

split_change_point_byfly.m (*): uses change point detection to categorize trials based off of whether or not a fly was moving before odor detection. Then plots mean ground speed and angular velocity across flies for both moving and non moving (gs<1mm/s) flies. (Fig 2G-H)

twodhist_maker.m (*): plots a 2-dimensional histogram of mean angular velocity and ground speed. (Fig S1A)

angulardispersion_final.m (*): calculates and plots how far flies turn (in degrees) over different epochs of a trial. (Fig S1B)

frequency_calc_commented.m (*): calculates inter turn intervals for walking trajectories and plots the mean distribution and standard error. (Fig S1C)

icontraimpact_compareunits.m (*): calculates and plots the crosscorrelation of unit activity from the model. (Fig S2D, Fig S3G-H)


GattusoFigure4Chrimson.m (+): Conducts paired t-tests comparing the ground speed, angular velocity, curvature during a 10 second light pulse to the 10s directly preceding the light. Plots the distribution of ground speed and angular velocity before and during the light pulse. Conducts paired t-tests comparing the angular velocity and curvature 5 seconds following an odor pulse during light and without light. Used to generate fig 4C, 4E, 4F and fig S5C.

GattusoFigure4GtACR.m (+): Conducts paired t-tests comparing the ground speed, angular velocity, curvature during a 10 second light pulse to the 10s directly preceding the light. Plots the distribution of ground speed and angular velocity before and during the light pulse. Conducts paired t-tests comparing the angular velocity and curvature 5 seconds following an odor pulse during light and without light. Used to generate fig 4E, 4F and fig S5D.

~GattusoFigure4Chrimson.m and GattusoFigure4GtACR.m are similar codes. GattusoFigure4Chrimson.m was used to analyze the activation experiments and GattusoFigure4GtACR.m was used to analyze the silencing experiments. The difference between the codes is the color coding and the files they analyze.


GattusoFigure4ChrimsonRevision.m (+): Conducts unpaired t-tests comparing the change in angular velocity during the odor offset during light ON and OFF conditions.

GattusoFigure4GtACRRevision.m (+): Conducts unpaired t-tests comparing the change in angular velocity during the odor offset during light ON and OFF conditions.

~GattusoFigure4ChrimsonRevision.m and GattusoFigure4GtACRRevision.m are similar codes. GattusoFigure4ChrimsonRevision.m was used to analyze the activation experiments and GattusoFigure4GtACRRevision.m was used to analyze the silencing experiments. The difference between the codes is the files they analyze.

GattusoFigure5Chrimson.m (+): Plots and conducts paired t-tests comparing the ground speed, angular velocity and odor-evoked path during a 10 second light pulse to the 10s directly preceding the light. Plots the distribution of ground speed before and during the light pulse. Plots time course of ground speed during an odor response with and without light. Used to generate fig 5B, 5G, S6B, S6C, and S6D.

GattusoFigure5GtACR.m (+): Plots and conducts paired t-tests comparing the ground speed, angular velocity and odor-evoked path during a 10 second light pulse to the 10s directly preceding the light. Plots the distribution of ground speed before and during the light pulse. Plots time course of ground speed during an odor response with and without light. Used to generate fig 5C, 5H, S7A, S7B, and S7C.

~GattusoFigure5Chrimson.m and GattusoFigure5GtACR.m are similar codes. GattusoFigure5Chrimson.m was used to analyze the activation experiments and GattusoFigure5GtACR.m was used to analyze the silencing experiments. The difference between the codes is the color coding and the files they analyze.

GattusoFigure5PathLength.m (+): Plots the odor-evoked path length of the fly and conducts a paired t-test comparing the path length during light on and off conditions. Used to generate fig 5E.

GattusoFigureS5ChrimsonRevision.m (+): Conducts unpaired t-tests comparing the change in ground speed and angular velocity caused by activation of genetic lines to the change in ground speed and angular velocity observed during the activation of the empty split.

GattusoFigureS5GtACRRevision.m (+): Conducts unpaired t-tests comparing the change in ground speed and angular velocity caused by silencing of genetic lines to the change in ground speed and angular velocity observed during the silencing of the empty split.

GattusoFigure5GtACRRevision_ss38176.m (+): Conducts unpaired t-tests comparing the change in ground speed caused by silencing of ss38176 to the change in ground speed observed during the activation of the empty split.

~GattusoFigureS5ChrimsonRevision.m, GattusoFigureS5GtACRRevision.m, and GattusoFigure5GtACRRevision_ss38176.m are similar codes. GattusoFigureS5ChrimsonRevision.m was used to analyze the activation experiments. GattusoFigureS5GtACRRevision.m and GattusoFigure5GtACRRevision_ss38176.m were used to analyze the silencing experiments. The difference between the codes is the files they analyze.

GattusoFigureS6ChrimsonRevision.m (+): Conducts unpaired t-tests comparing the change in angular velocity caused by activation of genetic lines to the change in angular velocity observed during the activation of the empty split.

GattusoFigureS7GtACRRevision.m (+): Conducts unpaired t-tests comparing the change in angular velocity caused by silencing of genetic lines to the change in angular velocity observed during the silencing of the empty split.

GattusoFigureS7GtACRRevision_ss38176.m (+): Conducts unpaired t-tests comparing the change in angular velocity caused by silencing of ss38176 to the change in angular velocity observed during the activation of the empty split.

~GattusoFigureS6ChrimsonRevision.m, GattusoFigureS7GtACRRevision.m, and GattusoFigureS7GtACRRevision_ss38176.m are similar codes. GattusoFigureS5ChrimsonRevision.m was used to analyze the activation experiments. GattusoFigureS5GtACRRevision.m and GattusoFigure5GtACRRevision_ss38176.m were used to analyze the silencing experiments. The difference between the codes is the files they analyze.

gattuso_locomotion_model_demo (=): A demo of locomotion trajectories, making a montage with a range of param values of self-excitation and cross-inhibition. Calls gattuso_locomotion_model_JV(B,XLR,XLR2,XS,XX,sw,plotting,deltaT). Used to generate FigS4.

gattuso_locomotion_model_JV (=,*): A version of the model code that outputs additional parameters for analysis, including eigenvalues and symmetry splitting variables. Called by gattuso_locomotion_model_demo.

~Fig 4A-B,D, Fig S6C, and Fig S7C were created using code previously published with Alvarez-Salvado et al. 2018
