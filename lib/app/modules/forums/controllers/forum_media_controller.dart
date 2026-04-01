import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:quantity_savers/app/modules/forums/models/data_model/forum_sent_request_data_model.dart';
import 'package:quantity_savers/app/modules/forums/models/forums_request_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/forum_media_response_model.dart';

import '../../../export.dart';

class ForumMediaController extends GetxController
    with GetSingleTickerProviderStateMixin {
final APIRepository apiRepository = APIRepository();
ForumMediaResponseModel forumMediaResponseModel = ForumMediaResponseModel();
  TabController? tabController;
  var currentIndex = 0;
  var groupId;
  bool isLoading = false;

  @override
  void onInit()
  {
    lightTheme(color: AppColors.appColor);
    tabController = TabController(vsync: this, length: 4);
    tabController?.addListener(() {
      debugPrint("selectedIndexUpdate ${tabController?.index}");
      currentIndex= tabController?.index??0;
      update();
    });
    groupId=Get.arguments[argGroupId] ?? "";
    debugPrint("GroupId is $groupId");
    hitForumMediaApiCall("IMAGE",showLoader: true);
    super.onInit();


  }

  onTabChanged(int index) async {
    currentIndex = index;
    debugPrint("$index");
    if(currentIndex==0)
    {
      hitForumMediaApiCall("IMAGE",showLoader: true);
    }
    else if(currentIndex==1)
    {
      hitForumMediaApiCall("DOCUMENT",showLoader: true);
    }
    else if(currentIndex==2)
    {
      hitForumMediaApiCall("LINK",showLoader: true);
    }
    else
    {
      hitForumMediaApiCall("VIDEO",showLoader: true);
    }

    update();
  }

  hitForumMediaApiCall(String mediaType,{bool showLoader=true})
  {
    if(showLoader)
      {
        isLoading=true;
      }
    Map<String, dynamic>? requestModel =
   ForumsRequestModel.forumMediaRequestModel(type: mediaType);
    apiRepository.forumMediaApiCall(queryBody: requestModel,id: groupId).then((value){
      if(value!=null)
        {
          forumMediaResponseModel=value;
          isLoading=false;
          update();
        }
    }).onError((error, stackTrace) {
      isLoading=false;
      showToast(message: error.toString());
    } );

  }

}
