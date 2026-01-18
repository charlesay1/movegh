import { Controller, Get, Post, Patch, Body, Param, Query } from "@nestjs/common";
import { AdminService } from "./admin.service";

@Controller("admin")
export class AdminController {
  constructor(private readonly service: AdminService) {}

  @Get("drivers/pending")
  listPendingDrivers(@Query() query: Record<string, string>) {
    return this.service.stub("listPendingDrivers");
  }

  @Post("drivers/:driverId/approve")
  approveDriver(@Body() body: Record<string, unknown>, @Param() params: Record<string, string>) {
    return this.service.stub("approveDriver");
  }

  @Post("pricing/regions")
  updatePricing(@Body() body: Record<string, unknown>) {
    return this.service.stub("updatePricing");
  }

  @Post("disputes/:disputeId/resolve")
  resolveDispute(@Body() body: Record<string, unknown>, @Param() params: Record<string, string>) {
    return this.service.stub("resolveDispute");
  }

}