import { Injectable } from "@nestjs/common";

@Injectable()
export class DriversService {
  stub(action: string) {
    const responses: Record<string, unknown> = {
      onboard: {'status': 'submitted', 'driver_id': 'driver_001'},
      getMe: {'id': 'driver_001', 'name': 'Kojo Mensah', 'rating': 4.9, 'vehicle': {'type': 'Car', 'plate': 'GR-1234-21'}},
      updateMe: {'status': 'updated'},
      addVehicle: {'status': 'added'},
      getEarnings: {'today': 180, 'week': 920, 'currency': 'GHS'},
      updateLocation: {'status': 'updated'},
      setStatus: {'status': 'online'},
      getRequests: {
        'requests': [
          {
            'request_id': 'req_001',
            'pickup': 'Osu Junction',
            'dropoff': 'East Legon',
            'mode': 'car',
            'notes': 'Blue gate',
            'amount': 24,
            'currency': 'GHS'
          }
        ]
      },
      acceptRequest: {'status': 'accepted'},
      rejectRequest: {'status': 'rejected'},
    };
    const response = responses[action];
    if (response) {
      return response;
    }
    return { module: "drivers", action, status: "ok" };
  }
}
