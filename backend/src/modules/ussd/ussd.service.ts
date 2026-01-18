import { Injectable } from "@nestjs/common";

@Injectable()
export class UssdService {
  stub(action: string) {
    const responses: Record<string, unknown> = {
      session: {'status': 'ok', 'message': 'USSD session received'},
    };
    const response = responses[action];
    if (response) {
      return response;
    }
    return { module: "ussd", action, status: "ok" };
  }
}
