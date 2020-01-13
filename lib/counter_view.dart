import 'package:flutter/material.dart';
import 'package:flutter_architecture_example/counter_viewmodel.dart';
import 'package:provider_architecture/provider_architecture.dart';

// Since the state was moved to the view model, this is now a StatelessWidget.
class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ViewModelProvider is what provides the view model to the widget tree.
    return ViewModelProvider<CounterViewModel>.withConsumer(
      viewModel: CounterViewModel(),
      onModelReady: (model) => model.loadData(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo Home Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '${model.counter}', //                           <-- view model
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.increment(); //                                <-- view model
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
