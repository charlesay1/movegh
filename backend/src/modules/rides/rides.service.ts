import { Injectable } from "@nestjs/common";

type RideStatus = "requested" | "assigned" | "in_progress" | "completed" | "cancelled";

type RideRecord = {
  ride_id: string;
  pickup?: string;
  dropoff?: string;
  status: RideStatus;
  amount: number;
  currency: string;
  driver?: { name: string; rating: number };
  eta_min?: number;
};

@Injectable()
export class RidesService {
  private currentRide: RideRecord | null = null;
  private pollCount = 0;

  stub(action: string) {
    const responses: Record<string, unknown> = {
      createRide: {"ride_id": "ride_001", "status": "requested", "amount": 24, "currency": "GHS"},
      requestRide: {"ride_id": "ride_001", "status": "requested", "amount": 24, "currency": "GHS"},
      cancelRide: {'status': 'cancelled'},
      acceptRide: {'status': 'accepted'},
      startRide: {'status': 'in_progress'},
      completeRide: {'status': 'completed', 'amount': 24, 'currency': 'GHS'},
      getRide: {"ride_id": "ride_001", "status": "assigned", "driver": {"name": "Kojo Mensah", "rating": 4.9}, "eta_min": 4},
    };
    const response = responses[action];
    if (response) {
      return response;
    }
    return { module: "rides", action, status: "ok" };
  }

  requestRide(payload: Record<string, unknown>) {
    const pickup = payload["pickup"];
    const dropoff = payload["dropoff"];
    const ride: RideRecord = {
      ride_id: "ride_001",
      pickup: pickup != null ? String(pickup) : undefined,
      dropoff: dropoff != null ? String(dropoff) : undefined,
      status: "requested",
      amount: 24,
      currency: "GHS",
    };
    this.currentRide = ride;
    this.pollCount = 0;
    return ride;
  }

  getRide(rideId: string) {
    if (!this.currentRide || this.currentRide.ride_id !== rideId) {
      return { ride_id: rideId, status: "requested" };
    }
    this.pollCount += 1;
    if (this.currentRide.status === "requested" && this.pollCount >= 2) {
      this.currentRide.status = "assigned";
      this.currentRide.driver = { name: "Kojo Mensah", rating: 4.9 };
      this.currentRide.eta_min = 4;
    } else if (this.currentRide.status === "assigned" && this.pollCount >= 4) {
      this.currentRide.status = "in_progress";
    } else if (this.currentRide.status === "in_progress" && this.pollCount >= 6) {
      this.currentRide.status = "completed";
      this.currentRide.eta_min = 0;
    }
    return this.currentRide;
  }

  cancelRide() {
    if (this.currentRide) {
      this.currentRide.status = "cancelled";
    }
    return { status: "cancelled" };
  }

  acceptRide(rideId: string) {
    if (this.currentRide && this.currentRide.ride_id === rideId) {
      this.currentRide.status = "assigned";
    }
    return { status: "accepted" };
  }

  startRide(rideId: string) {
    if (this.currentRide && this.currentRide.ride_id === rideId) {
      this.currentRide.status = "in_progress";
    }
    return { status: "in_progress" };
  }

  completeRide(rideId: string) {
    if (this.currentRide && this.currentRide.ride_id === rideId) {
      this.currentRide.status = "completed";
    }
    return { status: "completed", amount: 24, currency: "GHS" };
  }
}
