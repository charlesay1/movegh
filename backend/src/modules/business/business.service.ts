import { Injectable } from "@nestjs/common";

@Injectable()
export class BusinessService {
  stub(action: string) {
    const responses: Record<string, unknown> = {
      signup: {'status': 'created', 'business_id': 'biz_001'},
      listOrders: {'orders': [{'id': 'order_001', 'status': 'in_transit'}]},
      bulkOrder: {'status': 'queued', 'batch_id': 'bulk_001'},
      listInvoices: {'invoices': [{'id': 'inv_001', 'amount': 8420, 'currency': 'GHS'}]},
    };
    const response = responses[action];
    if (response) {
      return response;
    }
    return { module: "business", action, status: "ok" };
  }
}
