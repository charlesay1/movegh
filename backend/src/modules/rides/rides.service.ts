import { Injectable } from "@nestjs/common";

@Injectable()
export class RidesService {
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
}
