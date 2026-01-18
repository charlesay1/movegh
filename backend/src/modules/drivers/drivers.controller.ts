import { Controller, Get, Post, Patch, Body, Param, Query } from "@nestjs/common";
import { DriversService } from "./drivers.service";

@Controller("drivers")
export class DriversController {
  constructor(private readonly service: DriversService) {}

  @Post("onboard")
  onboard(@Body() body: Record<string, unknown>) {
    return this.service.stub("onboard");
  }

  @Get("me")
  getMe(@Query() query: Record<string, string>) {
    return this.service.stub("getMe");
  }

  @Patch("me")
  updateMe(@Body() body: Record<string, unknown>) {
    return this.service.stub("updateMe");
  }

  @Post("vehicles")
  addVehicle(@Body() body: Record<string, unknown>) {
    return this.service.stub("addVehicle");
  }

  @Get("earnings")
  getEarnings(@Query() query: Record<string, string>) {
    return this.service.stub("getEarnings");
  }

  @Post(":driverId/location")
  updateLocation(@Body() body: Record<string, unknown>, @Param() params: Record<string, string>) {
    return this.service.stub("updateLocation");
  }

}
