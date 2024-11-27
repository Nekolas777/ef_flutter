import 'package:ef_mynasa/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FavoriteSpaceCard extends StatelessWidget {
  final String id;
  final String title;
  final String explanation;
  final String url;
  final VoidCallback onDeleteFavoritePressed;

  const FavoriteSpaceCard({
    required this.id,
    required this.title,
    required this.explanation,
    required this.url,
    required this.onDeleteFavoritePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  url,
                  width: 135,
                  height: 135,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Explanation: $explanation',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: CustomColors.lightGrey,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: GestureDetector(
              onTap: () {
                onDeleteFavoritePressed(); // Llama al método para eliminar el favorito
              },
              child: const Icon(Icons.delete, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
