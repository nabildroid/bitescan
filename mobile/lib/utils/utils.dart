import 'dart:math';

double smoothValue(List<double> data, double target) {
  if (data.isEmpty) return 100;
  // Step 1: Find the min and max values in the provided data
  double min =
      [...data, target].reduce((a, b) => a < b ? a : b); // Get minimum value
  double max =
      [...data, target].reduce((a, b) => a > b ? a : b); // Get maximum value

  // Step 2: Normalize the target value based on the range of the data (min, max)
  double normalizedTarget = ((target - min) / (max - min)) * 100;

  // Step 3: Apply square-root transformation to smooth the value
  double transformedTarget = sqrt(normalizedTarget);

  // Step 4: Re-normalize the transformed value back to the 0-100% range
  double smoothedTarget = (transformedTarget / sqrt(100)) * 100;

  if (smoothedTarget.isNaN) return 50;
  return smoothedTarget;
}
