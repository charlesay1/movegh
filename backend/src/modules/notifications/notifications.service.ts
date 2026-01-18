import { Injectable } from "@nestjs/common";

@Injectable()
export class NotificationsService {
  stub(action: string) {
    const responses: Record<string, unknown> = {
      sendPush: {'status': 'sent'},
    };
    const response = responses[action];
    if (response) {
      return response;
    }
    return { module: "notifications", action, status: "ok" };
  }
}
