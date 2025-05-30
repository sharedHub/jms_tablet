import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/catalogue_bloc.dart';
import '../repository/cart_repository.dart';
import '../repository/category_repository.dart';
import 'catalogue_screen.dart';

class CataloguePage extends StatelessWidget {
  const CataloguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CatalogueBloc(
        repository: CatalogueRepository(),
        cartRepository: CartRepository(),
      )..add(LoadCatalogueItems(page: 0, itemsPerPage: 10))
        ..add(LoadCart()),
      child: CatalogueScreen(),
    );
  }
}