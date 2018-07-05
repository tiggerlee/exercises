package chapter3

import java.util.*
import kotlin.test.assertEquals

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
private fun reverseList(list: List) {
    
}

fun main(args: Array<String>) {
    // test for 3.1
    assertEquals(0, parenthesesBalance(""))
    assertEquals(1, parenthesesBalance("("))
    assertEquals(2, parenthesesBalance("(("))
    assertEquals(1, parenthesesBalance("(()"))
    assertEquals(0, parenthesesBalance("(()((())))"))
    assertEquals(1, parenthesesBalance("(()((()))"))
    assertEquals(3, parenthesesBalance("((("))
    assertEquals(3, parenthesesBalance("())"))

    // test for 3.2
    val node3 = List(3, null)
    val node2 = List(2, node3)
    val node1 = List(1, node2)
    println(traverseList(node1))
    println(traverseList(node2))
    println(traverseList(node3))
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
