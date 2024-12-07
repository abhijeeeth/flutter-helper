
//Creating Simple Widgets
// ==================
// 1. Stateless Widget:
//    ```dart
   class MyWidget extends StatelessWidget {
     const MyWidget({Key? key}) : super(key: key);

     @override
     Widget build(BuildContext context) {
       return Container(
         child: Text('Hello World'),
       );
     }
   }
   ```

2. Stateful Widget:
   ```dart
   class MyStatefulWidget extends StatefulWidget {
     const MyStatefulWidget({Key? key}) : super(key: key);

     @override
     _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
   }

   class _MyStatefulWidgetState extends State<MyStatefulWidget> {
     @override
     Widget build(BuildContext context) {
       return Container(
         child: Text('Hello World'),
       );
     }
   }
   ```




   // A reusable card widget
   class CustomCard extends StatelessWidget {
     final String title;
     final String subtitle;
     final Widget? leading;
     final VoidCallback? onTap;

     const CustomCard({
       Key? key,
       required this.title,
       required this.subtitle,
       this.leading,
       this.onTap,
     }) : super(key: key);

     @override
     Widget build(BuildContext context) {
       return Card(
         child: ListTile(
           leading: leading,
           title: Text(title),
           subtitle: Text(subtitle),
           onTap: onTap,
         ),
       );
     }
   }
   ```

// 4. Basic Layout Widgets:
//    ```dart
//    // Column
   Column(
     children: [
       Text('Item 1'),
       Text('Item 2'),
     ],
   )

   // Row
   Row(
     children: [
       Text('Left'),
       Text('Right'),
     ],
   )

   // Container
   Container(
     padding: EdgeInsets.all(8.0),
     margin: EdgeInsets.symmetric(vertical: 10.0),
     decoration: BoxDecoration(
       color: Colors.blue,
       borderRadius: BorderRadius.circular(8.0),
     ),
     child: Text('Styled Container'),
   )
   ```

5. Common Widgets:
   ```dart
   // Button
   ElevatedButton(
     onPressed: () {},
     child: Text('Click Me'),
   )

   // Text Field
   TextField(
     decoration: InputDecoration(
       labelText: 'Enter text',
       border: OutlineInputBorder(),
     ),
   )

   // Image
   Image.network('https://example.com/image.jpg')

   // Icon
   Icon(Icons.star)
   ```

Account Delete Popup
==================
Future<void> _showDeleteAccountDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
        ),
        title: Stack(
          children: [
            const Center(
              child: Icon(
                Icons.delete,
                color: Colors.red,
                size: 50,
              ),
            ),
            Positioned(
              right: 0,
              top: -15,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Are you sure you want to delete your account?',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'This action cannot be undone.',
                style: TextStyle(
                  color: Color.fromARGB(255, 131, 131, 131),
                  fontSize: 14
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // User cancels delete
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Helper.pushReplacement(
                    context,
                    const LanguageView(),
                    'FacilitationCard'
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}


Widget Builder
==================
Widget _loginButton() {
  return BlocConsumer<EmergencyblocBloc, EmergencyblocState>(
    builder: (context, state) {
      if (state is UpdateVictimLoading) {
        return const SizedBox(
          height: 18.0,
          width: 18.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 255, 255, 255)
            ),
            strokeWidth: 2,
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "SUBMIT".tr(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        );
      }
    },
    listener: (context, state) {},
  );
}
