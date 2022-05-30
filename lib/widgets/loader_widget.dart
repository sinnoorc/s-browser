import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.separated(
        shrinkWrap: true,
        // padding: const EdgeInsets.all(20),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (_, __) => Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 6.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      height: 6.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 50,
                      height: 6.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 6.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 70,
                      height: 6.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
        itemCount: 12,
      ),
    );
  }
}
