#include <stdio.h>
#include <math.h>
#include <float.h>

typedef struct {
    int x;
    int y;
    char visited; // 0 unvisited 1 visited
} Point;

double dist(Point p1, Point p2)
{
    return sqrt(pow(p2.x-p1.x, 2) + pow(p2.y-p1.y, 2));
}

// return nearest neighbor index, -1 not found
int findNearestUnvisitedNeighbor(Point points[], Point p, int n)
{
    int i;
    int result = -1;
    double min_dist = DBL_MAX;
    double temp_dist;
    for (i = 0; i < n; i++) {
        if (points[i].visited == 1 || p.x == points[i].x && p.y == points[i].y) {
            continue;
        } else if ((temp_dist = dist(points[i], p)) < min_dist) {
            min_dist = temp_dist;
            result = i;
        }
    }
    return result;
}

void nearestNeighborAlgorithms(Point points[], Point start, int n)
{
}

int main(int argc, char *argv[])
{
    Point p1 = {2, 0, 0};
    Point p2 = {18, 0, 0};
    Point p3 = {4, 0, 0};
    Point p4 = {7, 0, 0};
    Point points[] = {p1, p2, p3, p4};
    printf("Distance is %f\n", dist(p1, p2));
    printf("Distance is %f\n", dist(p1, p3));
    printf("Distance is %f\n", dist(p1, p4));
    printf("p1 nearest point is at %d\n", findNearestUnvisitedNeighbor(points, p1, 4));
}