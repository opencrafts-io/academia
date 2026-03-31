# 2. Remove Biometric Gate from Android Keystore / iOS Keychains

Date: 2026-03-31

## Status

amended

## Context

We faced a classic trade-off between security and user flow.

Initially, we used Android Keystore and iOS keychains with biometric gating, but requiring biometric verification on each app launch to decrypt secrets made the flow too heavy for this application.

## Decision

We will continue storing access tokens, refresh tokens, and device tokens in the keystore/keychain, but without biometric gating because it created a broken user flow.

## Consequences

The app becomes less secure from a security standpoint

