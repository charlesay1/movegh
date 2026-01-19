import { Controller, Get, Post, Patch, Body, Param, Query } from "@nestjs/common";
import { RidesService } from "./rides.service";

@Controller("rides")
export class RidesController {
  constructor(private readonly service: RidesService) {}

  @Post()
  createRide(@Body() body: Record<string, unknown>) {
    return this.service.requestRide(body);
  }

  @Post("request")
  requestRide(@Body() body: Record<string, unknown>) {
    return this.service.requestRide(body);
  }

  @Post(":rideId/cancel")
  cancelRide(@Body() body: Record<string, unknown>, @Param() params: Record<string, string>) {
    return this.service.cancelRide();
  }

  @Post(":rideId/accept")
  acceptRide(@Body() body: Record<string, unknown>, @Param() params: Record<string, string>) {
    return this.service.acceptRide(params.rideId);
  }

  @Post(":rideId/start")
  startRide(@Body() body: Record<string, unknown>, @Param() params: Record<string, string>) {
    return this.service.startRide(params.rideId);
  }

  @Post(":rideId/complete")
  completeRide(@Body() body: Record<string, unknown>, @Param() params: Record<string, string>) {
    return this.service.completeRide(params.rideId);
  }

  @Get(":rideId")
  getRide(@Param() params: Record<string, string>, @Query() query: Record<string, string>) {
    return this.service.getRide(params.rideId);
  }

}
