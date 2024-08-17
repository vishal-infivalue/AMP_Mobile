class CommonFunctions {
  // Function to round a double value to the nearest integer and return as a string
  static String roundDoubleToString(double value) {
    // Round the double to the nearest integer
    int roundedValue = value.round();
    // Convert the rounded integer back to a string
    return roundedValue.toString();
  }
}

// void sendData(context) {
//
//   final logInProvider = Provider.of<APIProvider>(context);
//   print("Before creating data map");
//   Map<String, dynamic> data = {
//     "ERB_Audit_StagingDTO": [
//       {
//         "audit_id": "10000000001",
//         "totalscore": "1",
//         "header": "1",
//         "subheader": "1",
//         "additionalnotes": "0",
//         "question": "3",
//         "obtained_score": "1",
//         "remarks": "Test",
//         "comments": "",
//         "pic_submitted_filename": "",
//         "pic_submitted_filepath": ""
//       }
//     ]
//   };
//   print("After creating data map");
//
//   String jsonData = jsonEncode(data);
//   print(jsonData);
//
//   logInProvider.postAuditData(jsonData, context);
// }
