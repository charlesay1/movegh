import { Controller, Get, Post, Patch, Body, Param, Query } from "@nestjs/common";
import { DeliveriesService } from "./deliveries.service";

@Controller("deliveries")
export class DeliveriesController {
  constructor(private readonly service: DeliveriesService) {}

  @Post("request")
  requestDelivery(@Body() body: Record<string, unknown>) {
    return this.service.stub("requestDelivery");
  }

  @Post(":deliveryId/cancel")
  cancelDelivery(@Body() body: Record<string, unknown>, @Param() params: Record<string, string>) {
    return this.service.stub("cancelDelivery");
  }

  @Post(":deliveryId/accept")
  acceptDelivery(@Body() body: Record<string, unknown>, @Param() params: Record<string, string>) {
    return this.service.stub("acceptDelivery");
  }

  @Post(":deliveryId/pickup")
  pickupDelivery(@Body() body: Record<string, unknown>, @Param() params: Record<string, string>) {
    return this.service.stub("pickupDelivery");
  }

  @Post(":deliveryId/complete")
  completeDelivery(@Body() body: Record<string, unknown>, @Param() params: Record<string, string>) {
    return this.service.stub("completeDelivery");
  }

  @Get(":deliveryId")
  getDelivery(@Param() params: Record<string, string>, @Query() query: Record<string, string>) {
    return this.service.stub("getDelivery");
  }

}