const BASE_URL = "http://localhost:3000/v1";

async function request(path, options = {}) {
  const res = await fetch(`${BASE_URL}${path}`, {
    headers: { "Content-Type": "application/json" },
    ...options,
  });
  return res;
}

async function runTest(name, fn) {
  try {
    const result = await fn();
    console.log(`[PASS] ${name}${result ? ` - ${result}` : ""}`);
  } catch (error) {
    console.log(`[FAIL] ${name} - ${error.message}`);
  }
}

async function run() {
  await runTest("health", async () => {
    const res = await request("/health");
    if (!res.ok) {
      throw new Error(`HTTP ${res.status}`);
    }
  });

  await runTest("otp request", async () => {
    const res = await request("/auth/otp/request", {
      method: "POST",
      body: JSON.stringify({ phone: "+233240000000" }),
    });
    if (!res.ok) {
      throw new Error(`HTTP ${res.status}`);
    }
  });

  console.log("[SKIP] otp verify (needs real OTP)");

  await runTest("ride request", async () => {
    const res = await request("/rides", {
      method: "POST",
      body: JSON.stringify({
        pickup: "Osu Junction",
        dropoff: "East Legon",
        mode: "car",
        notes: "Smoke test",
      }),
    });
    if (!res.ok) {
      throw new Error(`HTTP ${res.status}`);
    }
  });

  await runTest("driver requests", async () => {
    const res = await request("/drivers/requests");
    if (!res.ok) {
      throw new Error(`HTTP ${res.status}`);
    }
  });
}

run().catch((error) => {
  console.error(`[FAIL] smoke_test - ${error.message}`);
  process.exit(1);
});
