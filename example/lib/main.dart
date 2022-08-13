import 'package:flutter/material.dart';
import 'package:water_drop/water_drop.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water drop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WaterDrop(
          params: [
            WaterDropParam(top: 6, height: 40, left: 6, width: 60),
            WaterDropParam(top: 16, height: 30, left: 100, width: 20),
          ],
          child: Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(16),
            child: const Text('Water drop'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const MyCard(color: Colors.green),
            const MyCard(color: Colors.yellow),
            MyCard(color: Theme.of(context).cardColor),
            const MyCard(color: Colors.orange),
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatefulWidget {
  final Color color;

  const MyCard({Key? key, this.color = Colors.green}) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final move = _animationController.value * 40;
        return WaterDrop(
          params: [
            WaterDropParam(top: 50 + move, height: 70, left: 100, width: 50),
            WaterDropParam(top: 10 + move, height: 100, left: 280, width: 100),
            WaterDropParam(top: 155 + move, height: 35, left: 135, width: 35),
            WaterDropParam(top: 135 + move, height: 40, left: 250, width: 30),
            WaterDropParam(top: 20 + move, height: 40, left: 20, width: 40),
            WaterDropParam(top: 140 + move, height: 50, left: 15, width: 40),
            WaterDropParam(top: 20 + move, height: 30, left: 200, width: 30),
            WaterDropParam(top: 120 + move, height: 20, left: 360, width: 20),
          ],
          child: child!,
        );
      },
      child: _StaticCard(color: widget.color),
    );
  }
}

class _StaticCard extends StatelessWidget {
  final Color color;

  const _StaticCard({Key? key, this.color = Colors.green}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text(
                'Press me',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
