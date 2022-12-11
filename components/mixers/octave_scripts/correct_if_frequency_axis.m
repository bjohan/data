function [corrected_if] = correct_if_frequency_axis(peak_if, peak_lo, peak_rf, peak_ampt, axis_if, tolerance)
  max_rf_l=peak_rf==max(peak_rf);
  clean_if_peaks=peak_if(max_rf_l);
  clean_lo_peaks=peak_lo(max_rf_l);
  clean_tol=tolerance(max_rf_l);
  in_if_band_l=clean_lo_peaks<max(axis_if);
  valid_if_peaks=clean_if_peaks(in_if_band_l);
  valid_lo_peaks=clean_lo_peaks(in_if_band_l);
  valid_tol=clean_tol(in_if_band_l);
  fundamental_lo_l=abs(valid_if_peaks-valid_lo_peaks)<valid_tol;
  meas=valid_if_peaks(fundamental_lo_l);
  corr=valid_lo_peaks(fundamental_lo_l);
  %npk=length(peak_rf);
  %idx_range=1:npk;
  %max_peak=max(peak_ampt);
  %meas=[];
  %corr=[];
  %for i=idx_range
  %  delta= abs(peak_if(i) - peak_lo(i));
  %  dBMax=peak_ampt(i)-max_peak;
  %  if  (delta< 20e6) 
  %    [dBMax, delta/1e6, peak_if/1e6, peak_lo/1e6]
  %    if (dBMax>thr)
  %      meas=[meas peak_if(i)];
  %      corr=[corr peak_lo(i)];
  %    endif
  %  endif
  %endfor
  meas;
  corr;
  ferror=meas-corr;
  %plot(meas, ferror);
  p=polyfit(meas, ferror, 1);
  correction=-polyval(p, meas);
  hold on;
  %plot(meas, ferror+correction);
  %legend({'error', 'corrected'});
  corrected_if=axis_if-polyval(p, axis_if);
  %peak_if
  %size(in_range)
  %sum(in_range)
  %idx_range(in_range);
  #for i = 1:npk
  #  if peak_if(i) < 
  #endfor
	
endfunction
