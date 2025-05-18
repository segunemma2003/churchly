import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  /// Create a new instance of the MaterialApp
  static MaterialApp app() {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _backgroundController;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _fadeAnimation;
  bool _disposed = false; // Flag to track disposal state

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.transparent,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeInOut,
    ));

    // Safe delayed animation with mount check
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Future.delayed(Duration(milliseconds: 800), () {
          if (!_disposed && mounted) {
            // Safety check before calling forward
            _backgroundController.forward();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _disposed = true; // Set the flag before disposing
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient image (second splash screen)
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                // Use standard Image.asset
                image: AssetImage("background.png").localAsset(),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // White overlay that fades out (first splash screen)
          AnimatedBuilder(
            animation: _backgroundController,
            builder: (context, child) {
              return Container(
                color: _colorAnimation.value,
              );
            },
          ),

          // Logo and loader for both states
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo container with space for both logos
                SizedBox(
                  height: 80, // Adjust height as needed
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // First logo (visible on white background)
                      AnimatedBuilder(
                        animation: _backgroundController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: 1 - _fadeAnimation.value,
                            child: Image.asset(
                              "logoblack.png",
                              height: 60, // Adjust as needed
                            ).localAsset(),
                          );
                        },
                      ),

                      // Second logo (visible on gradient background)
                      AnimatedBuilder(
                        animation: _backgroundController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeAnimation.value,
                            child: Image.asset(
                              "logowhite.png",
                              height: 60, // Adjust as needed
                            ).localAsset(),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Tagline text
                AnimatedBuilder(
                  animation: _backgroundController,
                  builder: (context, child) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Spread Love to the world',
                        style: TextStyle(
                          color: _backgroundController.value > 0.5
                              ? Colors.white
                              : Colors.blue[900],
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 50),

                // Animated loader with color transition
                AnimatedBuilder(
                  animation: _backgroundController,
                  builder: (context, child) {
                    // Transition from blue to white loader
                    final Color loaderColor = Color.lerp(
                      Colors.blue[900], // Initial color (for white background)
                      Colors.white, // Final color (for blue background)
                      _fadeAnimation.value,
                    )!;

                    return AnimatedLoader(color: loaderColor);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedLoader extends StatefulWidget {
  final double size;
  final Color color;

  const AnimatedLoader({
    super.key,
    this.size = 50.0,
    this.color = Colors.blue,
  });

  @override
  createState() => _AnimatedLoaderState();
}

class _AnimatedLoaderState extends State<AnimatedLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _disposed = false; // Flag to track disposal state

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _disposed = true; // Set the flag before disposing
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            _buildPulsatingCircle(),
            _buildRotatingDots(),
          ],
        );
      },
    );
  }

  Widget _buildPulsatingCircle() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildRotatingDots() {
    if (_disposed) return Container(); // Safety check

    return Transform.rotate(
      angle: _controller.value * 2 * pi,
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(8, (index) {
          final double angle = (index / 8) * 2 * pi;
          final double offset = widget.size * 0.35;
          return Transform(
            transform: Matrix4.identity()
              ..translate(
                offset * cos(angle),
                offset * sin(angle),
              ),
            child: _buildDot(index),
          );
        }),
      ),
    );
  }

  Widget _buildDot(int index) {
    final double dotSize = widget.size * 0.1;
    final double scaleFactor =
        0.5 + (1 - _controller.value + index / 8) % 1 * 0.5;
    return Transform.scale(
      scale: scaleFactor,
      child: Container(
        width: dotSize,
        height: dotSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
        ),
      ),
    );
  }
}
