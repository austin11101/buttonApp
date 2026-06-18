import 'package:flutter/material.dart';

void main() {
  runApp(const ColorChangerApp());
}

class ColorChangerApp extends StatelessWidget {
  const ColorChangerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Color Changer',
      home: const ColorChangerPage(),
    );
  }
}

class ColorChangerPage extends StatefulWidget {
  const ColorChangerPage({super.key});

  @override
  State<ColorChangerPage> createState() => _ColorChangerPageState();
}

class _ColorChangerPageState extends State<ColorChangerPage> {
  Color backgroundColor = Colors.white;
  String selectedColor = "White";

  void changeColor(Color color, String name) {
    setState(() {
      backgroundColor = color;
      selectedColor = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Flutter Color Changer'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.add),
        onPressed: () {
          print('Pressed!');
          
        }),
      bottomNavigationBar: BottomNavigationBar(
      items:const[
        BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label:'Home',
        ),
        BottomNavigationBarItem(
        icon:Icon(Icons.business),
        label: 'Business',
        ),
        BottomNavigationBarItem(
        icon:Icon(Icons.school),
          label: 'School',),
      ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Color: $selectedColor',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => changeColor(Colors.red, "Red"),
                  child: const Text('Red'),
                ),
                ElevatedButton(
                  onPressed: () => changeColor(Colors.green, "Green"),
                  child: const Text('Green'),
                ),
                ElevatedButton(
                  onPressed: () => changeColor(Colors.blue, "Blue"),
                  child: const Text('Blue'),
                ),
                ElevatedButton(
                  onPressed: () => changeColor(Colors.white, "White"),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
