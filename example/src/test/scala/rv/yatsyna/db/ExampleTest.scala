package rv.yatsyna.db

import org.scalatest.funsuite.AnyFunSuite
import org.scalatest.matchers.should.Matchers.convertToAnyShouldWrapper

class ExampleTest extends AnyFunSuite {
  test("Simple Calculator addition test") {
    val result = Calculator.add(1, 4)
    result shouldBe 5
  }

}
