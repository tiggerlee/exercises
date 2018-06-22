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
        } else {
            temp_dist = dist(points[i], p);
            if (temp_dist < min_dist) {
                min_dist = temp_dist;
                result = i;
            }
        }
    }
    return result;
}

void nearestNeighborAlgorithms(Point points[], int start_index, int n)
{
}

int main(int argc, char *argv[])
{
    return 0;
}