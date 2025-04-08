import 'package:flutter/material.dart';
import '../models/track.dart';

class TrackItem extends StatelessWidget {
  final Track track;
  final int rank;

  const TrackItem({
    super.key,
    required this.track,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: track.thumbnailUrl != null
                ? Image.network(
                    track.thumbnailUrl!,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 40,
                        width: 40,
                        color: Colors.grey[300],
                        child: const Icon(Icons.music_note),
                      );
                    },
                  )
                : Container(
                    height: 40,
                    width: 40,
                    color: Colors.grey[300],
                    child: const Icon(Icons.music_note),
                  ),
          ),
          const SizedBox(height: 4),
          Text(
            track.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            track.artist,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}