import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/screens/main_layout/cubit/main_cubit.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (context) => MainCubit(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return Scaffold(
            body: cubit.screensList[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items:cubit.bottomListItem,
              currentIndex: cubit.currentIndex,
              onTap: (int index)=>cubit.changeBottomNav(index),
            ),
            
          );
        },
      ),
    );
  }
}
