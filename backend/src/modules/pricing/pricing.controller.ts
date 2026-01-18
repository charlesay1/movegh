import { Controller, Get, Post, Patch, Body, Param, Query } from "@nestjs/common";
import { PricingService } from "./pricing.service";

@Controller("pricing")
export class PricingController {
  constructor(private readonly service: PricingService) {}

  @Get("estimate")
  estimate(@Query() query: Record<string, string>) {
    return this.service.stub("estimate");
  }

  @Get("regions")
  listRegions(@Query() query: Record<string, string>) {
    return this.service.stub("listRegions");
  }

}