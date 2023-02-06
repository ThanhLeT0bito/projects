import 'package:flutter/material.dart';

import '../widgets/main_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 20),
              height: MediaQuery.of(context).size.height * 0.05,
              child: TextButton(
                child: const Text('Sửa'),
                onPressed: () {},
              ),
            ),
            const MainContent(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: const [
                        Icon(Icons.add_circle_outline),
                        Text('Lời nhắc mới'),
                      ],
                    )),
                TextButton(
                    onPressed: () {}, child: const Text('Thêm danh sách'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
