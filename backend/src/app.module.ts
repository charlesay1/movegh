import { Module } from "@nestjs/common";
import { AppController } from "./app.controller";
import { AppService } from "./app.service";
import { AuthModule } from "./modules/auth/auth.module";
import { UsersModule } from "./modules/users/users.module";
import { DriversModule } from "./modules/drivers/drivers.module";
import { RidesModule } from "./modules/rides/rides.module";
import { DeliveriesModule } from "./modules/deliveries/deliveries.module";
import { PaymentsModule } from "./modules/payments/payments.module";
import { PricingModule } from "./modules/pricing/pricing.module";
import { RegionsModule } from "./modules/regions/regions.module";
import { BusinessModule } from "./modules/business/business.module";
import { AdminModule } from "./modules/admin/admin.module";
import { UssdModule } from "./modules/ussd/ussd.module";
import { NotificationsModule } from "./modules/notifications/notifications.module";
import { TrackingModule } from "./modules/tracking/tracking.module";

@Module({
  imports: [
    AuthModule,
    UsersModule,
    DriversModule,
    RidesModule,
    DeliveriesModule,
    PaymentsModule,
    PricingModule,
    RegionsModule,
    BusinessModule,
    AdminModule,
    UssdModule,
    NotificationsModule,
    TrackingModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
