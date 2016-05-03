function [kp_optimal_thresh] = kp_train(sig,kp_thresh,fs,kp_expert_score,figure_set)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
  %kcomplex detection
   m=1;
for kk=kp_thresh
    for i=1:length(sig)
        [nbr_kc(i),pos_kc] = kc_detection(sig{i},kk,fs);
    end
       [kp_Sen(m),kp_FDR(m)] = performances_measure(kp_expert_score,nbr_kc);% the user can use his own function to compute sensitivity and FDR
        m=m+1;
end
[kp_optimal_thresh]=ROC_curve(kp_FDR,kp_Sen,kp_thresh,figure_set);

end

