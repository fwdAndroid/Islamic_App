import 'package:flutter/material.dart';
import '../../../authentications/providers/models/qari_.dart';

class QariCustomTile extends StatefulWidget {
  const QariCustomTile({Key? key, required this.qari, required this.ontap})
      : super(key: key);

  final Qari qari;
  final VoidCallback ontap;

  @override
  _QariCustomTileState createState() => _QariCustomTileState();
}

class _QariCustomTileState extends State<QariCustomTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        width: 80,
        child: Column(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/ellipse.png'),
            ),
            Text(
              widget.qari.name!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white,fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
