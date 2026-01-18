export interface Ride {
  id: string;
  userId: string;
  driverId?: string;
  pickupLocationId?: string;
  dropoffLocationId?: string;
  status: "requested" | "assigned" | "arrived" | "in_progress" | "completed" | "cancelled";
  fareAmount?: number;
  currency?: string;
  createdAt: string;
  updatedAt: string;
}
