# Terra Flutter Apple Healthkit

This (unofficial) package bundles a bridge and an interface to interact with Terra's Apple SDK. This enables developers to build a react native application and connect user's Apple Healthkit to the Terra ecosystem.

## Setup

First, install the plugin:

```sh
dart pub add terra_apple_health
```

## Usage

You can refer to `/example` for an example usage. First import the plugin and create an instance:

```dart
import 'package:terra_apple_health/terra_apple_health.dart';

...

final terra = TerraAppleHealth(
    // Note pass your own API keys and Dev ID
    "terraTestDevID",
    "terraTestingAPIKey",
    autoFetch: true
);
```


After exposing a widget session to your users, if you determine they'd like to authenticate with apple health, you can call `TerraApple.auth` which authenticates the user with Terra and returns a future:

```dart
final authResult = await terra.auth();
if (authResult['terra_id'] != null) {
    // grab userID, or status from the response map
}
```

Once you have a user ID, you can connect the device SDK instance to Terra by using `TerraApple.initTerra`:

```dart
terra.initTerra(userId: authResult['terra_id']);
```

`initTerra` connects the device to Terra. This has to be done everytime the user opens the app (if the SDK is not initialised it has not indication about where to connect to Terra). On the other hand, the `auth` is only required on the first user connection from your app to map their device to a Terra user ID (after that, any call to `auth` will return the same user ID that was generated for that device)

If `autoFetch` is set to true. data is sent every 8 hours to your webhook if the users open the app.

Activity data is sent to your webhook whenever the user opens the app. You can also request data from the app to be sent to your webhook using getters:

```dart
terra.getBody(
   DateTime(2022, 01, 02),
   DateTime.now()
);
terra.getDaily(
  DateTime(2022, 01, 02),
   DateTime.now()
);
terra.getSleep(
  DateTime(2022, 01, 02),
   DateTime.now()
);
terra.getActivity(
  DateTime(2022, 01, 02),
   DateTime.now()
);
```

Finally, you can deauth users using the `deauth()` function and calling the Terra deauth API