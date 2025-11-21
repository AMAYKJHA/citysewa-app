import "package:flutter/material.dart";

const appIcon = "lib/assets/app_icon.png";

class Carousel extends StatefulWidget {
  final String title;
  final (double, double) tileSize;
  final List<List<Widget>> tilesContent;
  final Color tileColor;
  Carousel({
    super.key,
    required this.tilesContent,
    this.title = "",
    this.tileSize = (150.0, 100.0),
    this.tileColor = Colors.red,
  });

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    List<Tile> tiles = [];
    for (List content in widget.tilesContent) {
      tiles.add(
        Tile(
          content: content,
          tileSize: widget.tileSize,
          color: widget.tileColor,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 108, 108, 108),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: tiles,
            ),
          ),
        ),
      ],
    );
  }
}

class Tile extends StatefulWidget {
  final (double, double) tileSize;
  final List content;
  final Color color;
  const Tile({
    super.key,
    required this.tileSize,
    required this.color,
    required this.content,
  });
  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.tileSize.$1,
      height: widget.tileSize.$2,
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(10),

        color: widget.color,
      ),
      child: Column(children: [widget.content[0], widget.content[1]]),
    );
  }
}
