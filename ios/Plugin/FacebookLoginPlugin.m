#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(FacebookLoginPlugin, "FacebookLogin",
           CAP_PLUGIN_METHOD(initialize, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(login, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(loginWithLimitedTracking, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(logout, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getCurrentAccessToken, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getProfile, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(reauthorize, CAPPluginReturnPromise);
)
