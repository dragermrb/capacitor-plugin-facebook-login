# @whiteguru/capacitor-plugin-facebook-login

Capacitor plugin to login with Facebook

**Note**
**This is a fork of [@capacitor-community/facebook-login](https://github.com/capacitor-community/facebook-login) with `Limited Tracking Login` method.**

## Install (Capacitor 6.x)

```bash
npm install @whiteguru/capacitor-plugin-facebook-login
npx cap sync
```

### or for Capacitor 5.x

```bash
npm install @whiteguru/capacitor-plugin-facebook-login@^5.0.1
npx cap sync
```

### or for Capacitor 4.x

```bash
npm install @whiteguru/capacitor-plugin-facebook-login@^4.0.1
npx cap sync
```

### Android configuration

In file `android/app/src/main/AndroidManifest.xml`, add the following XML elements under `<manifest><application>` :

```xml
<meta-data android:name="com.facebook.sdk.ApplicationId" android:value="@string/facebook_app_id"/>
<meta-data android:name="com.facebook.sdk.ClientToken" android:value="@string/facebook_client_token"/>
```

In file `android/app/src/main/res/values/strings.xml` add the following lines :

```xml
<string name="facebook_app_id">[APP_ID]</string>
<string name="facebook_client_token">[CLIENT_TOKEN]</string>
```

Don't forget to replace `[APP_ID]` and `[CLIENT_TOKEN]` by your Facebook application Id.

More information can be found here: https://developers.facebook.com/docs/android/getting-started

#### If you have trouble.

Please restart Android Studio, and do clean build.

### iOS configuration

In file `ios/App/App/AppDelegate.swift` add or replace the following:

```swift
import UIKit
import Capacitor
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FBSDKCoreKit.ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )

        return true
    }

    ...

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        // Called when the app was launched with a url. Feel free to add additional processing here,
        // but if you want the App API to support tracking app url opens, make sure to keep this call
        if (FBSDKCoreKit.ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )) {
            return true;
        } else {
            return ApplicationDelegateProxy.shared.application(app, open: url, options: options)
        }
    }
}
```

Add the following in the `ios/App/App/info.plist` file inside of the outermost `<dict>`:

```xml

<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>fb[APP_ID]</string>
        </array>
    </dict>
</array>
<key>FacebookAppID</key>
<string>[APP_ID]</string>
<key>FacebookClientToken</key>
<string>[CLIENT_TOKEN]</string>
<key>FacebookDisplayName</key>
<string>[APP_NAME]</string>
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>fbapi</string>
    <string>fbapi20130214</string>
    <string>fbapi20130410</string>
    <string>fbapi20130702</string>
    <string>fbapi20131010</string>
    <string>fbapi20131219</string>
    <string>fbapi20140410</string>
    <string>fbapi20140116</string>
    <string>fbapi20150313</string>
    <string>fbapi20150629</string>
    <string>fbapi20160328</string>
    <string>fbauth</string>
    <string>fb-messenger-share-api</string>
    <string>fbauth2</string>
    <string>fbshareextension</string>
</array>
```

More information can be found here: https://developers.facebook.com/docs/facebook-login/ios

### Web configuration

```typescript
import { FacebookLogin } from '@whiteguru/capacitor-plugin-facebook-login';

// use hook after platform dom ready
await FacebookLogin.initialize({ appId: '105890006170720' });
```

More information can be found here: https://developers.facebook.com/docs/facebook-login/web
And you must confirm return type at https://github.com/rdlabo/capacitor-facebook-login/blob/master/src/web.ts#L55-L57
not same type for default web facebook login!

## Example

### Login

```ts
import {
  FacebookLogin,
  FacebookLoginResponse,
} from '@whiteguru/capacitor-plugin-facebook-login';

const FACEBOOK_PERMISSIONS = [
  'email',
  'user_birthday',
  'user_photos',
  'user_gender',
];
const result = await (<FacebookLoginResponse>(
  FacebookLogin.login({ permissions: FACEBOOK_PERMISSIONS })
));

if (result.accessToken) {
  // Login successful.
  console.log(`Facebook access token is ${result.accessToken.token}`);
}
```

### Login with Limited Tracking (IOS only)

A successful login in Limited Login returns an `AuthenticationToken` instance instead of a `AccessToken`. This is a JSON web token (JWT) containing a signature, and other pieces of information. Your app should validate the token to make sure it is authentic.

More information can be found here: https://developers.facebook.com/docs/facebook-login/limited-login/token/validating

```ts
import {
  FacebookLogin,
  FacebookLimitedLoginResponse,
} from '@whiteguru/capacitor-plugin-facebook-login';

const FACEBOOK_PERMISSIONS = [
  'email',
  'user_birthday',
  'user_photos',
  'user_gender',
];
const result = await (<FacebookLimitedLoginResponse>(
  FacebookLogin.loginWithLimitedTracking({ permissions: FACEBOOK_PERMISSIONS })
));

if (result.authenticationToken) {
  // Login successful.
  console.log(
    `Facebook authentication token is ${result.authenticationToken.token}`,
  );
}
```

### Logout

```ts
import { FacebookLogin } from '@whiteguru/capacitor-plugin-facebook-login';

await FacebookLogin.logout();
```

### CurrentAccessToken

```ts
import {
  FacebookLogin,
  FacebookLoginResponse,
} from '@whiteguru/capacitor-plugin-facebook-login';

const result = await (<FacebookLoginResponse>(
  FacebookLogin.getCurrentAccessToken()
));

if (result.accessToken) {
  console.log(`Facebook access token is ${result.accessToken.token}`);
}
```

### getProfile

```ts
import {
  FacebookLogin,
  FacebookLoginResponse,
} from '@whiteguru/capacitor-plugin-facebook-login';

const result = await FacebookLogin.getProfile<{
  email: string;
}>({ fields: ['email'] });

console.log(`Facebook user's email is ${result.email}`);
```

## API

<docgen-index>

- [`initialize(...)`](#initialize)
- [`login(...)`](#login)
- [`loginWithLimitedTracking(...)`](#loginwithlimitedtracking)
- [`logout()`](#logout)
- [`reauthorize()`](#reauthorize)
- [`getCurrentAccessToken()`](#getcurrentaccesstoken)
- [`getProfile(...)`](#getprofile)
- [Interfaces](#interfaces)
- [Type Aliases](#type-aliases)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### initialize(...)

```typescript
initialize(options: Partial<FacebookConfiguration>) => Promise<void>
```

| Param         | Type                                                                                                          |
| ------------- | ------------------------------------------------------------------------------------------------------------- |
| **`options`** | <code><a href="#partial">Partial</a>&lt;<a href="#facebookconfiguration">FacebookConfiguration</a>&gt;</code> |

---

### login(...)

```typescript
login(options: { permissions: string[]; }) => Promise<FacebookLoginResponse>
```

| Param         | Type                                    |
| ------------- | --------------------------------------- |
| **`options`** | <code>{ permissions: string[]; }</code> |

**Returns:** <code>Promise&lt;<a href="#facebookloginresponse">FacebookLoginResponse</a>&gt;</code>

---

### loginWithLimitedTracking(...)

```typescript
loginWithLimitedTracking(options: { permissions: string[]; }) => Promise<FacebookLimitedLoginResponse>
```

| Param         | Type                                    |
| ------------- | --------------------------------------- |
| **`options`** | <code>{ permissions: string[]; }</code> |

**Returns:** <code>Promise&lt;<a href="#facebooklimitedloginresponse">FacebookLimitedLoginResponse</a>&gt;</code>

---

### logout()

```typescript
logout() => Promise<void>
```

---

### reauthorize()

```typescript
reauthorize() => Promise<FacebookLoginResponse>
```

**Returns:** <code>Promise&lt;<a href="#facebookloginresponse">FacebookLoginResponse</a>&gt;</code>

---

### getCurrentAccessToken()

```typescript
getCurrentAccessToken() => Promise<FacebookCurrentAccessTokenResponse>
```

**Returns:** <code>Promise&lt;<a href="#facebookcurrentaccesstokenresponse">FacebookCurrentAccessTokenResponse</a>&gt;</code>

---

### getProfile(...)

```typescript
getProfile<T extends object>(options: { fields: readonly string[]; }) => Promise<T>
```

| Param         | Type                                        |
| ------------- | ------------------------------------------- |
| **`options`** | <code>{ fields: readonly string[]; }</code> |

**Returns:** <code>Promise&lt;T&gt;</code>

---

### Interfaces

#### FacebookConfiguration

| Prop                   | Type                 |
| ---------------------- | -------------------- |
| **`appId`**            | <code>string</code>  |
| **`autoLogAppEvents`** | <code>boolean</code> |
| **`xfbml`**            | <code>boolean</code> |
| **`version`**          | <code>string</code>  |
| **`locale`**           | <code>string</code>  |

#### FacebookLoginResponse

| Prop                             | Type                                                        |
| -------------------------------- | ----------------------------------------------------------- |
| **`accessToken`**                | <code><a href="#accesstoken">AccessToken</a> \| null</code> |
| **`recentlyGrantedPermissions`** | <code>string[]</code>                                       |
| **`recentlyDeniedPermissions`**  | <code>string[]</code>                                       |

#### AccessToken

| Prop                      | Type                  |
| ------------------------- | --------------------- |
| **`applicationId`**       | <code>string</code>   |
| **`declinedPermissions`** | <code>string[]</code> |
| **`expires`**             | <code>string</code>   |
| **`isExpired`**           | <code>boolean</code>  |
| **`lastRefresh`**         | <code>string</code>   |
| **`permissions`**         | <code>string[]</code> |
| **`token`**               | <code>string</code>   |
| **`userId`**              | <code>string</code>   |

#### FacebookLimitedLoginResponse

| Prop                      | Type                                                                        |
| ------------------------- | --------------------------------------------------------------------------- |
| **`authenticationToken`** | <code><a href="#authenticationtoken">AuthenticationToken</a> \| null</code> |

#### AuthenticationToken

| Prop         | Type                |
| ------------ | ------------------- |
| **`token`**  | <code>string</code> |
| **`userId`** | <code>string</code> |

#### FacebookCurrentAccessTokenResponse

| Prop              | Type                                                        |
| ----------------- | ----------------------------------------------------------- |
| **`accessToken`** | <code><a href="#accesstoken">AccessToken</a> \| null</code> |

### Type Aliases

#### Partial

Make all properties in T optional

<code>{
[P in keyof T]?: T[P];
}</code>

</docgen-api>
