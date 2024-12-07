

//IF u have issue in loading image after taking: On ios use this
//##############################################################
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