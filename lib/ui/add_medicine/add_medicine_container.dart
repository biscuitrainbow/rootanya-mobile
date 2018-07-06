import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/redux/add_medicine/add_medicine_action.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/ui/add_medicine/add_medicine_screen.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_container.dart';
import 'package:redux/redux.dart';

class AddMedicineContainer extends StatefulWidget {
  @override
  _AddMedicineContainerState createState() => _AddMedicineContainerState();
}

class _AddMedicineContainerState extends State<AddMedicineContainer> {
//  final TextEditingController barcodeController = new TextEditingController(text: '8-850769-005929');
//  final TextEditingController nameController = new TextEditingController(text: 'ซีแม็กซ์ เอสเอ็กซ์');
//  final TextEditingController ingredientController = new TextEditingController(text: 'สังกะสี 450 มก.แอลคาร์นิทีน 100 มก. นิโคตินาไมด์ 20 มก. ซีลีเนียม 70 มคก. วิตามินบี 1 1.5 มก. วิตามนบี 2 1.7 มก. ไบโอติน 0.15 มก.');
//  final TextEditingController categoryController = new TextEditingController(text: 'ผลิตภัณฑ์เสริมอาหาร บำรุงร่างกาย');
//  final TextEditingController typeController = new TextEditingController(text: 'แคปซูล');
//  final TextEditingController forController = new TextEditingController(text: 'ผลิตภัณฑ์เสริมอาหารวิตามิน,เกลือแร่และแอลคาร์นิทีน บำรุงร่างกายผู้ชาย เสริมสร้างกล้ามเนื้อ');
//  final TextEditingController howController = new TextEditingController(text: 'วันละ 1 แคปซูล ก่อนนอน และไม่ควรทานพร้อมนม');
//  final TextEditingController warningController = new TextEditingController(text: 'เด็กและสตรีมีครรภ์ไม่ควรรับประทาน ไม่มีผลในการป้องกัน หรือรักษาโรค');
//  final TextEditingController keepingController = new TextEditingController(text: 'การบำรุงรักษา');
//  final TextEditingController forgetController = new TextEditingController(text: 'ใช้ทันทีที่นึกได้ หรือถ้าใกล้กับการใช้ครั้งต่อไป ให้ใช้ครั้งต่อไปตามปกติโดยไม่ต้องเพิ่มขนาด');

  final TextEditingController barcodeController = new TextEditingController(text: '');
  final TextEditingController nameController = new TextEditingController(text: '');
  final TextEditingController ingredientController = new TextEditingController(text: '');
  final TextEditingController categoryController = new TextEditingController(text: ' ');
  final TextEditingController typeController = new TextEditingController(text: '');
  final TextEditingController forController = new TextEditingController(text: '');
  final TextEditingController howController = new TextEditingController(text: '');
  final TextEditingController warningController = new TextEditingController(text: '');
  final TextEditingController keepingController = new TextEditingController(text: '');
  final TextEditingController forgetController = new TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel viewmodel) {
        return new AddMedicineScreen(
          barcodeController: barcodeController,
          nameController: nameController,
          ingredientController: ingredientController,
          categoryController: categoryController,
          typeController: typeController,
          forController: forController,
          howController: howController,
          warningController: warningController,
          keepingController: keepingController,
          forgetController: forgetController,
          onAddMedicine: viewmodel.onAddMedicine,
          loadingStatus: viewmodel.loadingStatus,
        );
      },
    );
  }
}

class ViewModel {
  final Function(Medicine) onAddMedicine;
  final LoadingStatus loadingStatus;

  ViewModel({
    this.onAddMedicine,
    this.loadingStatus,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      onAddMedicine: (Medicine medicine) => store.dispatch(
            new AddMedicineAction(
              medicine: medicine,
            ),
          ),
      loadingStatus: store.state.addMedicinState.loadingState,
    );
  }
}
