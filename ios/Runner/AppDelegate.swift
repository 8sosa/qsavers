import Firebase
import UIKit
import Flutter
import flutter_local_notifications
import app_links

@main 
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()

    // REMOVED: GeneratedPluginRegistrant.register(with: self) 
    // This is now handled in the method below.

    UNUserNotificationCenter.current().delegate = self

    if let url = AppLinks.shared.getLink(launchOptions: launchOptions) {
      AppLinks.shared.handleLink(url: url)
      return true
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // This is the correct modern entry point for plugins
  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    
    // Background notifications handler
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }
  }

  override func userNotificationCenter(
    _ center: UNUserNotificationCenter, 
    willPresent notification: UNNotification, 
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([.alert, .badge, .sound])
  }
}