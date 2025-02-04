class UtilHelper {

  //Space remover for email login
                TextFormField(
                controller = username,
                keyboardType = TextInputType.text,
                decoration = InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    fillColor: Colors.white,
                    labelText: "Mobile Number or Email Address",
                    labelStyle: TextStyle(fontSize: 16.0),
                    filled: true),
                onChanged = (value) {
                  // Trim the value if it has trailing spaces
                  if (value.endsWith(' ')) {
                    username.text = value.trimRight();
                    // Move cursor to end after trimming
                    username.selection = TextSelection.fromPosition(
                      TextPosition(offset: username.text.length),
                    );
                  }

                  String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
                  RegExp regExp = RegExp(pattern);
                  if (regExp.hasMatch(value)) {
                    if (value.length > 10) {
                      checkStatus = true;
                      setState(() {});
                    } else {
                      checkStatus = false;
                      setState(() {});
                    }
                  } else {
                    checkStatus = true;
                    setState(() {});
                  }
                },
                validator = (value) {
                  if (value == null) return 'Cannot be empty';

                  // Trim the value for validation
                  String trimmedValue = value.trimRight();

                  // Check if original value had trailing spaces
                  if (value != trimmedValue) {
                    return 'Trailing spaces are not allowed';
                  }

                  if (value.isEmpty) {
                    return 'Cannot be empty';
                  }

                  if (value.isNotEmpty &&
                      !checkStatus &&
                      value.toUpperCase() != value) {
                    Pattern pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = RegExp(pattern as String);
                    if (!regex.hasMatch(value)) {
                      return 'Enter a valid Email or Username';
                    }
                  }

                  return null;
                },
              ),
           
   


  //Responsive Font
  double responsiveFontSize(BuildContext context, double baseFontSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double averageScreenSize = (screenWidth + screenHeight) / 2;
    return baseFontSize *
        (averageScreenSize / 600); // 600 is an arbitrary base size.
  }
//Example for responsive font size
Text(
  'Responsive Text',
  style = TextStyle(
    fontSize: UtilHelper.responsiveFontSize(context, 16), // 16 is the base font size.
  ),
),


  // Snackbar Helper
  static void showSnackBar(BuildContext context, String message,
      {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color ?? Colors.blue,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Format Date (e.g., "2024-11-20" -> "20 Nov, 2024")
  static String formatDate(DateTime date) {
    return '${date.day} ${_monthNames[date.month]} ${date.year}';
  }

  static const List<String> _monthNames = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  // Validate Email
  static bool validateEmail(String email) {
    const emailRegex = r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$';
    return RegExp(emailRegex).hasMatch(email);
  }

  // Navigate to Another Page
  static void navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Convert Hex Color to Color
  static Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse('0x$hex'));
  }

  // Calculate Screen Width Percentage
  static double screenWidthPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }

  // Calculate Screen Height Percentage
  static double screenHeightPercentage(
      BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }
}

class UIHelper {
  // Spacing (Margins and Padding)
  static const double smallPadding = 8.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 24.0;

  static const double smallMargin = 8.0;
  static const double mediumMargin = 16.0;
  static const double largeMargin = 24.0;

  // Heights and Widths
  static const double smallHeight = 8.0;
  static const double mediumHeight = 16.0;
  static const double largeHeight = 24.0;

  static const double smallWidth = 8.0;
  static const double mediumWidth = 16.0;
  static const double largeWidth = 24.0;

  // Reusable SizedBox for vertical spacing
  static Widget verticalSpace(double height) => SizedBox(height: height);

  // Reusable SizedBox for horizontal spacing
  static Widget horizontalSpace(double width) => SizedBox(width: width);

  // Screen Width Percentage
  static double screenWidthPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }

  // Screen Height Percentage
  static double screenHeightPercentage(
      BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }

  // Padding Helpers
  static EdgeInsets allPadding(double value) => EdgeInsets.all(value);
  static EdgeInsets symmetricPadding(
          {double vertical = 0, double horizontal = 0}) =>
      EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal);
  static EdgeInsets onlyPadding(
          {double top = 0,
          double bottom = 0,
          double left = 0,
          double right = 0}) =>
      EdgeInsets.only(top: top, bottom: bottom, left: left, right: right);

  // Box Decoration
  static BoxDecoration boxDecoration({
    Color color = Colors.white,
    double borderRadius = 8.0,
    Color borderColor = Colors.transparent,
    double borderWidth = 1.0,
    BoxShadow? boxShadow,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: borderColor, width: borderWidth),
      boxShadow: boxShadow != null ? [boxShadow] : [],
    );
  }

  // Reusable Text Widget
  static Widget reusableText(String text,
      {Color color = Colors.black,
      double fontSize = 16.0,
      FontWeight fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }

  // Custom Button
  static Widget customButton({
    required String text,
    required VoidCallback onPressed,
    double fontSize = 16.0,
    double borderRadius = 8.0,
    Color color = Colors.blue,
    Color textColor = Colors.white,
    double paddingVertical = 12.0,
    double paddingHorizontal = 16.0,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.symmetric(
            vertical: paddingVertical, horizontal: paddingHorizontal),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: textColor),
      ),
    );
  }

  // Reusable Card Widget
  static Widget customCard({
    required Widget child,
    double borderRadius = 8.0,
    Color color = Colors.white,
    Color borderColor = Colors.grey,
    double borderWidth = 0.5,
    EdgeInsets padding = const EdgeInsets.all(16.0),
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: child,
    );
  }
}

class UIHelper {
  // Common Text Styles
  static TextStyle headingTextStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle subheadingTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.grey[700],
  );

  static TextStyle bodyTextStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.grey[600],
  );

  // Common Icon Styles
  static Icon successIcon = Icon(
    Icons.check_circle,
    color: Colors.green,
  );

  static Icon errorIcon = Icon(
    Icons.error,
    color: Colors.red,
  );

  static Icon warningIcon = Icon(
    Icons.warning,
    color: Colors.orange,
  );
}
