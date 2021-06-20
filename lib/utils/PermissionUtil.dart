import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_gallery/values/keys.dart';
import 'package:my_gallery/values/strings.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  getStoragePermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    var status = await Permission.storage.status;
    if (status.isGranted) {
      return Keys.permission_granted;
    } else if (status.isPermanentlyDenied) {
      Fluttertoast.showToast(
        msg: UIStrings.txt_storage_permission_request,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return Keys.permission_dont_ask_denied;
    } else {
      return Keys.permission_denied;
    }
  }
}
