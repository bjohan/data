
function [peaks_if_f, peaks_lo_f, peaks_rf_f, peaks_amptd, amps_norm, tolerance] = load_data_and_extract_peaks (filename)

  d=load(filename);
  
  
  lo_axis=d.lo_axis;
  if_axis=d.if_axis;
  rf_axis=d.rf_axis;


  if max(d.if_axis) < 10e9
    a=load('zem_4300_low_band_linear.mat');
    d.if_axis=a.if_axis;
  endif
  
  tol=30e6;
  if max(d.if_axis) > 3e9
    tol=200e6;
    dat=d.dat(:,4:end,:);
    if_axis=d.if_axis(4:end);
  else
    dat=d.dat(:,12:end,:);
    if_axis=d.if_axis(12:end);
  endif
  
  
  %Approximate noise level and calculate peak indices
  approxNoiseLevel=min(min(dat, [], 3));
  [peaks_if, peaks_lo, peaks_rf] = analyze_peaks(dat, lo_axis, if_axis, rf_axis, approxNoiseLevel);
  size(peaks_if);
  

  %get actual peak data
  peaks_if_f=if_axis(peaks_if);
  peaks_lo_f=lo_axis(peaks_lo);
  peaks_rf_f= rf_axis(peaks_rf);

  %for some reason octave crashes when indexing dat with peaks_lo, _if and _rf directly so iterate through
  numpeaks=length(peaks_if);
  peaks_amptd=[];

  tolerance=[];
  for i=1:numpeaks
    peaks_amptd=[peaks_amptd dat(peaks_lo(i), peaks_if(i), peaks_rf(i));];
    tolerance=[tolerance tol];
  endfor
  peaks_amptd;
  %figure;
  %plot(peaks_if_f);
  %return

  %correct frequency axis
  %figure;
  if_axis=corrected_if_axis=correct_if_frequency_axis(peaks_if_f, peaks_lo_f, peaks_rf_f, peaks_amptd, if_axis, tolerance);


  peaks_if_f=if_axis(peaks_if);

  amps1=peaks_amptd-min(peaks_amptd);
  amps_norm=amps1./max(amps1);



endfunction
