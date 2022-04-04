package rv.yatsyna.db.config

import org.flywaydb.core.Flyway
import org.flywaydb.core.api.output.MigrateResult

class H2Configuration extends DbConfiguration {
  override val dbUrl: String = "jdbc:h2:mem:~/temp/test_db;DB_CLOSE_DELAY=-1"
  override val dbUser: String = "SA"
  override val dbPassword: String = ""

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
