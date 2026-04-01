import "package:quantity_savers/app/core/values/socket_events.dart";
import "package:quantity_savers/app/modules/forums/models/forums_request_model.dart";
import "package:quantity_savers/app/modules/home/models/response_model/get_schedule_live_broad_cast_response_model.dart";
import "package:quantity_savers/app/modules/home/models/response_model/schedule_live_broadcast_response_model.dart";

import "../../../export.dart";

class ScheduledLiveBroadcastController extends GetxController {
  final APIRepository _apiRepository = APIRepository();
  GetScheduleLiveBroadCastResponseModel getScheduleLiveBroadCastResponseModel =
      GetScheduleLiveBroadCastResponseModel();
  ScheduleLiveBroadCastResponseModel scheduleLiveBroadCastResponseModel =
      ScheduleLiveBroadCastResponseModel();
  var isLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    hitGetLiveBroadCastData();

    socketIOManager?.listenEvent(
        eventName: deleteLiveSchedule,
        onDataReceived: (data) {
          debugPrint("Dataa $data");
          if (data != null) {
            debugPrint("Datum $data");
            hitGetLiveBroadCastData();
          }
          update();
        });
  }

  hitGetLiveBroadCastData() {
    isLoading = true;
    _apiRepository.getscheduleLiveApiCall().then((value) {
      if (value != null) {
        getScheduleLiveBroadCastResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitEditScheduleLiveBroadCast(String? id, String? date, String? time) {
    isLoading = true;
    Map<String, dynamic> requestModel =
        ForumsRequestModel.editScheduleLiveBroadCastRequestModel(
            date: date, time: time);

    _apiRepository
        .editScheduleLiveBroadCastApiCall(dataBody: requestModel, id: id)
        .then((value) async {
      if (value != null) {
        scheduleLiveBroadCastResponseModel = value;
        showToast(
            message: scheduleLiveBroadCastResponseModel.message.toString());
        hitGetLiveBroadCastData();
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitDeleteSocket(var campaignId) async {
    debugPrint("campaignId is $campaignId");
    Map<String, dynamic> requestModel =
        ForumsRequestModel.sendHeartRequestModel(campaignId: campaignId);
    debugPrint("RequestModel is $requestModel");
    await socketIOManager?.emitEvent(
        dataBody: requestModel, eventName: deleteLiveSchedule);
  }
}
