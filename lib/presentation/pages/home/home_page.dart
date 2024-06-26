import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constant.dart';
import '../../../domain/usecase/display/display.usecase.dart';
import '../../../service_locator.dart';
import '../main/cubit/mall_typ_cubit.dart';
import 'bloc/menu_bloc/menu_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MallTypeCubit, MallType>(
      builder: (_, state) {
        return BlocProvider(
          create: (_) => MenuBloc(locator<DisplayUsecase>())
            ..add(MenuInitialized(mallType: state)),
          child: const HomePageView(),
        );
      },
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MallTypeCubit, MallType>(
      listener: (context, state) => context.read<MenuBloc>().add(
            MenuInitialized(
              mallType: state,
            ),
          ),
      listenWhen: (prev, curr) => prev.index != curr.index,
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (_, state) {
          switch (state.status) {
            case Status.initial:
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case Status.success:
              return Center(
                child: Text('${state.menus}'),
              );

            case Status.error:
              return Center(
                child: Text('error'),
              );
          }
        },
      ),
    );
  }
}
