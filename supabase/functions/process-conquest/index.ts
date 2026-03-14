import "edge-runtime";
import { createClient } from "supabase";

Deno.serve(async (req: Request) => {
  try {
    const payload = await req.json();

    // Quando um Webhook do BD dispara por INSERT na tabela runs, ele envia "record" no payload.
    // Ou se a chamada for manual via HTTP, a gente extrai o run_id do body.
    const runId = payload.record?.id || payload.run_id;

    if (!runId) {
      return new Response(JSON.stringify({ error: "No run_id provided in the payload" }), {
        status: 400,
        headers: { "Content-Type": "application/json", "Connection": "keep-alive" },
      });
    }

    console.log(`Processing conquest for run: ${runId}`);

    // Create a Supabase client with the Auth context of the user or Service Role Keys
    const supabaseUrl = Deno.env.get("SUPABASE_URL") ?? "";
    const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "";
    const supabase = createClient(supabaseUrl, supabaseServiceKey);

    // Chama a função PostGIS (RPC) instalada via migration
    const { data: result, error } = await supabase.rpc("process_run_territory", {
      p_run_id: runId,
    });

    if (error) {
      console.error("Error processing territory:", error);
      return new Response(JSON.stringify({ error: error.message }), {
        status: 500,
        headers: { "Content-Type": "application/json", "Connection": "keep-alive" },
      });
    }

    console.log("Process conquest result:", result);

    // Aqui seria o lugar ideal para chamar APIs externas (Webhooks) como Firebase (FCM) 
    // ou OneSignal para enviar a Push Notification aos usuários impactados (notified_users).
    /*
    const impactUsers = result.notified_users || [];
    for(const userId of impactUsers) {
      await fetch("https://onesignal.com/api/v1/notifications", { ... })
    }
    */

    return new Response(JSON.stringify({ success: true, result }), {
      headers: { "Content-Type": "application/json", "Connection": "keep-alive" },
    });
  } catch (err) {
    return new Response(JSON.stringify({ error: err instanceof Error ? err.message : String(err) }), {
      status: 400,
      headers: { "Content-Type": "application/json", "Connection": "keep-alive" },
    });
  }
});
