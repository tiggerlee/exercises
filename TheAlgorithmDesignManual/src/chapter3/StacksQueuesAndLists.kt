package chapter3

import java.util.*
import kotlin.test.assertEquals
import kotlin.test.assertNotEquals

/*
    3-1. A common problem for compilers and text editors is determining whether the parentheses in a string are balanced
     and properly nested. For example, the string ((())())() contains properly nested pairs of parentheses,
      which the strings )()( and ()) do not. Give an algorithm that returns true if a string contains properly nested
       and balanced parentheses, and false if otherwise. For full credit, identify the position of the first offending
        parenthesis if the string is not properly nested and balanced.

    return 0 if parentheses balanced, otherwise the position of the first offending parentheses
 */
private fun parenthesesBalance(test :String): Int {
    val stack = Stack<Int>()
    test.forEachIndexed { index, c ->
        when (c) {
            '(' -> stack.push(index+1)
            ')' -> {
                if (stack.isEmpty()) {
                    return index+1
                } else {
                    stack.pop()
                }
            }
            else -> {} // chars we don't care -_-
        }
    }
    return if (stack.isEmpty()) 0 else stack.pop()
    }

/*
    3-2. Write a program to reverse the direction of a given singly-linked list. In other words,
     after the reversal all pointers should now point backwards. Your algorithm should take linear time.
 */
private data class List(val value: Int, var next: List?)
private fun reverseList(list: List): List {
    return r(null, list)
}

private fun r(previous: List?, list: List): List {
    return if (list.next == null) {
        list.next = previous
        list
    } else {
        val next = list.next
        list.next = previous
        r(list, next!!)
    }
}

fun main(args: Array<String>) {
    // test for 3.1
    testIsParenthesesBalanced()

    // test for 3.2
    testListWithOneNode()
    testMoreThanTwoNodes()
    testListWithTwoNode()
}

private fun testIsParenthesesBalanced() {
    assertEquals(0, parenthesesBalance(""))
    assertEquals(1, parenthesesBalance("("))
    assertEquals(2, parenthesesBalance("(("))
    assertEquals(1, parenthesesBalance("(()"))
    assertEquals(0, parenthesesBalance("(()((())))"))
    assertEquals(1, parenthesesBalance("(()((()))"))
    assertEquals(3, parenthesesBalance("((("))
    assertEquals(3, parenthesesBalance("())"))
}

private fun testListWithOneNode() {
    val node = List(1, null)
    assertEquals("1", traverseList(node))
    val reversed = reverseList(node)
    assertEquals("1", traverseList(reversed))
}

private fun testListWithTwoNode() {
    val node1 = List(2, null)
    val node = List(1, node1)
    assertEquals("12", traverseList(node))
    val reversed = reverseList(node)
    assertEquals("21", traverseList(reversed))
}

private fun testMoreThanTwoNodes() {
    val node3 = List(3, null)
    val node2 = List(2, node3)
    val node1 = List(1, node2)
    assertEquals("123", traverseList(node1))
    assertNotEquals("321", traverseList(node1))
    val reversed = reverseList(node1)
    assertNotEquals("123", traverseList(reversed))
    assertEquals("321", traverseList(reversed))
}

private fun traverseList(list: List): String {
    var temp: List? = list
    val sb = StringBuffer()
    while (temp != null) {
        sb.append(temp.value)
        temp = temp.next
    }
    return sb.toString()
}
