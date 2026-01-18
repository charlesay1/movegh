import { Injectable } from "@nestjs/common";

@Injectable()
export class AuthService {
  stub(action: string) {
    const responses: Record<string, unknown> = {
      requestOtp: {'status': 'sent', 'ttl_sec': 180},
      verifyOtp: {'status': 'verified', 'token': 'mock_access_token', 'refresh_token': 'mock_refresh_token', 'user': {'id': 'user_001', 'phone': '+233240000000', 'name': 'Yaw Mensah'}},
      refreshToken: {'status': 'refreshed', 'token': 'mock_access_token', 'refresh_token': 'mock_refresh_token'},
    };
    const response = responses[action];
    if (response) {
      return response;
    }
    return { module: "auth", action, status: "ok" };
  }
}
