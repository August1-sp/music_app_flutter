import 'package:flutter/material.dart';
import '../models/album.dart';

class AlbumItem extends StatelessWidget {
  final Album album;

  const AlbumItem({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: album.thumbnailUrl != null
                ? Image.network(
                    album.thumbnailUrl!,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 40,
                    width: 40,
                    color: Colors.grey,
                    child: const Icon(Icons.album),
                  ),
          ),
          const SizedBox(height: 8),
          Text(
            album.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            album.artist,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}