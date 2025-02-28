FutureOr<void> _downloadTicket(
    DoDownloadTicket event, Emitter<MainState> emit) async {
  emit(DownloadingTicket());
  try {
    var token = await LocalStorage.getToken();
    final Uri url = Uri.parse(
        '${ServerHelper.baseUrl}/v1/staff/vehicle/download-ticket?id=${event.ticketId}&copyType=${event.type}');
    log(url.toString());

    final response = await http.get(url,
        headers: {'access-token': token}).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      // Get the internal documents directory
      final Directory appDocDir = Platform.isAndroid
          ? Directory('/storage/emulated/0/Download')
          : await getApplicationDocumentsDirectory();
      final String filePath =
          '${appDocDir.path}/ticket_${event.ticketId}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final File file = File(filePath);

      // Save the file in internal storage
      await file.writeAsBytes(response.bodyBytes);

      // Open the file using open_filex
      final result = await OpenFilex.open(filePath);
      log("File opened with result: ${result.message}");

      // Move file to appropriate directory based on the platform
      if (Platform.isAndroid) {
        await moveFileToDownloads(filePath); // Move to Downloads for Android
      } else if (Platform.isIOS) {
        await moveFileToDocuments(filePath); // Save to Documents for iOS
      }

      emit(DownloadTicketSuccess());
    } else {
      emit(DownloadTicketFailed());
    }
  } catch (e) {
    log('Download error: $e');
    emit(DownloadTicketFailed());
  }
}

Future<void> moveFileToDownloads(String sourcePath) async {
  try {
    final File sourceFile = File(sourcePath);
    final String fileName = sourcePath.split('/').last;

    // Get the Downloads directory path
    final Directory? downloadsDir = await getExternalStorageDirectory();
    if (downloadsDir == null)
      throw Exception('Could not access Downloads directory');

    final String downloadPath = '${downloadsDir.path}/$fileName';

    // Copy the file to Downloads directory
    await sourceFile.copy(downloadPath);

    // Delete the original file from temporary storage
    await sourceFile.delete();

    log('File moved to Downloads: $downloadPath');
  } catch (e) {
    log('Error moving file to Downloads: $e');
    rethrow;
  }
}

Future<void> moveFileToDocuments(String sourcePath) async {
  try {
    final File sourceFile = File(sourcePath);
    final String fileName = sourcePath.split('/').last;

    // Get the Documents directory path
    final Directory documentsDir = await getApplicationDocumentsDirectory();
    final String documentPath = '${documentsDir.path}/$fileName';

    // Copy the file to Documents directory
    await sourceFile.copy(documentPath);

    // Delete the original file from temporary storage
    await sourceFile.delete();

    log('File moved to Documents: $documentPath');
  } catch (e) {
    log('Error moving file to Documents: $e');
    rethrow;
  }
}
