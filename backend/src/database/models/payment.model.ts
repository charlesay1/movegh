export interface Payment {
  id: string;
  rideId?: string;
  userId?: string;
  amount: number;
  currency: string;
  method: "mtn_momo" | "vodafone_cash" | "airteltigo" | "cash";
  status: "pending" | "processing" | "completed" | "failed";
  reference?: string;
  createdAt: string;
}
