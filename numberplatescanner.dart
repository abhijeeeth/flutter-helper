import 'dart:developer';

import 'package:elephant_safari/ui/parking/addvehiclepage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';

class NumberPlateScannerPage extends StatefulWidget {
  const NumberPlateScannerPage({super.key});

  @override
  _NumberPlateScannerPageState createState() => _NumberPlateScannerPageState();
}

class _NumberPlateScannerPageState extends State<NumberPlateScannerPage>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  TextRecognizer? _textRecognizer;
  String _scannedText = '';
  bool _isProcessing = false;
  bool _isTorchOn = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
    _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _disposeCamera();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _disposeCamera() async {
    if (_cameraController != null) {
      await _cameraController!.stopImageStream();
      await _cameraController!.dispose();
      _cameraController = null;
    }
  }

  Future<void> _initializeCamera() async {
    if (_cameraController != null) {
      await _disposeCamera();
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final status = await Permission.camera.request();
      if (status.isGranted) {
        _cameraController = CameraController(
          cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.back,
            orElse: () => cameras.first,
          ),
          ResolutionPreset.veryHigh,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.bgra8888,
        );

        await _cameraController?.initialize();
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          // Start capturing frames after a brief delay
          await Future.delayed(const Duration(milliseconds: 500));
          await _startImageStream();
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _startImageStream() async {
    if (_cameraController == null || !mounted) return;

    try {
      await _cameraController?.startImageStream((CameraImage image) {
        if (!_isProcessing && mounted) {
          _processImage(image);
        }
      });
    } catch (e) {
      debugPrint('Error starting image stream: $e');
    }
  }

  Future<void> _processImage(CameraImage image) async {
    _isProcessing = true;

    try {
      final WriteBuffer allBytes = WriteBuffer();
      for (Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final imageMetadata = InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format: InputImageFormat.bgra8888,
        bytesPerRow: image.planes[0].bytesPerRow,
      );

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: imageMetadata,
      );

      final recognizedText = await _textRecognizer?.processImage(inputImage);

      if (recognizedText != null && mounted) {
        for (TextBlock block in recognizedText.blocks) {
          for (TextLine line in block.lines) {
            final text =
                line.text.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
            if (_isValidNumberPlate(text)) {
              await _disposeCamera(); // Stop camera before navigation
              if (mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddVehicleDetailsPage(
                      licenseNumber: text,
                    ),
                  ),
                );
                log('Detected Number Plate: $text');
                setState(() {
                  _scannedText = text;
                });
              }
              break;
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error processing image: $e');
    } finally {
      _isProcessing = false;
    }
  }

  bool _isValidNumberPlate(String text) {
    final List<RegExp> plateFormats = [
      RegExp(r'^[A-Z]{2}\d{2}[A-Z]{2}\d{4}$'),
      RegExp(r'^[A-Z]{2}\d{2}[A-Z]\d{4}$'),
      RegExp(r'^[A-Z]{2}\d{2}[A-Z]{4}\d{4}$'),
      RegExp(r'^[A-Z]{3}\d{4}$'),
      RegExp(r'^[A-Z]{2}\d{2}$'),
      RegExp(r'^[A-Z]{2}\d{4}$'),
      RegExp(r'^[A-Z]{2}\d{4}$'),
      RegExp(r'^[A-Z]{3}\s\d{4}$'),
      RegExp(r'^[A-Z]{2}\s\d{2}\s[A-Z]{2}\s\d{4}$'),
      RegExp(r'^[A-Z]{2}\s\d{2}\s[A-Z]\s\d{4}$'),
      RegExp(r'^[A-Z]{3}\d{1,4}$'),
      RegExp(r'^[A-Z]{2}\s\d{2}\s[A-Z]{4}\s\d{4}$'),
      RegExp(r'^[A-Z]{2}\d{2}\s[A-Z]{2}\s\d{4}$'),
    ];

    return plateFormats.any((format) => format.hasMatch(text));
  }

  Future<void> _toggleTorch() async {
    try {
      if (_cameraController != null) {
        if (_isTorchOn) {
          await _cameraController!.setFlashMode(FlashMode.off);
        } else {
          await _cameraController!.setFlashMode(FlashMode.torch);
        }
        setState(() {
          _isTorchOn = !_isTorchOn;
        });
      }
    } catch (e) {
      debugPrint('Error toggling torch: $e');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disposeCamera();
    _textRecognizer?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _disposeCamera();
        return true;
      },
      child: Scaffold(
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  if (_cameraController?.value.isInitialized ?? false)
                    SizedBox.expand(
                      child: CameraPreview(_cameraController!),
                    ),
                  Positioned.fill(
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.green.withOpacity(0.5),
                        ),
                        Center(
                          child: Container(
                            height: 120,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Text(
                                    'ABC12X',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  'Scan Vehicle Number Plate',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Capture the vehicle details by scanning\nthe license plate',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 120,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.yellow.withOpacity(0.8),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Container(
                                height: 120,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                ),
                                child: ClipPath(
                                  clipper: InvertedClipper(),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          IconButton(
                            icon: Icon(
                              _isTorchOn ? Icons.flash_on : Icons.flash_off,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: _toggleTorch,
                          ),
                          if (_scannedText.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.all(20),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _scannedText,
                                style: const TextStyle(
                                  color: Color(0xFF2E7D32),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  'You can also enter the number manually\nif needed',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () async {
                                    await _disposeCamera();
                                    if (mounted) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AddVehicleDetailsPage(),
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF2E7D32),
                                    minimumSize: const Size(200, 45),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Enter Manually',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class InvertedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
