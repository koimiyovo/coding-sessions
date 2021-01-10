import java.util.regex.Matcher
import java.util.regex.Pattern

object Calculator
{
    fun add(input: String): Int
    {
        if (input.isEmpty())
        {
            return 0
        }
        else if (input.usesCustomDelimiterSyntax() || input.hasTwoNumbers())
        {
            return input
                .extractNumbers()
                .filterNegativeNumbers()
                .sum()
        }
        return input.toInt()
    }

    private fun String.secondLine() = this.substring(this.indexOf("\n") + 1)

    private fun String.getDelimiter(): String
    {
        val pattern: Pattern = Pattern.compile("""^//(.)\n""", Pattern.MULTILINE)
        val matcher: Matcher = pattern.matcher(this)
        if (matcher.find())
        {
            return matcher.group(1)
        }
        return ""
    }

    private fun String.usesCustomDelimiterSyntax() = this.startsWith("//")

    private fun String.hasTwoNumbers() = this.contains(",") || this.contains("\n")

    private fun String.extractNumbers(): List<Int>
    {
        val defaultDelimiters = listOf(",", "\n")
        val currentDelimiter = listOf(this.getDelimiter()).filter { it.isNotEmpty() }

        if (currentDelimiter.isEmpty())
        {
            return this.split(*defaultDelimiters.toTypedArray()).map { it.toInt() }
        }
        else
        {
            return this.secondLine().split(*currentDelimiter.toTypedArray()).map { it.toInt() }
        }
    }

    private fun List<Int>.filterNegativeNumbers(): List<Int>
    {
        val negatives = this.filter { it < 0 }
        if (negatives.isNotEmpty())
            throw RuntimeException("negatives not allowed: ${negatives.joinToString(",")}")
        return this
    }
}

