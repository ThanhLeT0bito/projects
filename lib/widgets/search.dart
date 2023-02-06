import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        color: Colors.black38,
        padding: const EdgeInsets.all(8),
        height: 35,
        child: Row(
          children: const [
            Icon(
              Icons.search,
              size: 20,
            ),
            SizedBox(width: 5),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Tìm kiếm', border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
