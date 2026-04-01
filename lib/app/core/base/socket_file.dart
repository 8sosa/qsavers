// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:quantity_savers/app/core/values/socket_events.dart';
import 'package:quantity_savers/app/modules/forums/models/data_model/group_list_data_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/group_list_response_model.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../export.dart';

class SocketIOManager extends GetxController {
  Socket? socket;
  late String token;
  late LocalStorage _localStorage;

  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void onInit() async {
    _initLocalStorage();
    await socketConnection();
    // initConnectivity();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    super.onInit();
  }

  // Future<void> initConnectivity() async {
  //   late List<ConnectivityResult> result;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     // developer.log('Couldn\'t check connectivity status', error: e);
  //     return;
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //
  //   return _updateConnectionStatus(result);
  // }
  //
  // Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
  //   _connectionStatus = result;
  //   if (result.contains(ConnectivityResult.mobile) ||
  //       result.contains(ConnectivityResult.wifi)) {
  //     _initLocalStorage();
  //     socketConnection();
  //     Get.find<ForumsChatController>().hitSendJoinForumRequestSocket(
  //         groupIds: Get.find<ForumsChatController>().groupId);
  //   }
  // }

  void _initLocalStorage() {
    if (Get.isRegistered<LocalStorage>()) {
      _localStorage = Get.find<LocalStorage>();
    } else {
      _localStorage = Get.put(LocalStorage());
    }
  }

  socketConnection() {
    token = _localStorage.getAuthToken() ?? "";
    socket = io(
      baseUrl,
      OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders({'token': token})
          .disableAutoConnect()
          .build(),
    );
    socket!
      ..onError((data) {
        debugPrint("ERROR: $data");
      })
      ..onConnect((_) {
        debugPrint('onConnection ${socket!.connected}');
      })
      ..onReconnect((data) => debugPrint("RECONNECT: $data"))
      ..onReconnectAttempt((data) => debugPrint("RECONNECT-Attempt: $data"))
      ..onReconnectError((data) => debugPrint("RECONNECT-Error: $data"))
      ..onDisconnect((_) => socket!.destroy());
    socket!.connect();
    socket!.onConnecting((data) => debugPrint("onConnecting: $data"));
  }

  Future<void> emitEvent({
    required Map<String, dynamic>? dataBody,
    required String eventName,
  }) async {
    if (dataBody == null) {
      throw ArgumentError('dataBody must not be null');
    }
    if (socket != null && socket!.connected) {
      socket!.emit(eventName, dataBody);
    }
  }

  Future<void> listenEvent({
    required String eventName,
    required Function(dynamic) onDataReceived,
  }) async {
    if (socket != null && socket!.connected) {
      socket!.on(eventName, onDataReceived);
    }
  }

  Future<void> disconnectSocket() async {
    socket?.disconnect();
  }

  @override
  void dispose() {
    // _connectivitySubscription.cancel();
    super.dispose();
  }
}
