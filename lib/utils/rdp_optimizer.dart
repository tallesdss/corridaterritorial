import 'dart:math' as math;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class RDPOptimizer {
  /// Simplifies a list of points using the Ramer-Douglas-Peucker algorithm.
  /// [epsilon] is the maximum distance between the original point and the simplified line.
  static List<Position> optimize(List<Position> points, double epsilon) {
    if (points.length < 3) return points;

    int index = -1;
    double maxDistance = 0;

    for (int i = 1; i < points.length - 1; i++) {
      double distance = perpendicularDistance(points[i], points[0], points.last);
      if (distance > maxDistance) {
        index = i;
        maxDistance = distance;
      }
    }

    if (maxDistance > epsilon) {
      List<Position> left = optimize(points.sublist(0, index + 1), epsilon);
      List<Position> right = optimize(points.sublist(index), epsilon);
      return [...left.sublist(0, left.length - 1), ...right];
    } else {
      return [points.first, points.last];
    }
  }

  static double perpendicularDistance(Position p, Position start, Position end) {
    double x = p.lng.toDouble();
    double y = p.lat.toDouble();
    double x1 = start.lng.toDouble();
    double y1 = start.lat.toDouble();
    double x2 = end.lng.toDouble();
    double y2 = end.lat.toDouble();

    double numerator = ((y2 - y1) * x - (x2 - x1) * y + x2 * y1 - y2 * x1).abs();
    double denominator = math.sqrt(math.pow(y2 - y1, 2) + math.pow(x2 - x1, 2));

    if (denominator == 0) {
      return math.sqrt(math.pow(x - x1, 2) + math.pow(y - y1, 2));
    }

    return numerator / denominator;
  }
}
