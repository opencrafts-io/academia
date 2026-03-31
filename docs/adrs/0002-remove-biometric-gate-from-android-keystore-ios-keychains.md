# 2. Remove Biometric Gate from Android Keystore/ ios Keychains

Date: 2026-03-31

## Status

amended

## Context

We were faces by a classical scenario of security vs user flow.

Initialy we had implemented Android Keystore and iOS keychains with biometrics but some concern was raised that the requirement to provision your biometrics on each app launch to decrypt the secrets was super hardcore for a simple application.

## Decision

Following this scenario, a decision was made to soften our security mechanism of storing the device access / refresh tokens,  still use keychains / keystores for secrets such as device tokens, but with the exception of biometrics since it looked like a gimick and it resulted to a broken user flow

## Consequences

The app becomes less secure from a security standpoint

