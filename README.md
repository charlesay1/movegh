# MoveGH Project Workspace

This workspace contains documentation, UI previews, backend scaffolding, and a Flutter app scaffold for MoveGH.

See docs/PLATFORM_STRATEGY.md for our platform approach.

## Structure
- docs/ MoveGH product requirements and backend architecture.
- ui/ HTML previews for UI direction and screen layouts.
- backend/ NestJS-style backend scaffold with stubbed controllers.
- mobile/ Flutter UI scaffold aligned to the approved preview.

## Quick Start
- Open UI preview: ui/MoveGH_UI_Preview.html
- Read docs: docs/MoveGH_PRD.md and docs/MoveGH_Backend_Architecture.md
- Ride flow API: docs/MoveGH_RideFlow_API.md

## Quick Start (Local)
- UI preview: open `ui/MoveGH_UI_Preview.html` in a browser.
- Backend: `npm install` then `npm run start:dev` inside `backend/`.
- Mobile: run `flutter create .` inside `mobile/` (if Flutter SDK is installed), then `flutter pub get`.

## Next Steps
- Wire real database models and migrations for rides, deliveries, users, and payments.
- Replace backend stub services with real business logic.
- Connect Flutter services to the backend and add state management.
