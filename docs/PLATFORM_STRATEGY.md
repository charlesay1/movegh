# Platform Strategy

This document explains the best build approach for MoveGH across all devices in clear, beginner-friendly terms.

## 1) Mobile Apps (iPhone + Android)

Use Flutter as the primary choice.

Why:
- One codebase ships to both iOS and Android.
- Consistent UI/UX across devices.
- Faster and cheaper than building two separate native apps.

## 2) iPad / Tablet Support

Use the same Flutter app with responsive layouts.

What changes for tablets:
- Tablet-friendly UI layouts (more space, larger components).
- Split view panels (example: map on the left, trip details on the right).
- Bigger buttons and panels for touch comfort.

Flutter handles this well with layout widgets and screen size breakpoints.

## 3) Computer (Web App)

Use Flutter Web for admin and business portals, and for lightweight customer access.

Notes:
- Rider/Driver web apps are optional.
- The marketplace experience is mobile-first for riders and drivers.

## Recommendation

Phase 1:
- Flutter mobile apps (rider + driver)
- Web admin portal

Phase 2:
- Tablet optimization

Phase 3:
- Dedicated web experiences (only if needed)
