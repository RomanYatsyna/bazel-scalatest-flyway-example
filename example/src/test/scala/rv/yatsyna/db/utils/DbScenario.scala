package rv.yatsyna.db.utils

import org.scalatest.BeforeAndAfterAll
import org.scalatest.funsuite.AnyFunSuite
import rv.yatsyna.db.config.{DbConfiguration, H2Configuration, PostgresConfiguration}

import java.sql.{DriverManager, ResultSet}

class DbScenario(dataBaseType: DataBases.DbType) extends AnyFunSuite with BeforeAndAfterAll {

  private val dbConfiguration: DbConfiguration = dataBaseType match {
    case DataBases.POSTGRES => new PostgresConfiguration()
    case DataBases.H2 => new H2Configuration()
  }

  private val connection = DriverManager.getConnection(dbConfiguration.dbUrl, dbConfiguration.dbUser, dbConfiguration.dbPassword)

  dbConfiguration.migrateDb()

  override protected def afterAll(): Unit = {
    connection.close()
  }

  def executeQuery(query: String): ResultSet = {
    connection.createStatement.executeQuery(query)
  }
}

object DataBases extends Enumeration {
  type DbType = Value
  val POSTGRES, H2 = Value
}