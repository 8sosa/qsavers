import '../../../export.dart';
import '../controllers/forum_media_controller.dart';

class ForumMediaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForumMediaController>(
          () => ForumMediaController(),
    );
  }
}