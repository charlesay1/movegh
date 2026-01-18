CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  phone VARCHAR(32) UNIQUE NOT NULL,
  name VARCHAR(128) NOT NULL,
  role VARCHAR(24) NOT NULL DEFAULT 'rider',
  status VARCHAR(24) NOT NULL DEFAULT 'active',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE drivers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id),
  license_number VARCHAR(64),
  verification_status VARCHAR(24) NOT NULL DEFAULT 'pending',
  rating NUMERIC(3,2) DEFAULT 5.0,
  vehicle_type VARCHAR(32),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE locations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  label VARCHAR(128) NOT NULL,
  latitude NUMERIC(9,6) NOT NULL,
  longitude NUMERIC(9,6) NOT NULL,
  landmark VARCHAR(128),
  region_id VARCHAR(64),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE rides (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id),
  driver_id UUID REFERENCES drivers(id),
  pickup_location_id UUID REFERENCES locations(id),
  dropoff_location_id UUID REFERENCES locations(id),
  status VARCHAR(24) NOT NULL DEFAULT 'requested',
  fare_amount NUMERIC(10,2),
  currency VARCHAR(8) DEFAULT 'GHS',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE payments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  ride_id UUID REFERENCES rides(id),
  user_id UUID REFERENCES users(id),
  amount NUMERIC(10,2) NOT NULL,
  currency VARCHAR(8) DEFAULT 'GHS',
  method VARCHAR(32) NOT NULL,
  status VARCHAR(24) NOT NULL DEFAULT 'pending',
  reference VARCHAR(64),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_rides_status ON rides(status);
CREATE INDEX idx_rides_user_id ON rides(user_id);
CREATE INDEX idx_drivers_user_id ON drivers(user_id);
