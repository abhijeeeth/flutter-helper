// Reusable Widget:

   // A reusable custom button widget
   class CustomButton extends StatelessWidget {
     final String text;
     final VoidCallback onPressed;
     final Color? backgroundColor;
     final Color? textColor;

     const CustomButton({
       Key? key,
       required this.text,
       required this.onPressed,
       this.backgroundColor,
       this.textColor,
     }) : super(key: key);

     @override
     Widget build(BuildContext context) {
       return ElevatedButton(
         onPressed: onPressed,
         style: ElevatedButton.styleFrom(
           backgroundColor: backgroundColor,
           foregroundColor: textColor,
         ),
         child: Text(text),
       );
     }
   }


   //use case
      // Usage example:
   CustomButton(
     text: 'Click Me',
     onPressed: () {},
     backgroundColor: Colors.blue,
     textColor: Colors.white,
   )