# API Contract (Driver MVP)

Base URL (local): `http://127.0.0.1:3000`

## Auth

### POST /auth/otp/request
Request:
```json
{ "phone": "+233240000000" }
```
Response:
```json
{ "status": "sent", "ttl_sec": 180 }
```

### POST /auth/otp/verify
Request:
```json
{ "phone": "+233240000000", "code": "1234" }
```
Response:
```json
{
  "status": "verified",
  "token": "mock_access_token",
  "refresh_token": "mock_refresh_token",
  "driver": { "id": "driver_001", "phone": "+233240000000", "name": "Driver Mensah" }
}
```

## Driver status + dispatch

### POST /drivers/status
Request:
```json
{ "online": true }
```
Response:
```json
{ "status": "ok", "online": true }
```

### GET /drivers/requests
Response:
```json
{
  "status": "ok",
  "request": {
    "id": "req_001",
    "pickup": "Osu Junction",
    "dropoff": "East Legon",
    "fare_ghs": 28.0,
    "eta_min": 6,
    "status": "pending"
  }
}
```

### POST /drivers/requests/:id/accept
Response:
```json
{ "status": "accepted", "request_id": "req_001" }
```

### POST /drivers/requests/:id/reject
Response:
```json
{ "status": "rejected", "request_id": "req_001" }
```
