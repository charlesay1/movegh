# MoveGH Ride Flow API (MVP)

Base URL: `/v1`

## Create Ride
POST `/rides`

Request body
```
{
  "pickup": "Osu Junction",
  "dropoff": "East Legon",
  "mode": "car"
}
```

Response
```
{
  "ride_id": "ride_001",
  "status": "requested",
  "amount": 24,
  "currency": "GHS"
}
```

## Get Ride Status
GET `/rides/{id}`

Response
```
{
  "ride_id": "ride_001",
  "status": "assigned",
  "driver": {
    "name": "Kojo Mensah",
    "rating": 4.9
  },
  "eta_min": 4
}
```

## Cancel Ride
POST `/rides/{id}/cancel`

Response
```
{
  "status": "cancelled"
}
```

## Optional Endpoints
POST `/drivers/{id}/location`

Request body
```
{ "latitude": 5.6037, "longitude": -0.1870 }
```

POST `/payments/intent`

Request body
```
{ "amount": 24, "currency": "GHS", "method": "mtn_momo" }
```
