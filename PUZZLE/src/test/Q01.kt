package test

import kotlin.test.*

// 求用十进制、二进制、八进制表示都是回文数的所有数字中，大于十进制数 10 的最小值。

// 使用 java 中 Integer 提供的toxxxString方法替换自己实现的进制转换方法
// 使用 kotlin 的 reversed 方法，倒序进制转换之后的字符串并和转换之后的结果对比
// 因为二进制格式中，第一个数字如果和最后一个数字相同，第一个数字是1，最后一个数字也为1，那么只能为奇数，所以只选择奇数
fun findPalindromeNumberGreaterThanTenUseJavaMethods(): Int {
    var testNumber = 11
    while (true) {
        if (Integer.toString(testNumber) == Integer.toString(testNumber).reversed() &&
                Integer.toBinaryString(testNumber) == Integer.toBinaryString(testNumber).reversed() &&
                Integer.toOctalString(testNumber) == Integer.toOctalString(testNumber).reversed()) {
            return testNumber
        } else {
            testNumber += 2
        }
    }
}

fun findPalindromeGreaterThanTen(): Int {
    var testNumber = 11
    while (true) {
        if (isPalindromeNumberInThreeBase(testNumber)) {
            return testNumber
        } else {
            testNumber += 1
        }
    }
}

private fun isPalindromeNumberInThreeBase(testNumber: Int) =
        isPalindrome(testNumber.toString()) && isPalindrome(iToBinary(testNumber)) && isPalindrome(iToOctal(testNumber))

fun isPalindrome(representation: String): Boolean {
    val chars = representation.toCharArray()
    var lowIndex = 0
    var highIndex = chars.lastIndex
    while (highIndex > lowIndex) {
        if (chars[lowIndex] == chars[highIndex]) {
            lowIndex += 1
            highIndex -= 1
        } else {
            return false
        }
    }
    return true
}

fun iToOctal(number: Int) = iToBase(number, 8)
fun iToBinary(number: Int) = iToBase(number, 2)

fun iToBase(number: Int, base: Int): String {
    fun iter(n: Int, result: String): String {
        return when {
            n > 0 -> return iter(n/base, (n%base).toString() + result)
            n == 0 -> return if (result.isEmpty()) { "0" } else { result }
            n < 0 -> throw Exception("Negative number are not accepted $n")
            else -> result
        }
    }
    return iter(number, "")
}

fun main(args: Array<String>) {
    // Test for special number
    assertFails { iToOctal(-1) }
    assertEquals("0", iToOctal(0))
    assertFails { iToBinary(-1) }
    assertEquals("0", iToBinary(0))

    // Test for iToOctal
    assertEquals("1", iToOctal(1))
    assertEquals("10", iToOctal(8))
    assertEquals("11", iToOctal(9))
    assertNotEquals("10", iToOctal(9))

    // Test for iToBinary
    assertEquals("1", iToBinary(1))
    assertEquals("10", iToBinary(2))
    assertEquals("10000", iToBinary(16))
    assertEquals("1111", iToBinary(15))
    assertNotEquals("1111", iToBinary(16))

    // Test for isPalindrome
    assertTrue { isPalindrome("1") }
    assertTrue { isPalindrome("") }
    assertFalse { isPalindrome("10") }
    assertTrue { isPalindrome("1001") }
    assertFalse { isPalindrome("1010") }
    assertTrue { isPalindrome("10101") }
    assertTrue { isPalindrome("1010101") }
    assertFalse { isPalindrome("10101101") }
    assertTrue { isPalindrome("10100101") }

    println(findPalindromeGreaterThanTen())
    println(findPalindromeNumberGreaterThanTenUseJavaMethods())
    assertEquals(findPalindromeGreaterThanTen(), findPalindromeNumberGreaterThanTenUseJavaMethods())
}