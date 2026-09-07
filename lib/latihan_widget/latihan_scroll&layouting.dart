import 'package:flutter/material.dart';

class LatihanScrollLayouting extends StatelessWidget {
const LatihanScrollLayouting({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Latihan SingleChildScrollView'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child :Column(
          children: [
            Text('latihab singleChildScrollView'),
            SizedBox(height: 800),
            Text('Text ini akan overlow di emulator')
          ],
        ),  
      ),
    );
  }
}