data class Point(val x: Int, val y: Int)

fun initPoints() = listOf(
        Point(-23, 0),
        Point(-5, 0),
        Point(-1, 0),
        Point(0, 0),
        Point(1, 0),
        Point(3, 0),
        Point(11, 0)
).toMutableList()

fun dist(x: Point, y: Point): Double =
        Math.sqrt(Math.pow((y.x - x.x).toDouble(), 2.0) + Math.pow((y.y - x.y).toDouble(), 2.0))

fun findNearestPoint(points: List<Point>, p: Point): Point? {
    var result: Point? = null
    var minDistance = Double.MAX_VALUE
    for (item in points) {
        val distance = dist(p, item)
        if (distance < minDistance) {
            minDistance = distance
            result = item
        }
    }
    return result
}

fun nearestNeighbor(startIndex: Int) {
    val points = initPoints()
    if (startIndex >= points.size) {
        println("start index is out of points set")
        return
    }
    var currentPoint = points.removeAt(startIndex)
    println("Visited point $currentPoint")
    while (points.isNotEmpty()) {
        val found = findNearestPoint(points, currentPoint)
        if (found != null) {
            println("Visited point $found")
            currentPoint = found
            points.remove(found)
        }
    }
}

fun main(args: Array<String>) {
    println("Start from left most point")
    nearestNeighbor(0)
    println("Start from point at index 3")
    nearestNeighbor(3)
}