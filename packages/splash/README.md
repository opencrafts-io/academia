# Splash tips

The host app displays one tip per launch. Tip order advances between launches,
and the last valid production configuration is cached on-device for offline
launches. Development and staging use the bundled defaults.

Production reads a PostHog feature flag payload named `splash_launch_tips`.
Update that payload to change tip copy, actions, enablement, or the minimum
splash display time without releasing the app.

```json
{
  "enabled": true,
  "minimumDisplayMs": 2200,
  "tips": [
    {
      "id": "premium",
      "title": "Want fewer interruptions?",
      "message": "Premium removes ads across Academia.",
      "actionLabel": "Explore Premium",
      "action": "premium"
    },
    {
      "id": "notifications",
      "title": "Make reminders work for you",
      "message": "Choose which study reminders you receive.",
      "actionLabel": "Notification settings",
      "action": "notifications"
    },
    {
      "id": "lock-in",
      "title": "Give your focus some space",
      "message": "Block distracting apps during study time.",
      "actionLabel": "Explore Lock In",
      "action": "lock_in"
    }
  ]
}
```

Supported actions are `premium`, `notifications`, and `lock_in`. Use an empty
`actionLabel` and omit `action` for an informational tip. Set `enabled` to
`false` to hide tips and remove the minimum display delay. The splash accepts
durations from 0 to 5000 milliseconds.
