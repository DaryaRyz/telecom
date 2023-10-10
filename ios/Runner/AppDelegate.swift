import UIKit
import Flutter
import awesome_notifications
import shared_preferences_foundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

     AwesomeNotificationsPlugin.setPluginRegistrantCallback { registry in
              AwesomeNotificationsPlugin.register(
                with: registry.registrar(forPlugin: "io.flutter.plugins.awesomenotifications.AwesomeNotificationsPlugin")!)
              SharedPreferencesPlugin.register(
                with: registry.registrar(forPlugin: "io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin")!)
          }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
