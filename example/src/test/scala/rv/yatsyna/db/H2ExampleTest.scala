package rv.yatsyna.db

import org.scalatest.matchers.should.Matchers.convertToAnyShouldWrapper
import rv.yatsyna.db.utils.{DataBases, DbScenario}

class H2ExampleTest extends DbScenario(DataBases.H2) {

  test("Person with the ID 1 should be Forrest Gump") {
    val sql =
      """
        |SELECT FIRST_NAME, LAST_NAME FROM PERSON
        |WHERE ID = 2;
        |""".stripMargin
    val resultSet = executeQuery(sql)
    resultSet.next
    val firstName = resultSet.getString(1)
    val lastName = resultSet.getString(2)
    firstName shouldBe "Jeffrey"
    lastName shouldBe "Lebowski"
  }
}
