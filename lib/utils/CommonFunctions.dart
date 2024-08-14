class CommonFunctions {
  // Function to round a double value to the nearest integer and return as a string
  static String roundDoubleToString(double value) {
    // Round the double to the nearest integer
    int roundedValue = value.round();
    // Convert the rounded integer back to a string
    return roundedValue.toString();
  }
}
