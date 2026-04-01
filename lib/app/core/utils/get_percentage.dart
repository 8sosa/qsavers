double calculatePercentage(double firstValue, double secondValue) {
  // Calculate the percentage difference between the two values
  double difference = firstValue - secondValue;
  double percentage = (difference / firstValue) * 100;
  return percentage;
}