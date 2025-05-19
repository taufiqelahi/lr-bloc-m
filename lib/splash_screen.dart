import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: BackgroundPainter(),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.messenger,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'ChatMind',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ..._buildAvatars(context),
        ],
      ),
    );
  }

  List<Widget> _buildAvatars(BuildContext context) {
    return [
      _positionedAvatar(top: 80, left: 30, image: 'assets/man.png'),
      _positionedAvatar(top: 130, right: 30, image: 'assets/man.png'),
      _positionedAvatar(bottom: 130, left: 30, image: 'assets/man.png'),
      _positionedAvatar(bottom: 80, right: 30, image: 'assets/man.png'),
    ];
  }

  Widget _positionedAvatar({double? top, double? left, double? bottom, double? right, required String image}) {
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(2),
            child: ClipOval(
              child: Image.asset(
                image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}


class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final basePaint = Paint()
      ..color = const Color(0xFF00A888); // Base green
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), basePaint);

    // Gradient for wave shape
    final wavePath = Path()
      ..moveTo(0, size.height * 0.3)
      ..quadraticBezierTo(
          size.width * 0.5, size.height * 0.5, size.width, size.height * 0.2)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    final Rect gradientRect = Rect.fromLTWH(0, 0, size.width, size.height * 0.4);
    final gradientPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF00d123), // Light green
          Color(0xFF00C853), // Deeper green
        ],
      ).createShader(gradientRect);

    canvas.drawPath(wavePath, gradientPaint);

    // Concentric Circles
    final center = Offset(size.width / 2, size.height / 2);
    final circlePaint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (double radius = 80; radius < 300; radius += 40) {
      canvas.drawCircle(center, radius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

