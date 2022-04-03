package rv.yatsyna.db.utils

import org.scalatest.funsuite.AnyFunSuite
import rv.yatsyna.db.config.{DbConfiguration, PostgresConfiguration}

import java.sql.{DriverManager, ResultSet}
import scala.util.{Failure, Success, Using}

trait DbScenario extends AnyFunSuite {
  private val dbConfiguration: DbConfiguration = new PostgresConfiguration()
  dbConfiguration.migrateDb()


  def executeQuery(query: String): ResultSet = {
    val set = Using(DriverManager.getConnection(dbConfiguration.dbUrl, dbConfiguration.dbUser, dbConfiguration.dbPassword)) {
      conn => conn.createStatement.executeQuery(query)
    }
    set match {
      case Success(resultSet) => resultSet
      case Failure(exception) => throw exception
    }
  }
}
