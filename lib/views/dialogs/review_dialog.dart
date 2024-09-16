import 'package:flutter/material.dart';

class ReviewDialog extends StatefulWidget {
  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  final TextEditingController _reviewController = TextEditingController();
  bool _isSaveButtonEnabled = false;
  int _charCount = 0;
  final int _maxCharCount = 200;

  @override
  void initState() {
    super.initState();
    _reviewController.addListener(_onReviewChanged);
  }

  void _onReviewChanged() {
    setState(() {
      _charCount = _reviewController.text.length;
      _isSaveButtonEnabled = _charCount > 0 && _charCount <= _maxCharCount;
    });
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // Make the dialog background transparent
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white, // Inner background color
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 30,
                  child: IconButton(
                    icon: Image.asset("assets/images/menu_logo.png"),
                    iconSize: 40,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  'Write a review',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _reviewController,
              maxLines: 3,
              style: TextStyle(
                fontSize: 12.0,
              ),
              decoration: InputDecoration(
                hintText: 'Enter your review',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '$_charCount/$_maxCharCount characters',
                style: TextStyle(
                  fontSize: 12.0,
                  color: _charCount > _maxCharCount ? Colors.red : Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
                ElevatedButton(
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                  onPressed: _isSaveButtonEnabled
                      ? () {
                    String reviewText = _reviewController.text;
                    // Handle save logic here
                    print('Review saved: $reviewText');
                    Navigator.of(context).pop(); // Close the dialog
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    _isSaveButtonEnabled ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showReviewDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.white.withOpacity(0.5), // Background with transparency
    builder: (BuildContext context) {
      return ReviewDialog();
    },
  );
}


