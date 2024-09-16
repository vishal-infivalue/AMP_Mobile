import 'package:fluttertoast/fluttertoast.dart';

import 'app_colors.dart';

commonToast(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.meruBlack,
      textColor: AppColors.meruWhite,
      fontSize: 16.0
  );
}