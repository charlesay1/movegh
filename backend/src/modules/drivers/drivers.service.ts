import { Injectable } from "@nestjs/common";

type DriverRequest = {
  id: string;
  pickup: string;
  dropoff: string;
  fare_ghs: number;
  eta_min: number;
  status: "pending" | "accepted" | "rejected";
};

@Injectable()
export class DriversService {
  private currentRequest: DriverRequest | null = {
    id: "req_001",
    pickup: "Osu Junction",
    dropoff: "East Legon",
    fare_ghs: 28.0,
    eta_min: 6,
    status: "pending",
  };
  private online = false;

  stub(action: string) {
    const responses: Record<string, unknown> = {
      onboard: {'status': 'submitted', 'driver_id': 'driver_001'},
      getMe: {'id': 'driver_001', 'name': 'Kojo Mensah', 'rating': 4.9, 'vehicle': {'type': 'Car', 'plate': 'GR-1234-21'}},
      updateMe: {'status': 'updated'},
      addVehicle: {'status': 'added'},
      getEarnings: {'today': 180, 'week': 920, 'currency': 'GHS'},
      updateLocation: {'status': 'updated'},
    };
    const response = responses[action];
    if (response) {
      return response;
    }
    return { module: "drivers", action, status: "ok" };
  }

  setStatus(payload: { online?: boolean }) {
    this.online = Boolean(payload.online);
    if (!this.online) {
      this.currentRequest = null;
    } else if (!this.currentRequest) {
      this.currentRequest = {
        id: "req_001",
        pickup: "Osu Junction",
        dropoff: "East Legon",
        fare_ghs: 28.0,
        eta_min: 6,
        status: "pending",
      };
    }
    return { status: "ok", online: this.online };
  }

  getRequests() {
    return { status: "ok", request: this.online ? this.currentRequest : null };
  }

  acceptRequest(requestId: string) {
    if (this.currentRequest && this.currentRequest.id === requestId) {
      this.currentRequest = { ...this.currentRequest, status: "accepted" };
    }
    const request = this.currentRequest;
    this.currentRequest = null;
    return { status: "accepted", request_id: requestId, request };
  }

  rejectRequest(requestId: string) {
    if (this.currentRequest && this.currentRequest.id === requestId) {
      this.currentRequest = { ...this.currentRequest, status: "rejected" };
    }
    const request = this.currentRequest;
    this.currentRequest = null;
    return { status: "rejected", request_id: requestId, request };
  }
}
