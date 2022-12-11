%clear worskspace, load libraries
clear all
close all
pkg load signal
colormap(colorcube)
graphics_toolkit qt

%load data
%load zem_4300_low_band_linear_3.mat
%load zem_4300_high_band_linear_3.mat
%load ML7510_high_band_30dB.mat
%load ML7510_low_band_40dB_full_freq.mat
%load m80lca_high_band_30dB.mat

%low_band_file='m80lca_low_band_30dB.mat'; high_band_file='m80lca_high_band_30dB.mat';
%low_band_file='m80lca_low_band_40dB.mat'; high_band_file='m80lca_high_band_40dB.mat';
%low_band_file='zem_4300_low_band_linear_3.mat'; high_band_file='zem_4300_high_band_linear_3.mat';
%low_band_file='zem_4300_low_band_linear_2.mat'; high_band_file='zem_4300_high_band_linear_2.mat';
%low_band_file='zem_4300_low_band_linear.mat'; high_band_file='zem_4300_high_band_linear.mat';
%low_band_file='ML7510_low_band_40dB_full_freq.mat'; high_band_file='ML7510_high_band_40dB_full_freq.mat';
%low_band_file='ML7510_low_band_30dB_full_freq.mat'; high_band_file='ML7510_high_band_30dB_full_freq.mat';
low_band_file='MZ9310C_low_band_30dB.mat'; high_band_file='MZ9310C_high_band_30dB.mat';
low_band_file='MZ9310C_reversed_low_band_30dB.mat'; high_band_file='MZ9310C_reversed_high_band_30dB.mat';
low_band_file='XMM302_low_band_30dB.mat'; high_band_file='XMM302_high_band_30dB.mat';
low_band_file='AT020_low_band_30dB_full_freq.mat'; high_band_file='AT020_high_band_30dB_full_freq.mat';
low_band_file='73129_low_band_30dB.mat'; high_band_file='73129865_high_band_30dB.mat';
low_band_file='hp10514A_low_band_30dB.mat'; high_band_file='hp10514A_high_band_30dB.mat';
global peaks_if_f;
global peaks_lo_f;
global peaks_rf_f;
global peaks_amptd;
global amps_norm;
global tolerance;
global legends={};
[peaks_if_f_1, peaks_lo_f_1, peaks_rf_f_1, peaks_amptd_1, amps_norm_1, tolerance_1] = load_data_and_extract_peaks(low_band_file);
[peaks_if_f_2, peaks_lo_f_2, peaks_rf_f_2, peaks_amptd_2, amps_norm_2, tolerance_2] = load_data_and_extract_peaks(high_band_file);
%peaks_if_f_1=[]; 
%peaks_lo_f_1=[]; 
%peaks_rf_f_1 =[];
%peaks_amptd_1=[];
%amps_norm_1 =[];
%tolerance_1=[];
peaks_if_f=[peaks_if_f_1 peaks_if_f_2];
peaks_lo_f=[peaks_lo_f_1 peaks_lo_f_2];
peaks_rf_f=[peaks_rf_f_1 peaks_rf_f_2];
peaks_amptd=[peaks_amptd_1 peaks_amptd_2];
amps_norm=[amps_norm_1 amps_norm_2];
tolerance=[tolerance_1 tolerance_2];


%if max(if_axis) < 10e9
%  a=load('zem_4300_low_band_linear.mat');
%  if_axis=a.if_axis;
%endif
%tol=30e6;
%if max(if_axis) > 3e9
%  tol=200e6;
%endif


%dat=dat(:,10:end,:);
%if_axis=if_axis(10:end);


%%Approximate noise level and calculate peak indices
%approxNoiseLevel=min(min(dat, [], 3));
%[peaks_if, peaks_lo, peaks_rf] = analyze_peaks(dat, lo_axis, if_axis, rf_axis, approxNoiseLevel);


%%get actual peak data
%global peaks_if_f=if_axis(peaks_if);
%global peaks_lo_f=lo_axis(peaks_lo);
%global peaks_rf_f= rf_axis(peaks_rf);

%%for some reason octave crashes when indexing dat with peaks_lo, _if and _rf directly so iterate through
%numpeaks=length(peaks_if);
%global peaks_amptd=[];

%global tolerance=[];
%for i=1:numpeaks
%  peaks_amptd=[peaks_amptd dat(peaks_lo(i), peaks_if(i), peaks_rf(i));];
%  tolerance=[tolerance tol];
%endfor

%%return

%%correct frequency axis
%if_axis=corrected_if_axis=correct_if_frequency_axis(peaks_if_f, peaks_lo_f, peaks_rf_f, peaks_amptd, if_axis, tolerance);
%figure;


%peaks_if_f=if_axis(peaks_if);


%%corrected_if_axis=correct_if_frequency_axis(peaks_if_f, peaks_lo_f, peaks_rf_f, peaks_amptd, if_axis, tol);
%%figure;

%amps1=peaks_amptd-min(peaks_amptd);
%global amps_norm=amps1./max(amps1);
%%c=[amps_norm ; zeros(1,numpeaks) ; amps_norm]'; 


%global legends={};

extract_and_plot_peak_harmonics (peaks_if_f, peaks_lo_f, [1], 'LO', 0, '', 'o', tolerance)
hold on;
extract_and_plot_peak_harmonics (peaks_if_f, peaks_lo_f, 2:100,"N*LO", 10, '', '0', tolerance);



%Extract rf peaks
extract_and_plot_peak_harmonics (peaks_if_f, peaks_rf_f, [1], 'RF', 20, '', 'o', tolerance)
extract_and_plot_peak_harmonics (peaks_if_f, peaks_rf_f, 2:100, 'N*RF', 30, '', 'o', tolerance)

extract_and_plot_peak_harmonics (peaks_if_f, peaks_rf_f-peaks_lo_f, [1], 'USB', 40, 'filled', 'o', tolerance)
extract_and_plot_peak_harmonics (peaks_if_f, peaks_lo_f-peaks_rf_f, [1], 'LSB', 50, 'filled', 'o', tolerance)

extract_and_plot_peak_harmonics (peaks_if_f, peaks_rf_f-2*peaks_lo_f, [1], 'USB2', 60, 'filled', 's', tolerance)
extract_and_plot_peak_harmonics (peaks_if_f, peaks_lo_f*2-peaks_rf_f, [1], 'LSB2', 70, 'filled', 's', tolerance)

extract_and_plot_peak_harmonics (peaks_if_f, peaks_rf_f-3*peaks_lo_f, [1], 'USB3', 80, 'filled', 's', tolerance)
extract_and_plot_peak_harmonics (peaks_if_f, peaks_lo_f*3-peaks_rf_f, [1], 'LSB3', 90, 'filled', 's', tolerance)

extract_and_plot_peak_harmonics (peaks_if_f, peaks_rf_f-4*peaks_lo_f, [1], 'USB4', 100, 'filled', 's', tolerance)
extract_and_plot_peak_harmonics (peaks_if_f, peaks_lo_f*4-peaks_rf_f, [1], 'LSB4', 110, 'filled', 's', tolerance)

extract_and_plot_peak_harmonics (peaks_if_f, peaks_rf_f-5*peaks_lo_f, [1], 'USB5', 120, 'filled', 's', tolerance)
extract_and_plot_peak_harmonics (peaks_if_f, peaks_lo_f*5-peaks_rf_f, [1], 'LSB5', 130, 'filled', 's', tolerance)

extract_and_plot_peak_harmonics (peaks_if_f, peaks_rf_f-6*peaks_lo_f, [1], 'USB6', 140, 'filled', 's', tolerance)
extract_and_plot_peak_harmonics (peaks_if_f, peaks_lo_f*6-peaks_rf_f, [1], 'LSB6', 150, 'filled', 's', tolerance)

extract_and_plot_peak_harmonics (peaks_if_f, peaks_rf_f-7*peaks_lo_f, [1], 'USB7', 150, 'filled', 's', tolerance)
extract_and_plot_peak_harmonics (peaks_if_f, peaks_lo_f*7-peaks_rf_f, [1], 'LSB7', 160, 'filled', 's', tolerance)

scatter3(peaks_if_f, peaks_lo_f, (100*amps_norm+1+0*20)*4, 250, 'filled', 'o');
legends{end+1}=["x n=" num2str(length(peaks_if_f))];


legend(legends, "location", "eastoutside");
grid on;
xlabel('if');
ylabel('lo');
zlabel('rf');
