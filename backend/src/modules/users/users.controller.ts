import { Controller, Get, Post, Patch, Body, Param, Query } from "@nestjs/common";
import { UsersService } from "./users.service";

@Controller("users")
export class UsersController {
  constructor(private readonly service: UsersService) {}

  @Get("me")
  getMe(@Query() query: Record<string, string>) {
    return this.service.stub("getMe");
  }

  @Patch("me")
  updateMe(@Body() body: Record<string, unknown>) {
    return this.service.stub("updateMe");
  }

  @Get("me/trips")
  getTrips(@Query() query: Record<string, string>) {
    return this.service.stub("getTrips");
  }

}