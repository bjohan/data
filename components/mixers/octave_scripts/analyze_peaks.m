function [peaks_if, peaks_lo, peaks_rf] = analyze_peaks(dat, lo_axis, if_axis, rf_axis, noiseLevel)
  %Order of dat is lo, if, rf
  peaks_if=[];
  peaks_lo=[];
  peaks_rf=[];
  
	for lo = 1:length(lo_axis)
		rfSweep=squeeze(dat(lo,:,:))';
		[lprf, lpif] = peak_analysis(rfSweep, rf_axis, if_axis, noiseLevel);
    np=length(lprf);
    peaks_rf=[peaks_rf lprf];
    peaks_if=[peaks_if lpif];
    peaks_lo=[peaks_lo, lo*ones(1,np)];
    
	endfor
endfunction
