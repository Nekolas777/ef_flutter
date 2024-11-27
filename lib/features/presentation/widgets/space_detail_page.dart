import 'package:flutter/material.dart';

class SpaceDetailPage extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String description;
  final String date;
  final bool isFavorite;
  final VoidCallback onDeleteFavorite;
  final VoidCallback onFavoritePressed;

  const SpaceDetailPage({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.onDeleteFavorite,
    required this.onFavoritePressed,
    required this.date,
    required this.isFavorite,
  });

  @override
  State<SpaceDetailPage> createState() => _SpaceDetailPageState();
}

class _SpaceDetailPageState extends State<SpaceDetailPage> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      widget.onFavoritePressed();
    } else {
      widget.onDeleteFavorite();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Nombre
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.65,
                ),
              ),
              const SizedBox(height: 20),
              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text('Image not available'),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Date: ',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: widget.date,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Descripción
              Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.65,
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 0.5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
                size: 30,
              ),
              onPressed: _toggleFavorite,
            ),
          ),
        )
      ],
    );
  }
}