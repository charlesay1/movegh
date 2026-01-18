import { Injectable } from "@nestjs/common";
import { regions } from "../../common/sample-data";

@Injectable()
export class PricingService {
  estimate() {
    return {
      currency: "GHS",
      amount: 24,
      distance_km: 5.4,
      duration_min: 14,
      breakdown: {
        base: 5,
        distance: 12,
        time: 7,
      },
    };
  }

  listRegions() {
    return { regions };
  }

  stub(action: string) {
    switch (action) {
      case "estimate":
        return this.estimate();
      case "listRegions":
        return this.listRegions();
      default:
        return { module: "pricing", action, status: "ok" };
    }
  }
}
