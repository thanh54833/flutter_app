import 'package:permission/permission.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

class HandlePermission {
  // Make this a singleton class.
  HandlePermission._privateConstructor();

  static final HandlePermission instance =
      HandlePermission._privateConstructor();

  requestPermissions(List<PermissionName> permissionNames) async {
    var message = '';
    List<PermissionName> requestPermission = [];
    List<Permissions> statePermissions =
        await Permission.getPermissionsStatus(permissionNames);
    statePermissions.forEach((permission) {
      message +=
          '${permission.permissionName}: ${permission.permissionStatus}\n';
      //"message :.. ${message} ".Log();
      if (permission.permissionStatus == PermissionStatus.deny) {
        requestPermission.add(permission.permissionName);
      }
    });
    if (requestPermission.length != 0) {
      message = '';
      //List<PermissionName> permissionNames = [PermissionName.Storage];
      var permissions = await Permission.requestPermissions(requestPermission);
      permissions.forEach((permission) {
        message +=
            '${permission.permissionName}: ${permission.permissionStatus}\n';
      });
    }
  }
}
