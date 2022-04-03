package rv.yatsyna.db.config

import org.flywaydb.core.Flyway
import org.flywaydb.core.api.output.MigrateResult

class PostgresConfiguration extends DbConfiguration {
  override val dbUrl = "jdbc:postgresql://127.0.0.1:5432/postgres"
  override val dbUser = "postgres"
  override val dbPassword = "changeme"

  // Create the Flyway instance and point it to the database
  lazy val flyway: Flyway = Flyway
    .configure
    .locations("classpath:/db/migration")
    .dataSource(dbUrl, dbUser, dbPassword)
    .load

  override def migrateDb(): MigrateResult = {
    flyway.clean()
    flyway.migrate
  }
}
