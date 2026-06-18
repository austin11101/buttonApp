import 'package:flutter/material.dart';

// Entry point of the application.
// Flutter starts execution here.
void main() {
  runApp(const ColorChangerApp());
}

// Root widget of the application.
// MaterialApp provides navigation, themes, routes, etc.
class ColorChangerApp extends StatelessWidget {
  const ColorChangerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // First screen shown when the app starts
      home: const LoginScreen(),
    );
  }
}

// Login screen.
// StatefulWidget is used because username/password can change.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // Controllers allow us to read values entered into TextFields.
  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  // Function executed when Login button is pressed.
  void login() {

    // Simple hardcoded authentication.
    // Later this can be replaced with an API call.
    if (usernameController.text == "admin" &&
        passwordController.text == "1234") {

      // Navigate to the main page and remove login page
      // from the navigation stack.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ColorChangerPage(),
        ),
      );
    } else {

      // Display error message if login fails.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username or password'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Top navigation bar
      appBar: AppBar(
        title: const Text('Login'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Username input field
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // Password input field
            TextField(
              controller: passwordController,

              // Hides password characters
              obscureText: true,

              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Login button
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

// Main application page after successful login.
class ColorChangerPage extends StatefulWidget {
  const ColorChangerPage({super.key});

  @override
  State<ColorChangerPage> createState() => _ColorChangerPageState();
}

class _ColorChangerPageState extends State<ColorChangerPage> {

  // Stores current background color.
  Color backgroundColor = Colors.white;

  // Stores color name displayed on screen.
  String selectedColor = "White";

  // Tracks selected BottomNavigationBar item.
  // 0 = Home
  // 1 = Business
  // 2 = School
  int _selectedIndex = 0;

  // Updates screen color and displayed color name.
  void changeColor(Color color, String name) {
    setState(() {
      backgroundColor = color;
      selectedColor = name;
    });
  }

  // Determines which screen to display.
  Widget _buildScreen() {
    if (_selectedIndex == 0) {
      return homeScreen();
    } else if (_selectedIndex == 1) {
      return const Center(
        child: Text(
          'Business Screen',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return const Center(
        child: Text(
          'School Screen',
          style: TextStyle(fontSize: 24),
        ),
      );
    }
  }

  // Home screen content.
  Widget homeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // Displays selected color name
          Text(
            'Current Color: $selectedColor',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // Opens About page
          ElevatedButton(
            child: const Text('About'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AboutScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 40),

          // Color selection buttons
          Wrap(
            spacing: 10,
            children: [

              ElevatedButton(
                onPressed: () =>
                    changeColor(Colors.red, "Red"),
                child: const Text('Red'),
              ),

              ElevatedButton(
                onPressed: () =>
                    changeColor(Colors.green, "Green"),
                child: const Text('Green'),
              ),

              ElevatedButton(
                onPressed: () =>
                    changeColor(Colors.blue, "Blue"),
                child: const Text('Blue'),
              ),

              ElevatedButton(
                onPressed: () =>
                    changeColor(Colors.white, "White"),
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Logs user out and returns to Login screen.
  void logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Screen background changes when buttons are pressed
      backgroundColor: backgroundColor,

      appBar: AppBar(
        title: const Text('Flutter Color Changer'),

        // Logout button in top-right corner
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),

      // Side navigation drawer
      drawer: const Drawer(
        child: Center(
          child: Text('Navigation Menu'),
        ),
      ),

      // Main content area
      body: _buildScreen(),

      // Floating button in bottom-right corner
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Floating button pressed");
        },
        child: const Icon(Icons.add),
      ),

      // Bottom navigation menu
      bottomNavigationBar: BottomNavigationBar(

        // Currently selected tab
        currentIndex: _selectedIndex,

        // Triggered when user taps a menu item
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
      ),
    );
  }
}

// Simple About page.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('About Screen'),
      ),

      body: const Center(
        child: Text(
          'Welcome to the About Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
