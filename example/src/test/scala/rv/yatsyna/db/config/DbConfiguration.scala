package rv.yatsyna.db.config

import org.flywaydb.core.api.output.MigrateResult

trait DbConfiguration {
  val dbUrl: String
  val dbUser: String
  val dbPassword: String

  def migrateDb(): MigrateResult
}
