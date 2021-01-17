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
                .ignoreNumbersBiggerThan(1000)
                .filterNegativeNumbers()
                .sum()
        }
        return input.toInt()
    }

    private fun String.secondLine() = this.substring(this.indexOf("\n") + 1)

    private fun String.getDelimiters(): List<String>
    {
        var pattern: Pattern = Pattern.compile("""^//(.)\n""", Pattern.MULTILINE)
        var matcher: Matcher = pattern.matcher(this)
        val delimiters = mutableListOf<String>()
        if (matcher.find())
        {
            if (matcher.group(1).length == 1)
            {
                delimiters.add(matcher.group(1))
                return delimiters
            }
        }
        else
        {
            pattern = Pattern.compile("""\[(.*?)\]""", Pattern.MULTILINE)
            matcher = pattern.matcher(this)
            while (matcher.find())
            {
                delimiters.add(matcher.group(1))
            }
            return delimiters
        }
        return emptyList()
    }

    private fun String.usesCustomDelimiterSyntax() = this.startsWith("//")

    private fun String.hasTwoNumbers() = this.contains(",") || this.contains("\n")

    private fun String.extractNumbers(): List<Int>
    {
        val defaultDelimiters = listOf(",", "\n")
        val currentDelimiter = listOf(this.getDelimiters()).flatten().filter { it.isNotEmpty() }

        if (currentDelimiter.isEmpty())
        {
            return this.split(*defaultDelimiters.toTypedArray()).map { it.toInt() }
        }
        else
        {
            return this.secondLine().split(*currentDelimiter.toTypedArray()).map { it.toInt() }
        }
    }

    private fun List<Int>.filterNegativeNumbers() = apply {
        val negatives = this.filter { it < 0 }
        if (negatives.isNotEmpty())
            throw RuntimeException("negatives not allowed: ${negatives.joinToString(",")}")
    }

    private fun List<Int>.ignoreNumbersBiggerThan(number: Int) = this.filter { it <= number }
}

