# MoveGH Backend Architecture and API Spec

## Architecture Overview
MoveGH uses a modular service-oriented backend with a shared PostgreSQL database and real-time updates over WebSockets. The API serves mobile apps, web dashboards, and USSD.

Recommended stack
- Runtime: Node.js with NestJS (TypeScript).
- Database: PostgreSQL.
- Cache: Redis (sessions, pricing, dispatch queues).
- Realtime: WebSockets (location updates, trip state).
- Queue: BullMQ or SQS for async jobs (notifications, payments).
- Storage: S3 for driver docs.

## Core Services (Modules)
- Auth and Identity: phone verification, JWT, roles.
- Users: profiles, devices, language.
- Drivers: verification, vehicle, documents.
- Vehicles: type, capacity, pricing rules.
- Rides: request, matching, lifecycle.
- Deliveries: parcel flow, recipients, proof of delivery.
- Pricing: region rules, seat-based and load-based pricing.
- Payments: MoMo integrations, wallet, payouts.
- Dispatch and Tracking: driver location, ETA, trip state.
- Regions and Landmarks: pickup points and coverage.
- Business: accounts, bulk delivery, invoicing.
- Admin: disputes, refunds, fraud, compliance.
- USSD: low-bandwidth booking flow.
- Notifications: SMS, push, in-app.

## Key Data Model (High Level)
- User: id, phone, name, role, status.
- Driver: id, user_id, license, verification_status, rating.
- Vehicle: id, driver_id, type, plate, capacity, status.
- Ride: id, user_id, driver_id, vehicle_type, status, pickup, dropoff, fare.
- Delivery: id, user_id, driver_id, package_type, status, pickup, dropoff, fare.
- Region: id, name, pricing_rules, active.
- Landmark: id, region_id, name, geo_point.
- PricingRule: id, region_id, vehicle_type, base_fare, per_km, per_min.
- Wallet: id, owner_id, balance.
- Payment: id, wallet_id, method, status, amount, reference.
- Payout: id, driver_id, status, amount, momo_ref.
- BusinessAccount: id, name, billing_plan, status.
- AdminAction: id, admin_id, action_type, metadata.

## Authentication
- Phone number OTP verification (SMS).
- JWT access token + refresh token.
- Roles: rider, driver, business, admin.
- Device registration for push notifications.

## API Endpoints (High Level)
Base path: /v1

Auth
- POST /auth/otp/request
- POST /auth/otp/verify
- POST /auth/refresh

Users
- GET /users/me
- PATCH /users/me
- GET /users/me/trips

Drivers
- POST /drivers/onboard
- GET /drivers/me
- PATCH /drivers/me
- POST /drivers/vehicles
- GET /drivers/earnings

Rides
- POST /rides/request
- POST /rides/{ride_id}/cancel
- POST /rides/{ride_id}/accept
- POST /rides/{ride_id}/start
- POST /rides/{ride_id}/complete
- GET /rides/{ride_id}

Deliveries
- POST /deliveries/request
- POST /deliveries/{delivery_id}/cancel
- POST /deliveries/{delivery_id}/accept
- POST /deliveries/{delivery_id}/pickup
- POST /deliveries/{delivery_id}/complete
- GET /deliveries/{delivery_id}

Pricing
- GET /pricing/estimate
- GET /pricing/regions

Payments
- POST /payments/charge
- POST /payments/momo/callback
- POST /payouts/request
- GET /wallets/me

Regions and Landmarks
- GET /regions
- GET /regions/{region_id}/landmarks

Business
- POST /business/signup
- GET /business/orders
- POST /business/orders/bulk
- GET /business/invoices

Admin
- GET /admin/drivers/pending
- POST /admin/drivers/{driver_id}/approve
- POST /admin/pricing/regions
- POST /admin/disputes/{dispute_id}/resolve

USSD
- POST /ussd/session

Notifications
- POST /notifications/push

## Realtime Channels
WebSocket topics
- rider:{user_id}: trip updates, driver ETA.
- driver:{driver_id}: dispatch offers, cancellations.
- region:{region_id}: supply and demand metrics (admin).

## Dispatch Flow (Simplified)
1) Rider requests ride with pickup, dropoff, mode.
2) Pricing service generates estimate and creates ride request.
3) Dispatch service finds nearby drivers and sends offers.
4) Driver accepts, ride status updates in realtime.
5) Trip tracked, fares computed, payment captured.

## MoMo Payment Flow
1) Rider requests payment authorization.
2) Payment service calls MoMo API and receives reference.
3) MoMo callback updates payment status.
4) Wallet updated; payout queued for driver.

## USSD Flow
- USSD gateway posts session events to /ussd/session.
- User selects pickup landmark and destination.
- System creates ride request and returns confirmation.

## Observability and Ops
- Logging: request_id and ride_id correlation.
- Metrics: response times, dispatch latency, payment success.
- Alerts: failed payments, SOS trigger rate.
- Audit trail for admin actions.

## Security
- Role-based access control.
- Rate limiting and IP throttling.
- Encrypted storage for sensitive documents.
- Webhook verification for payment callbacks.
