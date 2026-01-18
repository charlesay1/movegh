import { Controller, Get, Post, Patch, Body, Param, Query } from "@nestjs/common";
import { BusinessService } from "./business.service";

@Controller("business")
export class BusinessController {
  constructor(private readonly service: BusinessService) {}

  @Post("signup")
  signup(@Body() body: Record<string, unknown>) {
    return this.service.stub("signup");
  }

  @Get("orders")
  listOrders(@Query() query: Record<string, string>) {
    return this.service.stub("listOrders");
  }

  @Post("orders/bulk")
  bulkOrder(@Body() body: Record<string, unknown>) {
    return this.service.stub("bulkOrder");
  }

  @Get("invoices")
  listInvoices(@Query() query: Record<string, string>) {
    return this.service.stub("listInvoices");
  }

}