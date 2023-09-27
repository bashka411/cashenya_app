import 'package:cashenya_app/screens/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NumpadWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  final HomeState homeState;
  const NumpadWidget(this.homeBloc, this.homeState, {super.key});

  @override
  Widget build(BuildContext context) {
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
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '7', homeBloc: homeBloc),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '8', homeBloc: homeBloc),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '9', homeBloc: homeBloc),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: ElevatedButton(
            child: const Icon(
              Icons.backspace_outlined,
              size: 30,
            ),
            onPressed: () => homeBloc.add(HomeInputSymbolRemovedEvent()),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '4', homeBloc: homeBloc),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '5', homeBloc: homeBloc),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '6', homeBloc: homeBloc),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 3,
          child: ElevatedButton(
            onPressed: () => homeBloc.add(HomeAddExpenseButtonClickedEvent()),
            style: homeState is HomeInputValueEnteredState ? enabledEnterButtonTheme : disabledEnterButtonTheme,
            child: const Icon(
              Icons.keyboard_return_rounded,
              size: 25,
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '1', homeBloc: homeBloc),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '2', homeBloc: homeBloc),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '3', homeBloc: homeBloc),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: InputButton(text: '0', homeBloc: homeBloc),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InputButton(text: '.', homeBloc: homeBloc),
        ),
      ],
    );
  }
}

class InputButton extends StatelessWidget {
  final String text;
  final HomeBloc homeBloc;
  const InputButton({required this.text, required this.homeBloc, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        homeBloc.add(
          HomeInputSymbolAddedEvent(text),
        );
      },
      child: Text(
        text,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
      ),
    );
  }
}
