import 'package:flutter/material.dart';
import 'package:products_rest/http/exceptions.dart';
import 'package:products_rest/models/produto_model.dart';
import 'package:products_rest/repositories/produto_repository.dart';

class ProdutoStore {
  final IProdutoRepository repository;

  // reativa para loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // reativa para o state
  final ValueNotifier<List<ProdutoModel>> state =
      ValueNotifier<List<ProdutoModel>>([]);

  // reativa para erro
  final ValueNotifier<String> error = ValueNotifier<String>('');

  ProdutoStore({required this.repository});

  Future getProdutos() async {
    try {
      final result = await this.repository.getProdutos();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
