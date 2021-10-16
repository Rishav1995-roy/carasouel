import 'package:carasouel/providers.dart';
import 'package:carasouel/repository.dart';
import 'package:carasouel/userModel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';


final repositoryProvider = Provider.autoDispose((ref) => Repository(ref.read));

final viewModelProvider = ChangeNotifierProvider.autoDispose<ViewModel>(
        (ref){
      ref.maintainState = true;
      return ViewModel(ref: ref);
    });

class ViewModel extends ChangeNotifier{

  late Logger logger;
  ProviderReference ref;
  late Repository repo;
  List<Results> results = [];
  bool isLoading = false;

  ViewModel({required this.ref}) {
    repo = ref.read(repositoryProvider);
    logger = ref.read(loggerProvider);
  }

  Future<void> getResults() async{
    try{
      isLoading=true;
      notifyListeners();
      results=(await repo.getResults())!;
    }catch(e){
      isLoading=false;
      results=[];
      logger.e(e);
    }finally{
      isLoading=false;
      notifyListeners();
    }
  }

}