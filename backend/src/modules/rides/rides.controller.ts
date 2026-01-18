import { Controller, Get, Post, Patch, Body, Param, Query } from "@nestjs/common";
import { RidesService } from "./rides.service";

@Controller("rides")
export class RidesController {
  constructor(private readonly service: RidesService) {}

  @Post()
  createRide(@Body() body: Record<string, unknown>) {
    return this.service.stub("createRide");
  }

  @Post("request")
  requestRide(@Body() body: Record<string, unknown>) {
    return this.service.stub("createRide");
  }

  @Post(":rideId/cancel")
  cancelRide(@Body() body: Record<string, unknown>, @Param() params: Record<string, string>) {
    return this.service.stub("cancelRide");
  }

  @Post(":rideId/accept")
  acceptRide(@Body() body: Record<string, unknown>, @Param() params: Record<string, string>) {
    return this.service.stub("acceptRide");
  }

  @Post(":rideId/start")
  startRide(@Body() body: Record<string, unknown>, @Param() params: Record<string, string>) {
    return this.service.stub("startRide");
  }

  @Post(":rideId/complete")
  completeRide(@Body() body: Record<string, unknown>, @Param() params: Record<string, string>) {
    return this.service.stub("completeRide");
  }

  @Get(":rideId")
  getRide(@Param() params: Record<string, string>, @Query() query: Record<string, string>) {
    return this.service.stub("getRide");
  }

}
