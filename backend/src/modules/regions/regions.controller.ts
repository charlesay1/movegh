import { Controller, Get, Post, Patch, Body, Param, Query } from "@nestjs/common";
import { RegionsService } from "./regions.service";

@Controller("regions")
export class RegionsController {
  constructor(private readonly service: RegionsService) {}

  @Get()
  listRegions(@Query() query: Record<string, string>) {
    return this.service.stub("listRegions");
  }

  @Get(":regionId/landmarks")
  listLandmarks(@Param() params: Record<string, string>, @Query() query: Record<string, string>) {
    return this.service.stub("listLandmarks");
  }

}