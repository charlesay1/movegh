import { Injectable } from "@nestjs/common";

@Injectable()
export class PaymentsService {
  stub(action: string) {
    const responses: Record<string, unknown> = {
      charge: {'status': 'processing', 'reference': 'momo_ref_001'},
      intent: {'status': 'created', 'intent_id': 'intent_001'},
      momoCallback: {'status': 'received'},
      requestPayout: {'status': 'queued', 'payout_id': 'payout_001'},
      getWallet: {'balance': 320, 'currency': 'GHS'},
    };
    const response = responses[action];
    if (response) {
      return response;
    }
    return { module: "payments", action, status: "ok" };
  }
}
