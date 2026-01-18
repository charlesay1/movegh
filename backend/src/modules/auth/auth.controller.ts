import { Controller, Get, Post, Patch, Body, Param, Query } from "@nestjs/common";
import { AuthService } from "./auth.service";

@Controller("auth")
export class AuthController {
  constructor(private readonly service: AuthService) {}

  @Post("otp/request")
  requestOtp(@Body() body: Record<string, unknown>) {
    return this.service.stub("requestOtp");
  }

  @Post("otp/verify")
  verifyOtp(@Body() body: Record<string, unknown>) {
    return this.service.stub("verifyOtp");
  }

  @Post("refresh")
  refreshToken(@Body() body: Record<string, unknown>) {
    return this.service.stub("refreshToken");
  }

}