import "package:flutter/material.dart";

const appIcon = "lib/assets/app_icon.png";

class Carousel extends StatefulWidget {
  final String title;
  final (double, double) tileSize;
  final List<List<Widget>> tilesContent;
  final List<Color> tilesColor;
  const Carousel(
      {super.key,
      required this.tilesContent,
      this.title = "",
      this.tileSize = (150.0, 100.0),
      this.tilesColor = const [
        Color(0xffffffff),
        Color(0xffffffff),
      ]});
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    List<Tile> tiles = [];
    for (List content in widget.tilesContent) {
      tiles.add(Tile(
        content: content,
        tileSize: widget.tileSize,
        colors: widget.tilesColor,
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff1e1c1c))),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: tiles,
            ),
          ),
        )
      ],
    );
  }
}

class Tile extends StatefulWidget {
  final (double, double) tileSize;
  final List content;
  final List<Color> colors;
  const Tile({
    super.key,
    required this.tileSize,
    required this.colors,
    required this.content,
  });
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
        gradient: LinearGradient(
          colors: widget.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(children: [
        widget.content[0],
        widget.content[1],
      ]),
    );
  }
}
