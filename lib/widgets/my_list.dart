import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/reminders.dart';

class MyList extends StatelessWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Reminders>(context);
    final product = productsData.itemsList;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.black38,
        child: Column(
          children: List.generate(
            product.length,
            (index) => ListTile(
              leading: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.list,
                    size: 15,
                  )),
              title: Text(product[index].nameList.toString(),
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              trailing: const Icon(
                Icons.arrow_right_alt_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
