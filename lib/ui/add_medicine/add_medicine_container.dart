import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/redux/add_medicine/add_medicine_action.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/ui/add_medicine/add_medicine_screen.dart';
import 'package:medical_app/ui/medicine_detail/medicine_detail_container.dart';
import 'package:medical_app/ui/medicine_detail/medicine_detail_screen.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_container.dart';
import 'package:redux/redux.dart';

class AddMedicineContainer extends StatefulWidget {
  @override
  _AddMedicineContainerState createState() => _AddMedicineContainerState();
}

class _AddMedicineContainerState extends State<AddMedicineContainer> {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel viewmodel) {
        return new AddMedicineScreen(
          onAddMedicine: viewmodel.onAddMedicine,
          loadingStatus: viewmodel.loadingStatus,
        );
      },
    );
  }
}

class ViewModel {
  final Function(BuildContext, Medicine) onAddMedicine;
  final LoadingStatus loadingStatus;

  ViewModel({
    this.onAddMedicine,
    this.loadingStatus,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      onAddMedicine: (BuildContext context, Medicine medicine) {
        final Completer<Null> completer = new Completer<Null>();

        store.dispatch(new AddMedicineAction(
          completer: completer,
          medicine: medicine,
        ));

        completer.future.then((_) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
            return MedicineDetailScreen(
              medicine: medicine,
            );
          }));

          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("เพิ่มข้อมูลสำเร็จ"),
            duration: Duration(seconds: 5),
            action: SnackBarAction(
                label: 'เข้าดู',
                onPressed: () {

                }),
          ));
        });
      },
      loadingStatus: store.state.addMedicinState.loadingState,
    );
  }
}
