import kotlin.math.absoluteValue
import kotlin.math.sign
import kotlin.test.assertEquals
import kotlin.test.assertFailsWith

// 1-28. Write a function to perform integer division without using either the / or * operators. Find a fast way to do it.
fun divide(m: Int, n: Int): Int {
    if (n == 0) {
        throw ArithmeticException("/ divide 0")
    }
    if (m.absoluteValue < n.absoluteValue) {
        return 0
    }
    val sign = m.sign == n.sign
    val step = n.absoluteValue
    return if (step == 1) {
        if (sign) m.absoluteValue else -m.absoluteValue
    } else if (step % 2 == 0) {
        divide(m.shr(1), n.shr(1))
    } else {
        divide(m + n - 1, n + 1)
    }
}

private fun testDivide() {
    assertEquals(0/2, divide(0, 2))
    assertEquals(6/1, divide(6, 1))
    assertEquals(6/2, divide(6, 2))
    assertEquals(6/3, divide(6, 3))
    assertEquals(6/4, divide(6, 4))
    assertEquals(6/5, divide(6, 5))
    assertEquals(6/6, divide(6, 6))
    assertEquals(6/7, divide(6, 7))
    assertEquals(6/1234567, divide(6, 1234567))
    assertEquals(6/-2, divide(6, -2))
    assertFailsWith(ArithmeticException::class) {
        divide(6, 0)
    }
}

fun main(args: Array<String>) {
    testDivide()
}
