
function retval = extract_and_plot_peak_harmonics (search_spectrum, target_signal, harmonics,legend, color, style, type, tol)
  global peaks_if_f;
  global peaks_lo_f;
  global peaks_rf_f;
  global amps_norm;
  global peaks_amptd;
  global legends;
  matching_harmonics_idx=[];
  for harmonic = harmonics
    current_matching_harmonic_idx=extract_peaks(search_spectrum, target_signal*harmonic, tol);
    matching_harmonics_idx = [matching_harmonics_idx current_matching_harmonic_idx]; 
  endfor
  scatter3(peaks_if_f(matching_harmonics_idx), peaks_lo_f(matching_harmonics_idx), peaks_rf_f(matching_harmonics_idx),(100*amps_norm(matching_harmonics_idx)+1+0*20)*4, color, style, type, 'linewidth',3);
  delete_idx(matching_harmonics_idx)
  legends{end+1}=[legend ' n=' num2str(length(matching_harmonics_idx))];
endfunction
