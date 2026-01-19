# MoveGH API Contract (Draft)

Base URL (local dev): `http://localhost:3000/v1`

Authenticated requests should include:
`Authorization: Bearer <token>`

## Auth

### POST /auth/otp/request
Request an OTP for a phone number.

Request:
```json
{
  "phone": "+233201234567"
}
```

Response:
```json
{
  "status": "sent",
  "ttl_sec": 180
}
```

### POST /auth/otp/verify
Verify OTP and return a session token.

Request:
```json
{
  "phone": "+233201234567",
  "code": "1234"
}
```

Response:
```json
{
  "status": "verified",
  "token": "access_token_here",
  "refresh_token": "refresh_token_here",
  "user": {
    "id": "user_001",
    "phone": "+233201234567",
    "name": "Yaw Mensah"
  }
}
```

## Rider: Ride requests

### POST /rides
Create a ride request.

Request:
```json
{
  "pickup": "Accra Mall",
  "dropoff": "Osu Oxford St",
  "mode": "car",
  "notes": "Blue gate near the church"
}
```

Response:
```json
{
  "ride_id": "ride_001",
  "status": "requested",
  "amount": 24,
  "currency": "GHS"
}
```

### GET /rides/:rideId
Get current ride status.

Response:
```json
{
  "ride_id": "ride_001",
  "status": "assigned",
  "driver": {"name": "Kojo Mensah", "rating": 4.9},
  "eta_min": 4,
  "amount": 24,
  "currency": "GHS"
}
```

## Rider: Profile

### PATCH /users/me
Update rider profile details.

Request:
```json
{
  "first_name": "Ama",
  "last_name": "Mensah",
  "email": "ama@movegh.com"
}
```

Response:
```json
{
  "status": "updated"
}
```

## Rider: Deliveries

### POST /deliveries/request
Create a delivery request.

Request:
```json
{
  "pickup": "Makola Market",
  "dropoff": "Tema Station",
  "package_size": "Small",
  "notes": "Call on arrival"
}
```

Response:
```json
{
  "delivery_id": "delivery_001",
  "status": "requested",
  "amount": 18,
  "currency": "GHS"
}
```

### GET /deliveries/:deliveryId
Get current delivery status.

Response:
```json
{
  "delivery_id": "delivery_001",
  "status": "requested"
}
```

### POST /rides/:rideId/cancel
Cancel a ride.

Response:
```json
{
  "status": "cancelled"
}
```

### GET /pricing/estimate
Estimate fare.

Example:
`/pricing/estimate?pickup=Accra%20Mall&dropoff=Osu%20Oxford%20St&mode=car`

Response:
```json
{
  "currency": "GHS",
  "amount": 24,
  "distance_km": 5.4,
  "duration_min": 14
}
```

## Driver: Dispatch

### POST /drivers/status
Toggle driver availability.

Request:
```json
{
  "driver_id": "driver_001",
  "status": "online"
}
```

Response:
```json
{
  "status": "online"
}
```

### GET /drivers/requests
Poll for current ride request.

Response:
```json
{
  "requests": [
    {
      "request_id": "req_001",
      "pickup": "Osu Junction",
      "dropoff": "East Legon",
      "mode": "car",
      "notes": "Blue gate",
      "amount": 24,
      "currency": "GHS"
    }
  ]
}
```

### POST /drivers/requests/:id/accept
Accept a request.

Response:
```json
{
  "status": "accepted"
}
```

### POST /drivers/requests/:id/reject
Reject a request.

Response:
```json
{
  "status": "rejected"
}
```
