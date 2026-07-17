import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  final VoidCallback onGallery;
  final VoidCallback onCamera;
  final VoidCallback onPdf;

  const UploadButton({
    super.key,
    required this.onGallery,
    required this.onCamera,
    required this.onPdf,
  });

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const ListTile(
                  title: Text(
                    "Upload Medical Report",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text("Choose from Gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    onGallery();
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Capture using Camera"),
                  onTap: () {
                    Navigator.pop(context);
                    onCamera();
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.picture_as_pdf),
                  title: const Text("Upload PDF"),
                  onTap: () {
                    Navigator.pop(context);
                    onPdf();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: "Attach",
      icon: const Icon(Icons.attach_file),
      onPressed: () => _showPicker(context),
    );
  }
}