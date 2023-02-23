import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :conduit, Conduit.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: 5470,
  database: "conduit_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# Configure the event store database
config :conduit, Conduit.EventStore,
  serializer: EventStore.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "conduit_eventstore_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  port: 5470

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :conduit, ConduitWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "wKAoIujwB9HRcWjiDwmptpCLDdkaeko9SLUNE4aZ/fckeDhPYUJxIfTrOb66MO4J",
  server: false

# In test we don't send emails.
config :conduit, Conduit.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
