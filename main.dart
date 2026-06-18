import 'dart:math';
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
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    if (usernameController.text == "admin" &&
        passwordController.text == "1234") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ColorChangerPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text("Login"),
            ),
          ],
        ),
      ),
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
  int _selectedIndex = 0;

  void changeColor(Color color, String name) {
    setState(() {
      backgroundColor = color;
      selectedColor = name;
    });
  }

  Widget _buildScreen() {
    if (_selectedIndex == 0) {
      return homeScreen();
    } else if (_selectedIndex == 1) {
      return businessScreen();
    } else if (_selectedIndex == 2) {
      return const Center(
        child: Text('School Screen', style: TextStyle(fontSize: 24)),
      );
    } else {
      return gamesScreen();
    }
  }

  Widget homeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Current Color: $selectedColor',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text('About'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              );
            },
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
    );
  }

  Widget businessScreen() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            Icon(Icons.business_center, size: 80, color: Colors.blue),
            SizedBox(height: 15),
            Text(
              'Austin Tech Solutions',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Professional IT services for individuals and small businesses.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            ServiceCard(
              icon: Icons.web,
              title: 'Web Development',
              subtitle: 'Modern websites and web applications',
            ),
            ServiceCard(
              icon: Icons.settings,
              title: 'Website Maintenance',
              subtitle: 'Fixes, updates, backups, and improvements',
            ),
            ServiceCard(
              icon: Icons.cloud,
              title: 'Hosting Solutions',
              subtitle: 'Help with hosting and publishing websites online',
            ),
            ServiceCard(
              icon: Icons.phone_android,
              title: 'Flutter Apps',
              subtitle: 'Simple mobile and web apps using Flutter',
            ),
            ServiceCard(
              icon: Icons.laptop,
              title: 'Laptop Repairs',
              subtitle: 'Hardware and software troubleshooting',
            ),
            ServiceCard(
              icon: Icons.upgrade,
              title: 'System Upgrades',
              subtitle: 'RAM, storage, Windows, Linux, and performance upgrades',
            ),
            ServiceCard(
              icon: Icons.support_agent,
              title: 'Technical Support',
              subtitle: 'General IT support and problem solving',
            ),
          ],
        ),
      ),
    );
  }

  Widget gamesScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.sports_esports, size: 100, color: Colors.green),
          const SizedBox(height: 20),
          const Text(
            'Games Page',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text('Play Snake Game'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SnakeGameScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  void logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.yellow,
        title: const Text('Flutter Color Changer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      drawer: const Drawer(
        child: Center(child: Text('Navigation Menu')),
      ),
      body: _buildScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Floating button pressed");
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports),
            label: 'Games',
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Screen')),
      body: const Center(
        child: Text(
          'Welcome to the About Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class SnakeGameScreen extends StatefulWidget {
  const SnakeGameScreen({super.key});

  @override
  State<SnakeGameScreen> createState() => _SnakeGameScreenState();
}

class _SnakeGameScreenState extends State<SnakeGameScreen> {
  final int rowSize = 10;
  final int totalSquares = 100;

  List<int> snakePosition = [44, 45, 46];

  int foodPosition = 55;
  int score = 0;

  String direction = "right";
  final Random random = Random();

  void moveSnake() {
    setState(() {
      int newHead = snakePosition.last;

      if (direction == "right") {
        newHead = newHead + 1;
      } else if (direction == "left") {
        newHead = newHead - 1;
      } else if (direction == "up") {
        newHead = newHead - rowSize;
      } else if (direction == "down") {
        newHead = newHead + rowSize;
      }

      if (newHead < 0 || newHead >= totalSquares) {
        resetGame();
        return;
      }

      snakePosition.add(newHead);

      if (newHead == foodPosition) {
        score++;
        generateNewFood();
      } else {
        snakePosition.removeAt(0);
      }
    });
  }

  void generateNewFood() {
    int newFood = random.nextInt(totalSquares);

    while (snakePosition.contains(newFood)) {
      newFood = random.nextInt(totalSquares);
    }

    foodPosition = newFood;
  }

  void changeDirection(String newDirection) {
    direction = newDirection;
    moveSnake();
  }

  void resetGame() {
    snakePosition = [44, 45, 46];
    foodPosition = 55;
    score = 0;
    direction = "right";
  }

  Widget buildSquare(int index) {
    if (snakePosition.contains(index)) {
      return Container(
        margin: const EdgeInsets.all(2),
        color: Colors.green,
      );
    }

    if (index == foodPosition) {
      return Container(
        margin: const EdgeInsets.all(2),
        color: Colors.red,
      );
    }

    return Container(
      margin: const EdgeInsets.all(2),
      color: Colors.grey[300],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake Game'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Text(
            'Score: $score',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              itemCount: totalSquares,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rowSize,
              ),
              itemBuilder: (context, index) {
                return buildSquare(index);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                resetGame();
              });
            },
            child: const Text('Reset Game'),
          ),
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_up, size: 40),
            onPressed: () => changeDirection("up"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_left, size: 40),
                onPressed: () => changeDirection("left"),
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_right, size: 40),
                onPressed: () => changeDirection("right"),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down, size: 40),
            onPressed: () => changeDirection("down"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
