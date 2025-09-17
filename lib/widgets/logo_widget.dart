import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final bool showText;

  const LogoWidget({
    Key? key,
    this.width,
    this.height,
    this.color,
    this.showText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 200,
      height: height ?? 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo principal
          Image.asset(
            'assets/images/Logo Lait et miel slogan vtc et loçcation de vehicules(2).svg',
            width: width ?? 200,
            height: height != null ? height! * 0.8 : 64,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // Fallback vers le logo JPG si le SVG ne fonctionne pas
              return Image.asset(
                'assets/images/Logo.jpg',
                width: width ?? 200,
                height: height != null ? height! * 0.8 : 64,
                fit: BoxFit.contain,
              );
            },
          ),
          if (showText) ...[
            const SizedBox(height: 8),
            Text(
              'Lait et Miel',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color ?? Theme.of(context).primaryColor,
              ),
            ),
            Text(
              'VTC & Location de véhicules',
              style: TextStyle(
                fontSize: 12,
                color: color ?? Theme.of(context).primaryColor.withOpacity(0.8),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class LogoIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const LogoIcon({
    Key? key,
    this.size = 40,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Image.asset(
        'assets/images/LOGO.svg',
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/Logo.jpg',
            width: size,
            height: size,
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }
}
