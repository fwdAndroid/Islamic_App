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
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/ellipse.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.qari.name!,
              // 'Res',
              style: const TextStyle(color: Colors.white,fontSize: 10),
              overflow: TextOverflow.fade,
              
            ),
          ),
        ],
      ),
    );
  }
}
