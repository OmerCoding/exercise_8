function [bestEpsilon bestF1] = selectThreshold(yval, pval)



bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)


  anomaly_prediction = (pval < epsilon);
  true_positive = sum((anomaly_prediction == 1) & (yval == 1));
  false_positive = sum((anomaly_prediction == 1) & (yval == 0));
  false_negative = sum((anomaly_prediction == 0) & (yval == 1));
  
  precision = true_positive / (true_positive + false_positive);
  recall = true_positive / (true_positive + false_negative);
  
  F1 = (2 * precision * recall) / (precision + recall);

  if F1 > bestF1
    bestF1 = F1;
    bestEpsilon = epsilon;
  end
  
end

end
