import { Controller, Get, Post, Patch, Body, Param, Query } from "@nestjs/common";
import { NotificationsService } from "./notifications.service";

@Controller("notifications")
export class NotificationsController {
  constructor(private readonly service: NotificationsService) {}

  @Post("push")
  sendPush(@Body() body: Record<string, unknown>) {
    return this.service.stub("sendPush");
  }

}