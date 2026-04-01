import "package:quantity_savers/app/modules/forums/models/forums_request_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/report_member_response_model.dart";

import "../../../export.dart";

class ReportMemberController extends GetxController {

  TextEditingController commentEditingController = TextEditingController();
  ReportMemberResponseModel reportMemberResponseModel=ReportMemberResponseModel();

  FocusNode commentFocusNode = FocusNode();
  final _apiRepository = Get.find<APIRepository>();
 String memberId='';
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  final APIRepository _repository = Get.find<APIRepository>();

  @override
  void onInit()
  {
    if(Get.arguments!=null)
      {
        memberId=Get.arguments[argMemberId];
        debugPrint("MemberId is $memberId");
      }
    super.onInit();


  }



  hitReportMemberApi() {
    Map<String, dynamic> requestModel =
    ForumsRequestModel.reportMembersRequestModel(
        memberId: memberId, reason: commentEditingController.text.trim());

    _apiRepository
        .reportMemberApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        reportMemberResponseModel = value;
        Get.back();
        showToast(message:reportMemberResponseModel.message.toString());
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }






}
