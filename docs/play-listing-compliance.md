# Google Play listing: AccessibilityService disclosure

Add the following paragraph to Academia's Google Play **long description**
before resubmitting:

> Lock In uses Android's AccessibilityService API to identify the app currently
> open and enforce the app-blocking rules and schedules you create. When a
> selected app is opened during an active rule, Academia shows a block screen.
> The app name and blocked-open events are used only for Lock In and local focus
> statistics on your device; they are not shared with Academia or third parties.

In Play Console, keep the AccessibilityService declaration accurate: Academia
is not an accessibility tool, and Lock In accesses app activity solely to apply
the user-configured focus rules. Record a reviewer video showing the disclosure,
the **Not now** path, the **I understand, continue** path, enabling the service
in Android Settings, and a selected app being blocked.
