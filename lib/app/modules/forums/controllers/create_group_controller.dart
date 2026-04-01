import "package:quantity_savers/app/modules/Details/models/details_request_model.dart";
import "package:quantity_savers/app/modules/forums/models/create_group_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/create_group_response_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/group_members_response_model.dart";

import "../../../export.dart";

class CreateGroupController extends GetxController {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  final PageController pageViewController = PageController();
  TextEditingController groupNameController = TextEditingController();
  TextEditingController requestController = TextEditingController();
  List<Map<String, dynamic>> groupPrivacyList = CreateGroupModel().groupPrivacy;
  bool isRouteFromGroupInfo = false;
  bool isRouteFromCreateCampaign = false;
  List<dynamic> selectedItems = [];
  GroupMembersResponseModel groupMembersResponseModel =
      GroupMembersResponseModel();

  CreateGroupResponseModel createGroupResponseModel =
      CreateGroupResponseModel();

  List<String> selectedMembersIds = [];

  FocusNode groupNameFocusNode = FocusNode();
  FocusNode requestFocusNode = FocusNode();
  int selectedPrivacyType = 0;
  var currentPage = 1;

  // onSelectionChangeSearchFieldSelected(int index , String? id) {
  //   final  index= groupMembersResponseModel.data?.indexWhere((element) => element.sId==id);
  //   for(int i=0;i<=groupMembersResponseModel.data!.length;i++)
  //     {
  //       if(index==i)
  //         {
  //           groupMembersResponseModel.data![i].isSelected=true;
  //           selectedMembersIds.add(groupMembersResponseModel.data?[i].sId);
  //         }
  //       else
  //         {
  //           groupMembersResponseModel.data![i].isSelected=false;
  //           selectedMembersIds.remove(groupMembersResponseModel.data?[i].sId);
  //         }
  //
  //     }
  //   // if(index!=null)
  //   // {
  //   //    groupMembersResponseModel.data![index].isSelected=true;
  //   //       if(groupMembersResponseModel.data![index].isSelected==true)
  //   //       {
  //   //         bool isSelected = groupMembersResponseModel.data![index].isSelected;
  //   //         debugPrint("Is Selected $isSelected");
  //   //       }
  //   //
  //   //   else
  //   //     {
  //   //       bool isSelected = !groupMembersResponseModel.data![index].isSelected;
  //   //       debugPrint("Is Selected $isSelected");
  //   //       groupMembersResponseModel.data![index].isSelected = isSelected;
  //   //       if (isSelected) {
  //   //         selectedMembersIds.add(groupMembersResponseModel.data?[index].sId);
  //   //       } else {
  //   //         selectedMembersIds.remove(groupMembersResponseModel.data?[index].sId);
  //   //       }
  //   //      }
  //
  //      update();
  //
  // }

  void onSelectionChangeSearchFieldSelected(List<int> indices, List<String?> ids) {
    assert(indices.length == ids.length);
    debugPrint("length is ${indices.length}");

    for (int i = 0; i < groupMembersResponseModel.data!.length; i++) {
      var member = groupMembersResponseModel.data![i];

      if (indices.contains(i) && ids.contains(member.sId)) {
        member.isSelected = true;
        if (!selectedMembersIds.contains(member.sId)) {
          selectedMembersIds.add(member.sId);
        }
      } else {
        member.isSelected = false;
        selectedMembersIds.remove(member.sId);
      }
    }
    update();
  }



  onSelectionChange(int index , String? id) {

    debugPrint("This Index is $id");
    final  index= groupMembersResponseModel.data?.indexWhere((element) => element.sId==id);
    if(index!=null)
      {
        debugPrint("Is Selected ${groupMembersResponseModel.data![index].isSelected}");
        bool isSelected = !groupMembersResponseModel.data![index].isSelected;
        debugPrint("Is Selected $isSelected");
        groupMembersResponseModel.data![index].isSelected = isSelected;
        if (isSelected) {
          selectedMembersIds.add(groupMembersResponseModel.data?[index].sId);
        } else {
          selectedMembersIds.remove(groupMembersResponseModel.data?[index].sId);
        }
        update();
      }

  }

  @override
  void onInit() {
    getArguments();
    hitGetMembersApiCall();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      isRouteFromGroupInfo = Get.arguments[argIsRouteFromGroupInfo] ?? false;
      isRouteFromCreateCampaign=Get.arguments[argIsFromCreateCampaign] ?? false;
    }
  }

  @override
  void dispose() {
    groupNameFocusNode.dispose();
    requestFocusNode.dispose();
    super.dispose();
  }

  hitGetMembersApiCall() {
    Map<String, dynamic> requestModel =
        DetailsRequestModel.groupMembersRequestModel();
    _apiRepository
        .getGroupMembersApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        groupMembersResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitCreateGroupApi() {
    Map<String, dynamic> requestModel =
        DetailsRequestModel.createGroupRequestModel(
            groupName: groupNameController.text,
            groupType: groupPrivacyList[selectedPrivacyType]["payload"],
            groupMembers: selectedMembersIds,
            request: requestController.text);
    _apiRepository
        .createGroupApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        createGroupResponseModel = value;
        showToast(message: createGroupResponseModel.data?.message);
        if(isRouteFromCreateCampaign==true)
          {
            Get.offAllNamed(AppRoutes.startCampaignScreenRoute);
          }
        else
          {
            Get.offAllNamed(AppRoutes.mainScreenRoute,
                arguments: {argBottomNavigationIndex: 2});
          }

        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  void navigateToNextPage() {
    pageViewController.nextPage(
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
    currentPage += 1;
    update();
  }

  void navigateToPreviousPage() {
    if (currentPage > 1) {
      pageViewController.previousPage(
          duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
      currentPage -= 1;
    }
    update();
  }

}
