import { Injectable } from "@nestjs/common";

@Injectable()
export class TrackingService {
  stub(action: string) {
    const responses: Record<string, unknown> = {
      updateDriverLocation: {'status': 'updated'},
      updateRideStatus: {'status': 'updated'},
      updateDeliveryStatus: {'status': 'updated'},
    };
    const response = responses[action];
    if (response) {
      return response;
    }
    return { module: "tracking", action, status: "ok" };
  }
}
