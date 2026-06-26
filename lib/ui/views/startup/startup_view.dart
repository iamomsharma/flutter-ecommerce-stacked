import 'package:flutter/material.dart';
import 'package:myshop/ui/views/startup/startup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

  @override
  void onViewModelReady(StartupViewModel viewModel) {
    viewModel.runStartupLogic();
  }

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();
}
