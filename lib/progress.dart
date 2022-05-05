import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer getShimmerLoadingdetprest() {
  return Shimmer.fromColors(
    highlightColor: Colors.grey[300]!,
    baseColor: Colors.grey[100]!,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250.0,
          width: 450.0,
          margin: EdgeInsets.only(right: 8.0, left: 8, top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
        Container(
          height: 20.0,
          width: 200.0,
          margin: EdgeInsets.only(right: 8.0, left: 8, top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
        Container(
          height: 20.0,
          width: 300.0,
          margin: EdgeInsets.only(right: 8.0, left: 8, top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
        Container(
          height: 20.0,
          width: 120.0,
          margin: EdgeInsets.only(right: 8.0, left: 8, top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            Container(
              height: 70.0,
              width: 70.0,
              margin: EdgeInsets.only(right: 10.0, left: 10, top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
            ),
            Container(
              height: 70.0,
              width: 70.0,
              margin: EdgeInsets.only(right: 10.0, left: 10, top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
            ),
            Container(
              height: 70.0,
              width: 70.0,
              margin: EdgeInsets.only(right: 10.0, left: 10, top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
            ),
            Container(
              height: 70.0,
              width: 70.0,
              margin: EdgeInsets.only(right: 10.0, left: 10, top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
            ),
          ],
        ),
        Container(
          height: 20.0,
          width: 400.0,
          margin: EdgeInsets.only(right: 8.0, left: 8, top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
        Container(
          height: 20.0,
          width: 400.0,
          margin: EdgeInsets.only(right: 8.0, left: 8, top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
        Container(
          height: 40.0,
          width: 80.0,
          margin: EdgeInsets.only(right: 8.0, left: 8, top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            Container(
              height: 150.0,
              width: 150.0,
              margin: EdgeInsets.only(right: 10.0, left: 10, top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
            ),
            Container(
              height: 150.0,
              width: 150.0,
              margin: EdgeInsets.only(right: 10.0, left: 10, top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
            ),
          ],
        ),
        Container(
          height: 40.0,
          width: 120.0,
          margin: EdgeInsets.only(right: 8.0, left: 8, top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            Container(
              height: 150.0,
              width: 230.0,
              margin: EdgeInsets.only(right: 10.0, left: 10, top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
            ),
            Container(
              height: 150.0,
              width: 230.0,
              margin: EdgeInsets.only(right: 10.0, left: 10, top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Shimmer getShimmerLoading(double height, double width) {
  return Shimmer.fromColors(
    highlightColor: Colors.grey[300]!,
    baseColor: Colors.grey[100]!,
    child: Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(right: 8.0, left: 8, top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
    ),
  );
}
