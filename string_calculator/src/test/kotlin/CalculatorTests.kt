import org.junit.jupiter.api.Test
import org.junit.jupiter.api.assertAll
import org.junit.jupiter.api.assertThrows
import kotlin.test.assertEquals

class CalculatorTests
{
    @Test
    fun `given empty input when add then get 0`()
    {
        assertEquals(0, Calculator.add(""))
    }

    @Test
    fun `given one number when add then get number`()
    {
        assertAll(
            { assertEquals(1, Calculator.add("1")) },
            { assertEquals(2, Calculator.add("2")) }
        )
    }

    @Test
    fun `given two numbers separated by comma when add then get sum of numbers`()
    {
        assertAll(
            { assertEquals(3, Calculator.add("1,2")) },
            { assertEquals(7, Calculator.add("3,4")) }
        )
    }

    @Test
    fun `given three numbers separated by comma when add then get sum of numbers`()
    {
        assertAll(
            { assertEquals(6, Calculator.add("1,2,3")) },
            { assertEquals(38, Calculator.add("10,13,15")) },
        )
    }

    @Test
    fun `given numbers separated by new lines when add then get sum of numbers`()
    {
        assertAll(
            { assertEquals(3, Calculator.add("1\n2")) },
            { assertEquals(40, Calculator.add("15\n20\n5")) },
        )
    }

    @Test
    fun `given numbers separated by new lines and commas when add then get sum of numbers`()
    {
        assertAll(
            { assertEquals(6, Calculator.add("1\n2,3")) },
            { assertEquals(10, Calculator.add("1\n2,3\n4")) },
        )
    }

    @Test
    fun `should support custom delimiters`()
    {
        assertAll(
            { assertEquals(3, Calculator.add("//;\n1;2")) },
            { assertEquals(33, Calculator.add("//;\n1;2;30")) }
        )
    }

    @Test
    fun `should throw exception on negative numbers`()
    {
        assertThrows<RuntimeException> {
            Calculator.add("1,-2")
        }.run {
            assertEquals("negatives not allowed: -2", message)
        }
    }
}
