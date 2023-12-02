import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarCubit extends Cubit<int> {
  BottomNavBarCubit() : super(0); // Initialize with the first item selected

  // Function to change the selected index
  void updateSelectedIndex(int newIndex) => emit(newIndex);
}