import { Injectable } from "@nestjs/common";

type DriverRequest = {
  request_id: string;
  pickup: string;
  dropoff: string;
  mode: string;
  notes?: string;
  amount: number;
  currency: string;
  status: "pending" | "assigned" | "arrived" | "in_trip" | "completed" | "rejected";
};

@Injectable()
export class DriversService {
  private readonly requests = new Map<string, DriverRequest>();

  private ensureSeed() {
    if (this.requests.size > 0) {
      return;
    }
    this.requests.set("req_001", {
      request_id: "req_001",
      pickup: "Osu Junction",
      dropoff: "East Legon",
      mode: "car",
      notes: "Blue gate",
      amount: 24,
      currency: "GHS",
      status: "pending",
    });
  }

  stub(action: string) {
    const responses: Record<string, unknown> = {
      onboard: { status: "submitted", driver_id: "driver_001" },
      getMe: {
        id: "driver_001",
        name: "Kojo Mensah",
        rating: 4.9,
        vehicle: { type: "Car", plate: "GR-1234-21" },
      },
      updateMe: { status: "updated" },
      addVehicle: { status: "added" },
      getEarnings: { today: 180, week: 920, currency: "GHS" },
      updateLocation: { status: "updated" },
    };
    const response = responses[action];
    if (response) {
      return response;
    }
    return { module: "drivers", action, status: "ok" };
  }

  setStatus(online: boolean) {
    return { status: online ? "online" : "offline" };
  }

  getRequests() {
    this.ensureSeed();
    return {
      requests: Array.from(this.requests.values()).filter(
        (request) => request.status !== "rejected" && request.status !== "completed",
      ),
    };
  }

  getRequest(requestId: string) {
    this.ensureSeed();
    return this.requests.get(requestId) ?? {
      request_id: requestId,
      status: "pending",
    };
  }

  acceptRequest(requestId: string) {
    const request = this.getRequest(requestId) as DriverRequest;
    if (request?.request_id) {
      request.status = "assigned";
      this.requests.set(requestId, request);
    }
    return { status: "accepted", request_id: requestId };
  }

  rejectRequest(requestId: string) {
    const request = this.getRequest(requestId) as DriverRequest;
    if (request?.request_id) {
      request.status = "rejected";
      this.requests.set(requestId, request);
    }
    return { status: "rejected", request_id: requestId };
  }

  arriveRequest(requestId: string) {
    const request = this.getRequest(requestId) as DriverRequest;
    if (request?.request_id) {
      request.status = "arrived";
      this.requests.set(requestId, request);
    }
    return { status: "arrived", request_id: requestId };
  }

  startTrip(requestId: string) {
    const request = this.getRequest(requestId) as DriverRequest;
    if (request?.request_id) {
      request.status = "in_trip";
      this.requests.set(requestId, request);
    }
    return { status: "in_trip", request_id: requestId };
  }

  completeTrip(requestId: string) {
    const request = this.getRequest(requestId) as DriverRequest;
    if (request?.request_id) {
      request.status = "completed";
      this.requests.set(requestId, request);
    }
    return { status: "completed", request_id: requestId };
  }
}
