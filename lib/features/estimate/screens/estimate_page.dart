import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../catalogue/bloc/catalogue_bloc.dart';
import '../../catalogue/repository/cart_repository.dart';
import '../../catalogue/repository/category_repository.dart';
import 'estimate_screen.dart';

class EstimatePage extends StatelessWidget {
  const EstimatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => CatalogueRepository()),
        RepositoryProvider(create: (_) => CartRepository()),
      ],
      child: BlocProvider(
        create: (context) => CatalogueBloc(
          repository: context.read<CatalogueRepository>(),
          cartRepository: context.read<CartRepository>(),
        )..add(LoadCatalogueItems(page: 0, itemsPerPage: 10))
          ..add(LoadCart()),
        child: const EstimateScreen(),
      ),
    );
  }
}