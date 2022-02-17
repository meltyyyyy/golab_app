import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golab/model/model_lab.dart';
import 'package:golab/model/model_lab_list.dart';
import 'package:golab/model/model_search_result.dart';
import 'package:golab/repository/repository_lablist.dart';
import 'package:state_notifier/state_notifier.dart';

class LabListViewModel extends StateNotifier<LabListState> with LocatorMixin {
  LabListViewModel() : super(const LabListState()) { getLabList(); }

  LabListRepository get labListRepository => read<LabListRepository>();

  Future<void> getLabList() async {
    state = state.copyWith(isLoading: true);
    try{
      List<Lab> _labList = await LabListRepository.fetchLabList();
      state = state.copyWith(labList: _labList);
      state = state.copyWith(isLoading: false);
    } catch(e) {
      print(e);
    }
  }

  Future<void> search(SearchResult result) async {
    state = state.copyWith(isLoading: true);
    try{
      List<Lab> _labList = await  LabListRepository.queryLabList(result);
      state = state.copyWith(labList: _labList);
      state = state.copyWith(isLoading: false);
    } catch(e){
      print(e);
    }
  }
}