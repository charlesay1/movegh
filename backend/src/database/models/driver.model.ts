export interface Driver {
  id: string;
  userId: string;
  licenseNumber?: string;
  verificationStatus: "pending" | "approved" | "rejected";
  rating: number;
  vehicleType?: string;
  createdAt: string;
  updatedAt: string;
}
