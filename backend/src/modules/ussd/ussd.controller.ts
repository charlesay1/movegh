import { Controller, Get, Post, Patch, Body, Param, Query } from "@nestjs/common";
import { UssdService } from "./ussd.service";

@Controller("ussd")
export class UssdController {
  constructor(private readonly service: UssdService) {}

  @Post("session")
  session(@Body() body: Record<string, unknown>) {
    return this.service.stub("session");
  }

}