import { Injectable } from "@nestjs/common";

@Injectable()
export class UsersService {
  stub(action: string) {
    const responses: Record<string, unknown> = {
      getMe: {'id': 'user_001', 'name': 'Yaw Mensah', 'phone': '+233240000000'},
      updateMe: {'status': 'updated'},
      getTrips: {'trips': [{'id': 'ride_001', 'type': 'ride', 'status': 'completed', 'amount': 24, 'currency': 'GHS'}, {'id': 'delivery_001', 'type': 'delivery', 'status': 'completed', 'amount': 18, 'currency': 'GHS'}]},
    };
    const response = responses[action];
    if (response) {
      return response;
    }
    return { module: "users", action, status: "ok" };
  }
}
