/*
 *
 *  * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 *  * @author     : Gaurav Negi
 *  * All Rights Reserved.
 *  * Proprietary and confidential :  All information contained herein is, and remains
 *  * the property of Henceforth Pvt. Ltd. and its partners.
 *  * Unauthorized copying of this file, via any medium is strictly prohibited.
 *  *
 *
 */

import '../../../export.dart';

class ChatHistoryController extends GetxController {
  TextEditingController yearController=TextEditingController();
  FocusNode yearFocusNode=FocusNode();

  TextEditingController monthTypeController=TextEditingController();
  FocusNode monthTypeFocusNode=FocusNode();

  String selectedYear='2023';
  List<String> yearList = [];

  String selectedMonth='All month';
  List<String> monthList = ["All month", "Jan","Feb","Mar","April","May","June","July","August","September","Oct","Nov","Dec"];

  @override
  void onInit() {
    _yearlyDataAdd();
    super.onInit();
  }

  _yearlyDataAdd(){
    var currentYear=yearFormat();
    for(int i=0;i<10;i++){
      yearList.add((int.parse(currentYear.toString()) - i).toString());
    }

  }



}