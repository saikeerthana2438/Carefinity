import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestActivityPermission() async {
    final status = await Permission.activityRecognition.request();

    return status.isGranted;
  }

  Future<bool> isGranted() async {
    return await Permission.activityRecognition.isGranted;
  }
}