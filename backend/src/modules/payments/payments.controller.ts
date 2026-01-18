import { Controller, Get, Post, Patch, Body, Param, Query } from "@nestjs/common";
import { PaymentsService } from "./payments.service";

@Controller()
export class PaymentsController {
  constructor(private readonly service: PaymentsService) {}

  @Post("payments/charge")
  charge(@Body() body: Record<string, unknown>) {
    return this.service.stub("charge");
  }

  @Post("payments/intent")
  intent(@Body() body: Record<string, unknown>) {
    return this.service.stub("intent");
  }

  @Post("payments/momo/callback")
  momoCallback(@Body() body: Record<string, unknown>) {
    return this.service.stub("momoCallback");
  }

  @Post("payouts/request")
  requestPayout(@Body() body: Record<string, unknown>) {
    return this.service.stub("requestPayout");
  }

  @Get("wallets/me")
  getWallet(@Query() query: Record<string, string>) {
    return this.service.stub("getWallet");
  }

}
