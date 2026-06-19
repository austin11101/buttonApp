import 'package:flutter/material.dart';

void main() {
  runApp(const GymPlannerApp());
}

class GymPlannerApp extends StatefulWidget {
  const GymPlannerApp({super.key});

  static _GymPlannerAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_GymPlannerAppState>();
  }

  @override
  State<GymPlannerApp> createState() => _GymPlannerAppState();
}

class _GymPlannerAppState extends State<GymPlannerApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData.light(),

      darkTheme: ThemeData.dark(),

      home: const LoginScreen(),
    );
  }
}

class WorkoutItem {
  final String day;
  final String workout;
  final String duration;
  final String time;
  bool reminderEnabled;


  WorkoutItem({
    required this.day,
    required this.workout,
    required this.duration,
    required this.time,
    this.reminderEnabled = false,
  });
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
        MaterialPageRoute(builder: (_) => const GymHomePage()),
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
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.fitness_center),
            SizedBox(width: 8),
            Text(
              'Gym Planner',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.fitness_center, size: 90, color: Colors.deepPurple),
            const SizedBox(height: 20),
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

class GymHomePage extends StatefulWidget {
  const GymHomePage({super.key});

  @override
  State<GymHomePage> createState() => _GymHomePageState();
}

class _GymHomePageState extends State<GymHomePage> {
  int _selectedIndex = 0;

  final List<WorkoutItem> workouts = [
    WorkoutItem(
      day: 'Monday',
      workout: 'Chest & Triceps',
      duration: '1 hour',
      time: '18:00',
    ),
    WorkoutItem(
      day: 'Tuesday',
      workout: 'Back & Biceps',
      duration: '1 hour',
      time: '18:00',
    ),
  ];
  
  void openCalendarView() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const CalendarViewScreen(),
    ),
  );
}
  
  void openBmiCalculator() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const BmiCalculatorScreen(),
    ),
  );
}
  void openNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NotificationsScreen(),
      ),
    );
  }

  void showAddWorkoutDialog() {
    final workoutController = TextEditingController();
    final durationController = TextEditingController();
    final timeController = TextEditingController();
    final dayController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Workout'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: workoutController,
                  decoration: const InputDecoration(
                    labelText: 'Workout',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: durationController,
                  decoration: const InputDecoration(
                    labelText: 'Duration',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: timeController,
                  decoration: const InputDecoration(
                    labelText: 'Time',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: dayController,
                  decoration: const InputDecoration(
                    labelText: 'Day',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.monitor_weight),
              onPressed: openWeightTracker,
            ),
            
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (workoutController.text.isEmpty ||
                    durationController.text.isEmpty ||
                    timeController.text.isEmpty ||
                    dayController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                  return;
                }

                setState(() {
                  workouts.add(
                    WorkoutItem(
                      day: dayController.text,
                      workout: workoutController.text,
                      duration: durationController.text,
                      time: timeController.text,
                    ),
                  );
                });

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildScreen() {
    if (_selectedIndex == 0) {
      return dashboardScreen();
    } else if (_selectedIndex == 1) {
      return scheduleScreen();
    } else {
      return goalsScreen();
    }
  }

  Widget dashboardScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: const [
          Icon(Icons.fitness_center, size: 80, color: Colors.deepPurple),
          SizedBox(height: 15),
          Text(
            'My Gym Planner',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Plan your workouts, track your days, and stay consistent.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 25),
          GoalCard(
            title: 'Today Reminder',
            description: 'Check your schedule before your workout starts.',
            icon: Icons.notifications_active,
          ),
        ],
      ),
    );
  }

  Widget scheduleScreen() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        final item = workouts[index];

        return WorkoutCard(
          item: item,
          onReminderPressed: () {
            setState(() {
              item.reminderEnabled = !item.reminderEnabled;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  item.reminderEnabled
                      ? 'Reminder enabled for ${item.workout}'
                      : 'Reminder disabled for ${item.workout}',
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget goalsScreen() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: const [
          GoalCard(
            title: 'Weekly Goal',
            description: 'Train at least 5 days this week.',
            icon: Icons.calendar_month,
          ),
          GoalCard(
            title: 'Strength Goal',
            description: 'Increase bench press weight gradually.',
            icon: Icons.trending_up,
          ),
          GoalCard(
            title: 'Health Goal',
            description: 'Drink more water and sleep 7-8 hours.',
            icon: Icons.favorite,
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

  void openAbout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AboutScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: openProfile,
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: openNotifications,
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: openAbout,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
          const DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(
                        Icons.fitness_center,
                        size: 50,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Gym Planner Menu',
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: openProfile,
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: openNotifications,
            ),
            ListTile(
              leading: const Icon(Icons.monitor_weight),
              title: const Text('Weight Tracker'),
              onTap: openWeightTracker,
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('BMI Calculator'),
              onTap: openBmiCalculator,
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Calendar View'),
              onTap: openCalendarView,
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Schedule'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('Goals'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: logout,
            ),
          ],
        ),
      ),
      body: _buildScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddWorkoutDialog,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Goals',
          ),
        ],
      ),
    );
  }
  
        void openProfile() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ProfileScreen(),
          ),
        );
      }
  
        void openWeightTracker() {
        Navigator.push(
          context,
         MaterialPageRoute(
          builder: (_) => const WeightTrackerScreen(),
          ),
        );
      }
      }

class WorkoutCard extends StatelessWidget {
  final WorkoutItem item;
  final VoidCallback onReminderPressed;

  const WorkoutCard({
    super.key,
    required this.item,
    required this.onReminderPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: const Icon(
          Icons.fitness_center,
          color: Colors.deepPurple,
        ),
        title: Text('${item.day} - ${item.workout}'),
        subtitle: Text(
          'Duration: ${item.duration}\nTime: ${item.time}',
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.notifications_active,
            color: item.reminderEnabled
                ? Colors.red
                : Colors.grey,
          ),
          onPressed: onReminderPressed,
        ),
        isThreeLine: true,
      ),
    );
  }
}

class GoalCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const GoalCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Reminders'),
        centerTitle: true,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Workout reminders will appear here.\n\nFor now, pressing the reminder icon on a workout will confirm the reminder inside the app.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Gym Planner'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Gym Planner helps you organize your weekly workouts, schedule training days, and track fitness goals.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = GymPlannerApp.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              appState!.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: appState.isDarkMode,
              onChanged: (value) {
                appState.toggleTheme();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Austin Baloyi';
  String level = 'Fitness Beginner';
  String email = 'austinbal28@gmail.com';
  String goal = 'Build strength and stay consistent';
  String weight = 'Not set yet';
  String height = 'Not set yet';
  String trainingDays = '5 days per week';

  void editProfile() {
    final nameController = TextEditingController(text: name);
    final levelController = TextEditingController(text: level);
    final emailController = TextEditingController(text: email);
    final goalController = TextEditingController(text: goal);
    final weightController = TextEditingController(text: weight);
    final heightController = TextEditingController(text: height);
    final trainingDaysController = TextEditingController(text: trainingDays);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
                TextField(controller: levelController, decoration: const InputDecoration(labelText: 'Fitness Level')),
                TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
                TextField(controller: goalController, decoration: const InputDecoration(labelText: 'Goal')),
                TextField(controller: weightController, decoration: const InputDecoration(labelText: 'Weight')),
                TextField(controller: heightController, decoration: const InputDecoration(labelText: 'Height')),
                TextField(controller: trainingDaysController, decoration: const InputDecoration(labelText: 'Training Days')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  name = nameController.text;
                  level = levelController.text;
                  email = emailController.text;
                  goal = goalController.text;
                  weight = weightController.text;
                  height = heightController.text;
                  trainingDays = trainingDaysController.text;
                });

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 55,
              child: Icon(Icons.person, size: 70),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(level, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            ProfileInfoCard(icon: Icons.email, title: 'Email', value: email),
            ProfileInfoCard(icon: Icons.fitness_center, title: 'Goal', value: goal),
            ProfileInfoCard(icon: Icons.monitor_weight, title: 'Current Weight', value: weight),
            ProfileInfoCard(icon: Icons.height, title: 'Height', value: height),
            ProfileInfoCard(icon: Icons.calendar_month, title: 'Training Days', value: trainingDays),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: editProfile,
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
  
  
}
class WeightTrackerScreen extends StatefulWidget {
  const WeightTrackerScreen({super.key});

  @override
  State<WeightTrackerScreen> createState() => _WeightTrackerScreenState();
}

class _WeightTrackerScreenState extends State<WeightTrackerScreen> {
  final TextEditingController currentWeightController =
      TextEditingController();

  final TextEditingController targetWeightController =
      TextEditingController();

  final List<String> weightHistory = [];

  String currentWeight = 'Not set';
  String targetWeight = 'Not set';

  void saveWeight() {
    if (currentWeightController.text.isEmpty ||
        targetWeightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter current and target weight')),
      );
      return;
    }

    setState(() {
      currentWeight = '${currentWeightController.text} kg';
      targetWeight = '${targetWeightController.text} kg';

      weightHistory.add(
        'Current: $currentWeight | Target: $targetWeight',
      );

      currentWeightController.clear();
      targetWeightController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Tracker'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.monitor_weight,
              size: 80,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(Icons.fitness_center),
                title: const Text('Current Weight'),
                subtitle: Text(currentWeight),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.flag),
                title: const Text('Target Weight'),
                subtitle: Text(targetWeight),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: currentWeightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Current Weight kg',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: targetWeightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Target Weight kg',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: saveWeight,
              icon: const Icon(Icons.save),
              label: const Text('Save Weight'),
            ),

            const SizedBox(height: 30),

            const Text(
              'Weight History',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            if (weightHistory.isEmpty)
              const Text('No weight records yet'),

            ...weightHistory.map(
              (record) => Card(
                child: ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(record),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});

  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String bmiResult = 'Not calculated yet';
  String bmiCategory = '';

  void calculateBmi() {
    final double? weight = double.tryParse(weightController.text);
    final double? heightCm = double.tryParse(heightController.text);

    if (weight == null || heightCm == null || heightCm <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid weight and height'),
        ),
      );
      return;
    }

    final double heightM = heightCm / 100;
    final double bmi = weight / (heightM * heightM);

    String category;

    if (bmi < 18.5) {
      category = 'Underweight';
    } else if (bmi < 25) {
      category = 'Normal weight';
    } else if (bmi < 30) {
      category = 'Overweight';
    } else {
      category = 'Obese';
    }

    setState(() {
      bmiResult = bmi.toStringAsFixed(1);
      bmiCategory = category;
    });
  }

  void clearBmi() {
    setState(() {
      weightController.clear();
      heightController.clear();
      bmiResult = 'Not calculated yet';
      bmiCategory = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.calculate,
              size: 80,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),

            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Weight in kg',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Height in cm',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: calculateBmi,
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calculate'),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: clearBmi,
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear'),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.analytics),
                title: const Text('Your BMI'),
                subtitle: Text(
                  bmiCategory.isEmpty
                      ? bmiResult
                      : '$bmiResult - $bmiCategory',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CalendarViewScreen extends StatelessWidget {
  const CalendarViewScreen({super.key});

  final List<Map<String, String>> weeklySchedule = const [
    {
      'day': 'Monday',
      'workout': 'Chest & Triceps',
      'time': '18:00',
      'duration': '1 hour',
    },
    {
      'day': 'Tuesday',
      'workout': 'Back & Biceps',
      'time': '18:00',
      'duration': '1 hour',
    },
    {
      'day': 'Wednesday',
      'workout': 'Leg Day',
      'time': '18:00',
      'duration': '1 hour',
    },
    {
      'day': 'Thursday',
      'workout': 'Shoulders & Abs',
      'time': '17:30',
      'duration': '1 hour',
    },
    {
      'day': 'Friday',
      'workout': 'Full Body',
      'time': '18:00',
      'duration': '1 hour',
    },
    {
      'day': 'Saturday',
      'workout': 'Cardio',
      'time': '08:00',
      'duration': '1 hour',
    },
    {
      'day': 'Sunday',
      'workout': 'Rest Day',
      'time': 'Anytime',
      'duration': 'Recovery',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar View'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: weeklySchedule.length,
        itemBuilder: (context, index) {
          final day = weeklySchedule[index];

          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: const Icon(
                Icons.calendar_month,
                color: Colors.deepPurple,
              ),
              title: Text('${day['day']} - ${day['workout']}'),
              subtitle: Text(
                'Time: ${day['time']}\nDuration: ${day['duration']}',
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
