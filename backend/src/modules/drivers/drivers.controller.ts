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

  @Post("status")
  setStatus(@Body() body: Record<string, unknown>) {
    const status = body["status"];
    return this.service.setStatus(status === "online");
  }

  @Get("requests")
  getRequests(@Query() query: Record<string, string>) {
    return this.service.getRequests();
  }

  @Get("requests/:requestId")
  getRequest(@Param() params: Record<string, string>) {
    return this.service.getRequest(params.requestId);
  }

  @Post("requests/:requestId/accept")
  acceptRequest(@Param() params: Record<string, string>) {
    return this.service.acceptRequest(params.requestId);
  }

  @Post("requests/:requestId/reject")
  rejectRequest(@Param() params: Record<string, string>) {
    return this.service.rejectRequest(params.requestId);
  }

  @Post("requests/:requestId/arrive")
  arriveRequest(@Param() params: Record<string, string>) {
    return this.service.arriveRequest(params.requestId);
  }

  @Post("requests/:requestId/start")
  startTrip(@Param() params: Record<string, string>) {
    return this.service.startTrip(params.requestId);
  }

  @Post("requests/:requestId/complete")
  completeTrip(@Param() params: Record<string, string>) {
    return this.service.completeTrip(params.requestId);
  }

}
