import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isSelected;

  const CategoryCard({
    required this.name,
    required this.imageUrl,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            /// CATEGORY IMAGE
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// SELECTED DARK GRADIENT
            if (isSelected)
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),

            /// CHECK ICON (optional but nice UX)
            // if (isSelected)
            //   const Positioned(
            //     top: 6,
            //     right: 6,
            //     child: Icon(
            //       Icons.check_circle,
            //       color: Colors.white,
            //       size: 18,
            //     ),
            //   ),
          ],
        ),

        const SizedBox(height: 6),

        /// CATEGORY NAME
        SizedBox(
          width: 75,
          child: Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? Colors.deepOrange
                  : Colors.brown.shade700,
            ),
          ),
        ),
      ],
    );
  }
}