

class UtilHelper {
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
  static double screenHeightPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }

  // Padding Helpers
  static EdgeInsets allPadding(double value) => EdgeInsets.all(value);
  static EdgeInsets symmetricPadding({double vertical = 0, double horizontal = 0}) =>
      EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal);
  static EdgeInsets onlyPadding({double top = 0, double bottom = 0, double left = 0, double right = 0}) =>
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
  static Widget reusableText(String text, {Color color = Colors.black, double fontSize = 16.0, FontWeight fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
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
        padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
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
