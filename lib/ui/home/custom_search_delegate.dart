import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golab/const/keyword_list.dart';
import 'package:golab/model/model_search_result.dart';

Future<T?> showCustomSearch<T>({
  required BuildContext context,
  required CustomSearchDelegate<T> delegate,
  String? query = '',
}) {
  assert(delegate != null);
  assert(context != null);
  delegate.query = query ?? delegate.query;
  return Navigator.of(context).push(_SearchPageRoute<T>(
    delegate: delegate,
  ));
}

abstract class CustomSearchDelegate<T> {

  CustomSearchDelegate({
    this.keyboardType,
    this.textInputAction = TextInputAction.search,
  });

  Widget buildCustomSuggestions(BuildContext context);

  Widget buildFeatures(BuildContext context);

  Widget buildFieldsOfStudy(BuildContext context);

  Widget buildCustomBackButton(BuildContext context);

  String get query => _queryTextController.text;
  set query(String value) {
    assert(query != null);
    _queryTextController.text = value;
  }

  void showCustomResults(BuildContext context, SearchResult result) {
    _focusNode?.unfocus();
    Navigator.of(context)
      ..popUntil((Route<dynamic> route) => route == _route)
      ..pop(result);
  }

  void close(BuildContext context, SearchResult result) {
    _focusNode?.unfocus();
    Navigator.of(context)
      ..popUntil((Route<dynamic> route) => route == _route)
      ..pop(result);
  }

  final TextInputType? keyboardType;

  final TextInputAction textInputAction;

  Animation<double> get transitionAnimation => _proxyAnimation;

  FocusNode? _focusNode;

  final TextEditingController _queryTextController = TextEditingController();

  final ProxyAnimation _proxyAnimation = ProxyAnimation(kAlwaysDismissedAnimation);

  _SearchPageRoute<T>? _route;
}

class _SearchPageRoute<T> extends PageRoute<T> {
  _SearchPageRoute({
    required this.delegate,
  }) : assert(delegate != null) {
    assert(
    delegate._route == null,
    'The ${delegate.runtimeType} instance is currently used by another active '
        'search. Please close that search by calling close() on the SearchDelegate '
        'before opening another search with the same delegate instance.',
    );
    delegate._route = this;
  }

  final CustomSearchDelegate<T> delegate;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => false;

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  Animation<double> createAnimation() {
    final Animation<double> animation = super.createAnimation();
    delegate._proxyAnimation.parent = animation;
    return animation;
  }

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    return _SearchPage<T>(
      delegate: delegate,
      animation: animation,
    );
  }

  @override
  void didComplete(T? result) {
    super.didComplete(result);
    assert(delegate._route == this);
    delegate._route = null;
  }
}

class _SearchPage<T> extends StatefulWidget {
  const _SearchPage({
    required this.delegate,
    required this.animation,
  });

  final CustomSearchDelegate<T> delegate;
  final Animation<double> animation;

  @override
  State<StatefulWidget> createState() => _SearchPageState<T>();
}

class _SearchPageState<T> extends State<_SearchPage<T>> {

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.delegate._queryTextController.addListener(_onQueryChanged);
    widget.animation.addStatusListener(_onAnimationStatusChanged);
    widget.delegate._focusNode = focusNode;
  }

  @override
  void dispose() {
    super.dispose();
    widget.delegate._queryTextController.removeListener(_onQueryChanged);
    widget.animation.removeStatusListener(_onAnimationStatusChanged);
    widget.delegate._focusNode = null;
    focusNode.dispose();
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status != AnimationStatus.completed) {
      return;
    }
    widget.animation.removeStatusListener(_onAnimationStatusChanged);
    focusNode.requestFocus();
  }

  @override
  void didUpdateWidget(_SearchPage<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.delegate != oldWidget.delegate) {
      oldWidget.delegate._queryTextController.removeListener(_onQueryChanged);
      widget.delegate._queryTextController.addListener(_onQueryChanged);
      oldWidget.delegate._focusNode = null;
      widget.delegate._focusNode = focusNode;
    }
  }

  void _onQueryChanged() {
    setState(() {
      // rebuild ourselves because query changed.
    });
  }

  @override
  Widget build(BuildContext context){
    assert(debugCheckHasMaterialLocalizations(context));

    return Scaffold(
        body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const SizedBox(height: 15),
                Container(
                  height: 50,
                  decoration: BoxDecoration(color: const Color.fromRGBO(230, 230, 230, 100),borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      const Icon(Icons.search,color: Color.fromRGBO(150, 150, 150, 100)),
                      const SizedBox(width: 5),
                      Flexible(
                          child: TextField(
                            controller: widget.delegate._queryTextController,
                            focusNode: focusNode,
                            textInputAction: widget.delegate.textInputAction,
                            keyboardType: widget.delegate.keyboardType,
                            onSubmitted: (String _searchKeyword){
                              final int index = ResearchKeywords.keywords.indexOf(_searchKeyword);
                              widget.delegate.showCustomResults(
                                  context,
                                  SearchResult(index: index, fields: [], features: [])
                              );
                            },
                            decoration: const InputDecoration(
                                hintText: 'Search...',
                                border: InputBorder.none
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Text('Suggestion',style: TextStyle(color: Colors.black54,fontSize: 18,fontWeight: FontWeight.bold)),
                widget.delegate.buildCustomSuggestions(context),
                const Divider(thickness: 1),
                const SizedBox(height: 15),
                const Text('Features',style: TextStyle(color: Colors.black54,fontSize: 18,fontWeight: FontWeight.bold)),
                widget.delegate.buildFeatures(context),
                const Divider(thickness: 1),
                const SizedBox(height: 15),
                const Text('Fields of Study',style: TextStyle(color: Colors.black54,fontSize: 18,fontWeight: FontWeight.bold)),
                widget.delegate.buildFieldsOfStudy(context),
                widget.delegate.buildCustomBackButton(context),
              ],
            )
        )
    );
  }
}


