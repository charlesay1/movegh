# MoveGH Product Requirements (PRD)

## Product Vision
MoveGH is a nationwide transport and delivery platform built specifically for Ghana, offering cars, motorbikes, pragya (passenger tricycles), and aboboyaa (cargo tricycles) with Mobile Money, USSD support, and regional pricing.

Positioning: One App. Every Route. Across Ghana.

## Goals
- Deliver a safe, reliable, and affordable nationwide ride-hailing and delivery experience.
- Launch a scalable platform that works across cities, towns, and rural communities.
- Provide Ghana-first payments and pickup logic (MoMo, USSD, landmark pickups).
- Build with professional engineering, UI/UX, testing, and deployment practices.

## Non-Goals (for MVP)
- International expansion.
- Boats or water transport.
- Full offline rider app beyond basic retry and queued actions.
- Multi-language beyond English (Twi planned for later).

## Target Users
- Riders: everyday commuters in cities and towns.
- Delivery customers: individuals and small businesses.
- Drivers: car, motorbike, pragya, and aboboyaa operators.
- Business customers: shops, restaurants, and SMEs.
- Admins and operations teams.

## Core Use Cases
- Request a ride or delivery with fare estimate.
- Choose transport mode (car, motorbike, pragya, aboboyaa).
- Track driver and share trip with family.
- Pay with Mobile Money or cash.
- Schedule pickups for school, work, and recurring routes.
- Business users submit bulk delivery requests.

## Transport Modes
- Cars: passenger rides in cities and highways.
- Motorbikes: fast rides and deliveries in traffic zones and towns.
- Pragya: short passenger trips in towns and peri-urban areas.
- Aboboyaa: cargo and goods for markets, farms, and rural roads.

## Ghana-Friendly Pickup
- GPS address when available.
- Landmark-based pickups: markets, junctions, churches, lorry stations.
- Scheduled pickups for work, school, church, and medical trips.

## Core Features
Rider App
- Phone number account creation and verification.
- Request ride or delivery.
- Vehicle selection and fare estimate.
- Live GPS tracking and ETA.
- In-app call and chat.
- Trip history and ratings.
- SOS emergency button.
- Trip sharing.

Driver App
- Accept or reject trips.
- Navigation and routing.
- Daily and weekly earnings.
- Driver wallet and MoMo payouts.
- Trip history and ratings.

Business Portal
- Business delivery accounts.
- Bulk delivery requests.
- Monthly billing.
- Delivery analytics and reporting.

Admin Dashboard
- Driver verification and onboarding.
- Pricing control by region.
- Disputes and refunds.
- Operations and fraud monitoring.

## Ghana-Specific Features
- Mobile Money first (MTN MoMo, Vodafone Cash, AirtelTigo Money).
- USSD booking for feature phones.
- Regional pricing logic.
- Landmark-based pickup points.
- Offline driver mode (sync later).

## Quality Attributes
- Reliability: 99.5 percent service availability target.
- Performance: core screens load under 2 seconds on mid-range devices.
- Safety: driver verification, SOS, and trip sharing built-in.
- Accessibility: large tap targets and clear typography.
- Scalability: region-based pricing and dispatch rules.

## Success Metrics
- Time to first ride after install.
- Completed ride or delivery rate.
- Driver acceptance rate.
- MoMo payment success rate.
- Monthly active riders and drivers.
- Regional coverage expansion milestones.

## MVP Scope (Phase 1 Cities)
- Rider app: request rides, tracking, MoMo, ratings.
- Driver app: accept trips, navigation, wallet.
- Admin dashboard: verification, pricing, disputes.
- Launch cities: Accra, Tema, Kumasi, Sekondi-Takoradi, Tamale, Cape Coast, Sunyani, Ho, Koforidua, Techiman.
- Transport modes: all four modes supported.

## Roadmap
Phase 1 (0 to 6 months)
- MVP launch in major cities.
- Core ride and delivery flows.
- MoMo integration and payout to drivers.
- Admin dashboard and basic analytics.

Phase 2 (6 to 12 months)
- Expand to all 16 regional capitals.
- Business portal with bulk deliveries.
- USSD booking pilot.
- Regional pricing optimization.

Phase 3 (12 to 24 months)
- Coverage of all towns and rural areas.
- Offline driver mode improvements.
- Multi-language support (Twi).
- Sponsored routes and ads.

## Risks and Mitigations
- Payment failures: dual payment fallback and retry logic.
- Driver supply: onboarding campaigns and incentives.
- Network outages: offline driver mode and queued requests.
- Regulatory delays: early engagement with local authorities.

## Testing Strategy
- Android and iOS app testing via Play Store and TestFlight.
- Web portal testing on modern browsers.
- GPS and landmark pickup validation.
- Payment test suites for MoMo integrations.
- Load testing on dispatch and pricing services.
