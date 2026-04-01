import 'package:get/get.dart';
import 'package:quantity_savers/app/export.dart';
import 'package:quantity_savers/app/modules/profile/models/response_model/campaign_earning_response_model.dart';
import 'package:quantity_savers/app/modules/profile/models/response_model/payout_response_model.dart';

class EarningsController extends GetxController{
  final APIRepository apiRepository = APIRepository();
  CampaignEarningResponseModel campaignEarningResponseModel = CampaignEarningResponseModel();
  PayoutResponseModel payoutResponseModel = PayoutResponseModel();
  bool isLoading =true;

  @override
  void onInit()
  {
    super.onInit();
  }


  
  hitCampaignEarning()
  {
    isLoading =true;
    Map<String,dynamic> requestModel = ProfileRequestModel.campaignEarningRequestModel();
    apiRepository.getCampaignsEarningData(queryBody: requestModel).then((value){
      if(value!=null)
        {
          campaignEarningResponseModel=value;
          isLoading=false;
          update();
        }
    }).onError((error, stackTrace) {
      isLoading =false;
      debugPrint("error $stackTrace");
      showToast(message: error.toString());
    });
  }

  hitPayOutApi()
  {
      apiRepository.payOutApi().then((value){
        if(value!=null)
          {
            payoutResponseModel=value;
            showToast(message: payoutResponseModel.data?.message.toString());
            update();
          }
      }).onError((error, stackTrace) {
        debugPrint("error $stackTrace");
        showToast(message: error.toString());
      });
  }

  @override
  void onReady() {
    hitCampaignEarning();
    super.onReady();
  }
}
