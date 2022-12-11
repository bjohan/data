
function [] = delete_idx (idx)
  global peaks_if_f;
  global peaks_lo_f;
  global peaks_rf_f;
  global amps_norm;
  global peaks_amptd;
  global tolerance;
  %peaks_if_f
  peaks_if_f(idx)=[];
  peaks_lo_f(idx)=[];
  peaks_rf_f(idx)=[];
  amps_norm(idx)=[];
  peaks_amptd(idx)=[];
  tolerance(idx)=[];
endfunction
