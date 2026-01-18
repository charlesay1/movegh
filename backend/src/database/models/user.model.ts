export interface User {
  id: string;
  phone: string;
  name: string;
  role: "rider" | "driver" | "business" | "admin";
  status: "active" | "suspended";
  createdAt: string;
  updatedAt: string;
}
