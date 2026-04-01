import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/values/route_arguments.dart';
import '../../../routes/app_routes.dart';


class DynamicLinkingController extends GetxController {
  late AppLinks _appLinks;

  @override
  void onInit() {
    _appLinks = AppLinks();
    super.onInit();
  }

  Future<void> generateDeepLink(var id,var type) async {
    // final url = 'http://quantitysavers.com/$type/p/$id';
    // Share.share(url);
    if(type=="campaign")
      {
        final url = 'https://quantitysavers.com/$type/$id/ongoing/view';
        Share.share(url);
      }
    else
      {
        final formattedType = type.replaceAll(' ', '-');
        final url = 'https://quantitysavers.com/$formattedType/p/$id';
        Share.share(url);
      }

  }

  void listenDeepLinkData() async {
    _appLinks.uriLinkStream.listen((event) {
      if (event.path.contains('/p/')) {
        handleDeepLink(event.path);
      }
      else
        {
          handleCampaignLink(event.path);
        }
    });
  }

  void handleDeepLink(String link) {
    Uri uri = Uri.parse(link);
    if (uri.pathSegments.isNotEmpty) {
      String category = uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : '';
      String productId = uri.pathSegments.length > 2 ? uri.pathSegments[2] : '';

      if (productId.isNotEmpty) {
        Get.toNamed(AppRoutes.productsDetailsScreenRoute, arguments: {
          argProductId: productId,
        });
      }
    }
  }

  void handleCampaignLink(String link)
  {
    print("CampaignId is $link");
    Uri uri = Uri.parse(link);
    if(uri.pathSegments.isNotEmpty)
      {
        String campaignId = uri.pathSegments[1];
        if (campaignId.isNotEmpty) {
          Get.toNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
            argCampaignId: campaignId,
          });
        }
      }
  }

}
