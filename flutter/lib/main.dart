import 'package:flutter/material.dart';

class _ActivityChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue.shade300;
    const barWidth = 24.0;
    const gap = 20.0;
    final heights = [size.height * 0.6, size.height * 0.9, size.height * 0.4];
    for (var i = 0; i < heights.length; i++) {
      final x = i * (barWidth + gap);
      canvas.drawRect(
        Rect.fromLTWH(x, size.height - heights[i], barWidth, heights[i]),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  final TextEditingController _passwordController = TextEditingController();
  bool _checkboxValue = false;
  String _status = 'Press the button';
  int _quantity = 0;
  String _plan = 'free';

  final List<String> _items = const [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
  ];

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onButtonPressed() {
    setState(() {
      _status = 'Button pressed. Password length: '
          '${_passwordController.text.length}, checked: $_checkboxValue';
    });
  }

  Widget _buildStatChip(IconData icon, String label, Color bgColor) {
    return ColoredBox(
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(),
        const Row(
          children: [
            Icon(Icons.person_outline),
            SizedBox(width: 8),
            Text('User Profile'),
          ],
        ),
        const Divider(),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipOval(
                  child: ColoredBox(
                    color: Colors.blue.shade100,
                    child: const SizedBox(
                      width: 48,
                      height: 48,
                      child: Icon(Icons.person, size: 32),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jane Doe'),
                    Row(
                      children: [
                        FlutterLogo(size: 16),
                        SizedBox(width: 4),
                        Text('Flutter Developer'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatChip(Icons.star, '42 Stars', Colors.amber.shade50),
            _buildStatChip(Icons.bar_chart, '7 PRs', Colors.green.shade50),
            _buildStatChip(Icons.check_circle, '18 Commits', Colors.blue.shade50),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: CustomPaint(painter: _ActivityChartPainter()),
        ),
        const Text('Activity this week'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'This is a demo screen with several widgets.',
              style: TextStyle(fontSize: 16),
              semanticsLabel: 'Intro text',
            ),
            const SizedBox(height: 16),
            Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
              semanticLabel: 'Owl photo',
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 150,
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Text('Image failed to load'),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('I agree to the demo terms'),
              value: _checkboxValue,
              onChanged: (value) {
                setState(() {
                  _checkboxValue = value ?? false;
                });
              },
            ),
            const SizedBox(height: 8),
            const Text('Plan:', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile<String>(
              title: const Text('Free plan'),
              value: 'free',
              groupValue: _plan,
              onChanged: (value) => setState(() => _plan = value ?? _plan),
            ),
            RadioListTile<String>(
              title: const Text('Pro plan'),
              value: 'pro',
              groupValue: _plan,
              onChanged: (value) => setState(() => _plan = value ?? _plan),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _onButtonPressed,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 8),
            // Repro for mobilewright#343: a widget Key only lives in the Dart
            // widget tree, never in the platform accessibility tree.
            ElevatedButton(
              key: const Key('key-only-button'),
              onPressed: () => setState(() => _status = 'Key-only pressed'),
              child: const Text('Key only'),
            ),
            const SizedBox(height: 8),
            Semantics(
              identifier: 'semantics-id-button',
              child: ElevatedButton(
                key: const Key('different-key-button'),
                onPressed: () => setState(() => _status = 'Key+semantics pressed'),
                child: const Text('Key and Semantics'),
              ),
            ),
            const SizedBox(height: 8),
            // Repro for mobilewright#234: an icon-only clickable child (no
            // text/label) inside a labeled, clickable parent row. UiAutomator
            // reports the "+" as NAF="true" with empty text/content-desc.
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Premium package (qty: $_quantity)'),
                  InkWell(
                    onTap: () => setState(() => _quantity++),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(_status),
            const SizedBox(height: 16),
            const Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _items.length,
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.label),
                title: Text(_items[index]),
              ),
            ),
            _buildProfileBlock(),
          ],
        ),
      ),
    );
  }
}
