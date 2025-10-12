# AdMob Feature

This feature provides a complete AdMob integration system using Google Mobile Ads SDK for displaying various types of advertisements in your Flutter app.

## Features

- ✅ Google Mobile Ads SDK integration
- ✅ Banner ads support
- ✅ Interstitial ads support
- ✅ Rewarded ads support
- ✅ Native ads support (framework ready)
- ✅ Ad loading and status management
- ✅ Test mode support
- ✅ Error handling and logging
- ✅ Clean Architecture implementation

## Architecture

The feature follows Clean Architecture principles with:

- **Domain Layer**: Entities, repositories, and use cases
- **Data Layer**: Remote data sources, models, and repository implementation
- **Presentation Layer**: BLoC for state management, views, and widgets

## Usage

### 1. Initialize AdMob

```dart
// In your app initialization
final adBloc = context.read<AdBloc>();
adBloc.add(InitializeAdMobEvent());
```

### 2. Load Banner Ad

```dart
// Load a banner ad
adBloc.add(LoadBannerAdEvent(adUnitId: 'your-banner-ad-unit-id'));

// Use the BannerAdWidget
BannerAdWidget(
  adUnitId: 'your-banner-ad-unit-id',
  height: 50,
)
```

### 3. Load and Show Interstitial Ad

```dart
// Load an interstitial ad
adBloc.add(LoadInterstitialAdEvent(adUnitId: 'your-interstitial-ad-unit-id'));

// Show the ad when ready
adBloc.add(ShowInterstitialAdEvent(adId: 'ad-id'));

// Or use the InterstitialAdButton widget
InterstitialAdButton(
  adUnitId: 'your-interstitial-ad-unit-id',
  adId: 'ad-id',
  child: Text('Show Interstitial Ad'),
  onAdShown: () {
    // Handle ad shown
  },
)
```

### 4. Load and Show Rewarded Ad

```dart
// Load a rewarded ad
adBloc.add(LoadRewardedAdEvent(adUnitId: 'your-rewarded-ad-unit-id'));

// Show the ad when ready
adBloc.add(ShowRewardedAdEvent(adId: 'ad-id'));

// Or use the RewardedAdButton widget
RewardedAdButton(
  adUnitId: 'your-rewarded-ad-unit-id',
  adId: 'ad-id',
  child: Text('Show Rewarded Ad'),
  onRewardEarned: () {
    // Handle reward earned
  },
)
```

### 5. Monitor Ad States

```dart
BlocBuilder<AdBloc, AdState>(
  builder: (context, state) {
    if (state is BannerAdLoadedState) {
      return Text('Banner ad loaded: ${state.ad.id}');
    } else if (state is InterstitialAdLoadedState) {
      return Text('Interstitial ad loaded: ${state.ad.id}');
    } else if (state is RewardedAdLoadedState) {
      return Text('Rewarded ad loaded: ${state.ad.id}');
    } else if (state is AdErrorState) {
      return Text('Error: ${state.message}');
    }
    return CircularProgressIndicator();
  },
)
```

### 6. Get Loaded Ads

```dart
// Get all loaded ads
adBloc.add(LoadLoadedAdsEvent());

// Listen to loaded ads
BlocBuilder<AdBloc, AdState>(
  builder: (context, state) {
    if (state is AdsLoadedState) {
      return ListView.builder(
        itemCount: state.ads.length,
        itemBuilder: (context, index) {
          final ad = state.ads[index];
          return ListTile(
            title: Text('${ad.adType.name} Ad'),
            subtitle: Text('Status: ${ad.status.name}'),
            trailing: AdStatusWidget(adId: ad.id),
          );
        },
      );
    }
    return Text('No ads loaded');
  },
)
```

### 7. Set Test Mode

```dart
// Enable test mode
adBloc.add(SetTestModeEvent(enabled: true));

// Listen to test mode changes
BlocBuilder<AdBloc, AdState>(
  builder: (context, state) {
    if (state is TestModeSetState) {
      return Switch(
        value: state.enabled,
        onChanged: (value) {
          adBloc.add(SetTestModeEvent(enabled: value));
        },
      );
    }
    return Switch(value: false, onChanged: (_) {});
  },
)
```

## Available Events

- `InitializeAdMobEvent()`
- `LoadBannerAdEvent(adUnitId: String)`
- `LoadInterstitialAdEvent(adUnitId: String)`
- `LoadRewardedAdEvent(adUnitId: String)`
- `ShowInterstitialAdEvent(adId: String)`
- `ShowRewardedAdEvent(adId: String)`
- `LoadLoadedAdsEvent()`
- `SetTestModeEvent(enabled: bool)`

## Available States

- `AdInitialState`
- `AdLoadingState`
- `AdInitializedState`
- `BannerAdLoadedState(ad: AdEntity)`
- `InterstitialAdLoadedState(ad: AdEntity)`
- `RewardedAdLoadedState(ad: AdEntity)`
- `InterstitialAdShownState(adId: String)`
- `RewardedAdShownState(adId: String)`
- `AdsLoadedState(ads: List<AdEntity>)`
- `TestModeSetState(enabled: bool)`
- `AdErrorState(message: String)`

## Widgets

### BannerAdWidget

A widget to display banner ads:

```dart
BannerAdWidget(
  adUnitId: 'your-banner-ad-unit-id',
  height: 50,
  adSize: AdSize.banner,
)
```

### InterstitialAdButton

A button that shows interstitial ads:

```dart
InterstitialAdButton(
  adUnitId: 'your-interstitial-ad-unit-id',
  adId: 'ad-id',
  child: Text('Show Interstitial Ad'),
  onAdShown: () {
    // Handle ad shown
  },
)
```

### RewardedAdButton

A button that shows rewarded ads:

```dart
RewardedAdButton(
  adUnitId: 'your-rewarded-ad-unit-id',
  adId: 'ad-id',
  child: Text('Show Rewarded Ad'),
  onRewardEarned: () {
    // Handle reward earned
  },
)
```

### AdStatusWidget

A widget to display ad status:

```dart
AdStatusWidget(adId: 'ad-id')
```

## Setup

1. Add your AdMob app ID to your configuration
2. Add your ad unit IDs to your configuration
3. Initialize the AdBloc in your app
4. Request necessary permissions
5. Handle ad loading and display

## Test Ad Unit IDs

For testing, you can use these Google test ad unit IDs:

- **Banner**: `ca-app-pub-3940256099942544/6300978111`
- **Interstitial**: `ca-app-pub-3940256099942544/1033173712`
- **Rewarded**: `ca-app-pub-3940256099942544/5224354917`

## Error Handling

The feature includes comprehensive error handling with custom `AdMobFailure` for AdMob operations. All errors are logged and can be handled through the BLoC states.

## Dependencies

- `google_mobile_ads: ^6.0.0`
- `flutter_bloc: ^9.1.1`
- `equatable: ^2.0.5`
- `dartz: ^0.10.1`
- `logger: ^2.0.2+1`

## Configuration

Make sure to add your AdMob app ID to your Android and iOS configurations:

### Android (android/app/src/main/AndroidManifest.xml)
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"/>
```

### iOS (ios/Runner/Info.plist)
```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy</string>
```
