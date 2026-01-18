# MoveGH Backend (Scaffold)

This is a NestJS-style scaffold with module controllers and stub endpoints aligned to the MoveGH API spec.

## What Exists
- Global prefix: `/v1` (set in `src/main.ts`).
- Health endpoint: `GET /v1/health`.
- Module controllers: auth, users, drivers, rides, deliveries, pricing, payments, regions, business, admin, ussd, notifications, tracking.
- Stub services returning sample responses for wiring and routing checks.
- SQL migration: `migrations/001_init.sql` for users, drivers, rides, payments, locations.
- Ride flow endpoints documented in `docs/MoveGH_RideFlow_API.md`.

## Next Steps
- Install dependencies (`npm install`) and run `npm run start:dev`.
- Add database configuration (PostgreSQL) and migrations.
- Replace stub services with real logic.
- Implement auth, dispatch, payments, and realtime updates.
