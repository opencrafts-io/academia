# Awesome Notifications Core - Year 2

<div>

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](#)
[![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)](#)
[![Discord](https://img.shields.io/discord/888523488376279050.svg?style=for-the-badge&colorA=7289da&label=Chat%20on%20Discord)](https://discord.awesome-notifications.carda.me)

[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)](#)
[![pub package](https://img.shields.io/pub/v/awesome_notifications_core.svg)](https://pub.dev/packages/awesome_notifications_core)

Provides a convenient way to automatically manage all versions of awesome_notifications plugins, ensuring that they are always compatible with each other, and that you are always using the latest versions of the plugins.

<br>

# 💬 Discord Chat Server

Don't forget to stay up to date with new updates and get community support by subscribing to our Discord chat server:

[![Discord Banner 3](https://discordapp.com/api/guilds/888523488376279050/widget.png?style=banner3)](https://discord.awesome-notifications.carda.me)

<br>
<br>

# 🛠️ Getting Started:

To use the `awesome_notifications_core` plugin to manage all of your awesome notifications plugin versions, follow these steps:

1. Add the `awesome_notifications_core` plugin to your project's `pubspec.yaml` file:

```yaml
dependencies:
  awesome_notifications_core: ^0.10.0 # latest
```

2. Add all of the other awesome notifications plugins that you want to use in your project, with the version value set to `any`:

```yaml
dependencies:
  # Awesome plugins for local notifications
  awesome_notifications_core: ^0.10.0 # use the latest core version available
  awesome_notifications: ^0.10.0 # use the latest version available

  # Awesome plugins for remote push notifications
  awesome_notifications_fcm: ^0.10.0 # use the latest version available
  # Attention:
  # The firebase_messaging plugin is not necessary. awesome_notifications_fcm is a replacement for it
  # firebase_messaging: ^X.X.X

  # Firebase plugins necessary to use Firebase Cloud Messaging with Awesome Notifications
  firebase_core: ^X.X.X # use the latest available
  firebase_crashlytics: ^X.X.X # use the latest available
```

## Tips

* You only need to add the awesome_notifications plugins that you need to use. The only packages required are `awesome_notifications` and `awesome_notifications_core`.
* The `^` operator in the version constraints tells Flutter to install the latest version of the package that is compatible with the specified major version.
* By setting the version constraints for your awesome notifications plugins to `any`, you are allowing the `awesome_notifications_core` plugin to automatically manage the versions of those plugins and ensure that they are always compatible with each other.

<br>
<br>

# 💰 Donate via Stripe or BuyMeACoffee

Help us improve and maintain our work with donations of any amount via Stripe or BuyMeACoffee. Your donation will mainly be used to purchase new devices and equipment, which we will use to test and ensure that our plugins work correctly on all platforms and their respective versions.

[*![Donate With Stripe](https://github.com/rafaelsetragni/awesome_notifications/blob/68c963206885290f8a44eee4bfc7e7b223610e4a/example/assets/readme/stripe.png?raw=true)*](https://donate.stripe.com/3cs14Yf79dQcbU4001)
[*![Donate With Buy Me A Coffee](https://github.com/rafaelsetragni/awesome_notifications/blob/95ee986af0aa59ccf9a80959bbf3dd60b5a4f048/example/assets/readme/buy-me-a-coffee.jpeg?raw=true)*](https://www.buymeacoffee.com/rafaelsetragni)
