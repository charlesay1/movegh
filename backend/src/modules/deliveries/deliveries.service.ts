import { Injectable } from "@nestjs/common";

@Injectable()
export class DeliveriesService {
  stub(action: string) {
    const responses: Record<string, unknown> = {
      requestDelivery: {'delivery_id': 'delivery_001', 'status': 'requested', 'amount': 18, 'currency': 'GHS'},
      cancelDelivery: {'status': 'cancelled'},
      acceptDelivery: {'status': 'accepted'},
      pickupDelivery: {'status': 'picked_up'},
      completeDelivery: {'status': 'completed'},
      getDelivery: {'delivery_id': 'delivery_001', 'status': 'in_transit'},
    };
    const response = responses[action];
    if (response) {
      return response;
    }
    return { module: "deliveries", action, status: "ok" };
  }
}
