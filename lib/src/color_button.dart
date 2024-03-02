// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ColorButton extends StatefulWidget {
  const ColorButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final Function(Color) onPressed;
  @override
  State<ColorButton> createState() => _ColorButtonState();
}

class _ColorButtonState extends State<ColorButton> {
  ValueNotifier<Color> selectedColor = ValueNotifier(Colors.purple);
  ValueNotifier<bool> isOpened = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ValueListenableBuilder<bool>(
          valueListenable: isOpened,
          builder: (context, isOpenedValue, _) {
            return SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _ColorButtonWidget(
                      color: selectedColor.value,
                      onPressed: () {
                        isOpened.value = true;
                      },
                    );
                  }
                  return SizedBox(
                    width: 45,
                    child: _ColorButtonWidget(
                      color: colors[index],
                      onPressed: () {
                        selectedColor.value = colors[index];
                        isOpened.value = false;
                        widget.onPressed.call(selectedColor.value);
                      },
                    ),
                  );
                },
                itemCount: isOpenedValue ? colors.length : 1,
              ),
            );
          }),
    );
  }
}

class _ColorButtonWidget extends StatelessWidget {
  const _ColorButtonWidget({
    Key? key,
    required this.onPressed,
    required this.color,
  }) : super(key: key);
  final VoidCallback onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: SizedBox(
              width: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final List<Color> colors = [
  Colors.amber,
  Colors.blue,
  Colors.cyan,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.green,
  Colors.indigo,
  Colors.lightBlue,
  Colors.lime,
  Colors.orange,
  Colors.pink,
  Colors.purple,
  Colors.red,
  Colors.teal,
  Colors.yellow,
  // Daha fazla renk ekleyebilirsiniz.
];
