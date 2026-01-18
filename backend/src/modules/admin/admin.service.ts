import { Injectable } from "@nestjs/common";

@Injectable()
export class AdminService {
  stub(action: string) {
    const responses: Record<string, unknown> = {
      listPendingDrivers: {'pending': 128},
      approveDriver: {'status': 'approved', 'driver_id': 'driver_001'},
      updatePricing: {'status': 'updated'},
      resolveDispute: {'status': 'resolved'},
    };
    const response = responses[action];
    if (response) {
      return response;
    }
    return { module: "admin", action, status: "ok" };
  }
}
