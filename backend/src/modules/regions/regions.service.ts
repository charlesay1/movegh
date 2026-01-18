import { Injectable } from "@nestjs/common";
import { landmarks, regions } from "../../common/sample-data";

@Injectable()
export class RegionsService {
  listRegions() {
    return { regions };
  }

  listLandmarks() {
    return {
      region_id: "greater-accra",
      landmarks: landmarks["greater-accra"] ?? [],
    };
  }

  stub(action: string) {
    switch (action) {
      case "listRegions":
        return this.listRegions();
      case "listLandmarks":
        return this.listLandmarks();
      default:
        return { module: "regions", action, status: "ok" };
    }
  }
}
