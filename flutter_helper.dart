

F u have issue in loading image after taking: On ios use this
##############################################################
  Future<void> _openCamera() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;
    var result;

    // Navigate to the camera screen and get the result (file path or PlatformFile).
    result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePictureScreen(
                  camera: firstCamera,
                  displayGallery: true,
                )));

    // If result is not null, proceed with updating the image list.
    if (result != null) {
      setState(() {
        var imageLen = imageFiles.length;
        if (imageLen < 2) {
          // Check if the result is a String (file path), and create a PlatformFile or File.
          if (result is String) {
            // If result is a String (path), convert it to a File.
            File imageFile = File(result);
            // Add it to the list if you're using File type, or wrap it in PlatformFile.
            imageFiles.add(PlatformFile(
                name: imageFile.path.split('/').last, path: result, size: 0));
          } else if (result is PlatformFile) {
            // If result is already a PlatformFile, directly add it.
            imageFiles.add(result);
          }

          if (_selectedSituation != null) {
            submitVal = true;
          }
        } else {
          Fluttertoast.showToast(
              msg: "You can only select a maximum of 2 images",
              backgroundColor: Colors.black);
        }
      });
    }
  }

>>>>>>>>>>>>>>>>>>> Show Image <<<<<<<<<<<<<<<<<<<<<<<<<<<
  Widget imageView() {
    return imageFiles.isNotEmpty
        ? Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(imageFiles[imageIndex]
                          .path!), // Convert PlatformFile to File
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: imageFiles.length < 2
                    ? imageFiles.length + 1
                    : imageFiles.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0.8,
                    mainAxisSpacing: 0.8,
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  if (imageFiles.length < 2) if (index == imageFiles.length) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffC90503)),
                      ),
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.white),
                              textStyle: WidgetStateProperty.all(
                                  TextStyle(color: Colors.black))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.add),
                            ],
                          ),
                          onPressed: () {
                            _openCamera();
                          },
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: imageIndex == index
                          ? BoxDecoration(
                              border: Border.all(color: Color(0xffC90503)),
                            )
                          : null,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            imageIndex = index;
                          });
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Image.file(
                                File(imageFiles[index]
                                    .path!), // Convert PlatformFile to File
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                right: 5,
                                top: 5,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 13,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 12,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          imageFiles.removeAt(index);
                                          imageIndex = 0;
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      )),
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        : Container();
  }

=======================================================================>......>>>>>>>>>>>>>>>>>>>>>>



Flutter Tips & Tricks
==================
1. Hot Reload (r): Quickly see changes without restarting app
2. Hot Restart (R): Full restart when state changes needed
3. Use const constructors when possible for better performance
4. Enable null safety for safer code
5. Use flutter_lints for better code quality
6. Implement responsive design using LayoutBuilder
7. Use DevTools for debugging and profiling
8. Keep widgets small and focused
9. Cache network images for better performance
10. Use async/await for cleaner asynchronous code

Creating Simple Widgets
==================
1. Stateless Widget:
   ```dart
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

3. Reusable Widget:
   ```dart
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

   // Usage example:
   CustomButton(
     text: 'Click Me',
     onPressed: () {},
     backgroundColor: Colors.blue,
     textColor: Colors.white,
   )

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

4. Basic Layout Widgets:
   ```dart
   // Column
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

Tips:
- Always use const constructors when widget properties are final
- Keep widget methods small and focused
- Use meaningful names for widget classes
- Consider extracting reusable widgets
- Remember to handle null safety
- Make widgets reusable by accepting parameters
- Document your reusable widgets for team usage



JKS File Generator
==================
keytool -genkey -v -keystore C:/Users/chaya/Desktop/myjesusapp.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key

Flutter Best Practices & Guidelines
==================
Do's:
1. Use meaningful widget and variable names
2. Break large widgets into smaller, reusable components
3. Follow proper state management patterns (Provider, Bloc, Riverpod etc.)
4. Handle errors and edge cases gracefully
5. Add comments for complex logic
6. Use const constructors whenever possible
7. Implement proper error boundaries
8. Follow platform-specific design guidelines
9. Write unit and widget tests
10. Use proper code formatting and linting

Don'ts:
1. Don't use setState() for complex state management
2. Avoid deeply nested widgets
3. Don't ignore lifecycle methods
4. Avoid heavy computations in build method
5. Don't use hard-coded values for dimensions/colors
6. Avoid unnecessary widget rebuilds
7. Don't ignore memory leaks in StreamControllers/animations
8. Avoid mixing business logic with UI code
9. Don't skip error handling
10. Avoid unnecessary widget state

Performance Tips:
1. Use const widgets when possible
2. Implement pagination for large lists
3. Cache network resources
4. Use lazy loading for heavy widgets
5. Minimize rebuild scope using selective setState()
6. Use RepaintBoundary wisely
7. Optimize images and assets
8. Use proper keys for dynamic lists
9. Profile app performance regularly
10. Remove debug prints in release mode


Flutter CLI Commands
==================
flutter create my_app
flutter run
flutter build apk
flutter build ios
flutter clean
flutter pub get
flutter pub upgrade
flutter doctor
flutter analyze
flutter test

LAUNCHER ICON

flutter_launcher_icons:
  android: "launcher_icon"
  ios: true
  remove_alpha_ios: true
  image_path: "lib/assets/icons/gropu1icon.png"
  adaptive_icon_foreground: "lib/assets/icons/gropu1icon.png"
  adaptive_icon_background: "#FFFFF"
  min_sdk_android: 21


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