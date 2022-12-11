function lo_idx = extract_peaks(peak_if, target_f,tol)
  range=1:length(peak_if);
  lo_idx=range(abs(peak_if - target_f) < tol); 
endfunction
