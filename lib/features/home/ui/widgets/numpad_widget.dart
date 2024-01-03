import 'package:cashenya_app/dependencies.dart';
import 'package:cashenya_app/features/home/cubit/amount_input_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NumpadWidget extends StatelessWidget {
  const NumpadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final amountInputCubit = getIt<AmountInputCubit>();

    final themeData = Theme.of(context);

    final enabledEnterButtonTheme = themeData.elevatedButtonTheme.style!.copyWith(
      backgroundColor: MaterialStatePropertyAll(themeData.colorScheme.primary),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            color: Color(0xFF1E2025),
            width: 3,
          ),
        ),
      ),
    );
    final disabledEnterButtonTheme = themeData.elevatedButtonTheme.style!.copyWith(
      backgroundColor: const MaterialStatePropertyAll(
        Color(0xFF1E2025),
      ),
      overlayColor: MaterialStatePropertyAll(
        Color.lerp(themeData.colorScheme.primary, Colors.black, .25),
      ),
      foregroundColor: MaterialStatePropertyAll(
        themeData.colorScheme.onPrimary.withOpacity(.5),
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    return StaggeredGrid.count(
      axisDirection: AxisDirection.down,
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '7'),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '8'),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '9'),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: ElevatedButton(
            child: const Icon(
              Icons.backspace_outlined,
              size: 30,
            ),
            onPressed: () => amountInputCubit.removeLastSymbol(),
          ),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '4'),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '5'),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '6'),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 3,
          child: BlocBuilder<AmountInputCubit, AmountInputState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: state.status == AmountInputStatus.valid ? () => amountInputCubit.addTransaction() : null,
                style: state.status == AmountInputStatus.valid ? enabledEnterButtonTheme : disabledEnterButtonTheme,
                child: const Icon(
                  Icons.keyboard_return_rounded,
                  size: 25,
                ),
              );
            },
          ),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '1'),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '2'),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '3'),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: InputButton(text: '0'),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '.'),
        ),
      ],
    );
  }
}

class InputButton extends StatelessWidget {
  final String text;
  const InputButton({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    final amountInputCubit = context.read<AmountInputCubit>();
    return ElevatedButton(
      onPressed: () {
        amountInputCubit.appendSymbol(text);
      },
      child: Text(
        text,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
      ),
    );
  }
}
