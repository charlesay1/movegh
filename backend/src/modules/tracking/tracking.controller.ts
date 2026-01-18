import { Controller, Get, Post, Patch, Body, Param, Query } from "@nestjs/common";
import { TrackingService } from "./tracking.service";

@Controller("tracking")
export class TrackingController {
  constructor(private readonly service: TrackingService) {}

  @Post("driver-location")
  updateDriverLocation(@Body() body: Record<string, unknown>) {
    return this.service.stub("updateDriverLocation");
  }

  @Post("ride-status")
  updateRideStatus(@Body() body: Record<string, unknown>) {
    return this.service.stub("updateRideStatus");
  }

  @Post("delivery-status")
  updateDeliveryStatus(@Body() body: Record<string, unknown>) {
    return this.service.stub("updateDeliveryStatus");
  }

}