import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tico_apps/constant.dart';
import 'package:intl/intl.dart';

Future<Map> modalCreateTask(
    BuildContext context, String school, String kelas) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: WHITE,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
    ),
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _ModalCreateTask(
          school: school,
          kelas: kelas,
        ),
      ),
    ),
  );
}

class _ModalCreateTask extends StatefulWidget {
  final String school;
  final String kelas;
  const _ModalCreateTask({this.school, this.kelas});

  @override
  State<_ModalCreateTask> createState() => __ModalCreateTaskState();
}

class __ModalCreateTaskState extends State<_ModalCreateTask> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime _date;

  void addData(String school, String kelas) {
    Timestamp timestamp = Timestamp.fromDate(_date);
    var map = new Map<String, dynamic>();
    map['judul'] = _judulController.text;
    map['deskripsi'] = _deskripsiController.text;
    map['waktu'] = timestamp.toDate();
    FirebaseFirestore.instance.collection('tugas').doc(school).set(
      {
        kelas: FieldValue.arrayUnion([map])
      },
      SetOptions(merge: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 10.0),
            child: TextFormField(
              controller: _judulController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Tambahkan kelas',
                border: OutlineInputBorder(
                  gapPadding: 10.0,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Harus Diisi';
                }
                return null;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: TextFormField(
              minLines: 4,
              maxLines: null,
              controller: _deskripsiController,
              decoration: InputDecoration(
                hintText: 'Tambahkan tugas',
                border: OutlineInputBorder(
                  gapPadding: 10.0,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Harus Diisi';
                }
                return null;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 40.0),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.number,
              controller: _dateController,
              decoration: InputDecoration(
                hintText: 'batas waktu',
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  gapPadding: 10.0,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Harus Diisi';
                }
                return null;
              },
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  theme: DatePickerTheme(
                    containerHeight: MediaQuery.of(context).size.height / 2,
                    itemHeight: MediaQuery.of(context).size.height / 8,
                    headerColor: LIGHT_BLUE,
                    backgroundColor: WHITE,
                    itemStyle: TextStyle(
                      color: BLACK,
                      fontWeight: FontWeight.bold,
                      // fontSize: 12.0,
                    ),
                    doneStyle: TextStyle(color: WHITE, fontSize: 16),
                    cancelStyle: TextStyle(color: WHITE, fontSize: 16),
                  ),
                  onConfirm: (time) {
                    var formatter = DateFormat('dd MM yyyy');
                    String formatted = formatter.format(time);
                    _dateController.text = formatted;
                    _date = time;
                  },
                  locale: LocaleType.id,
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              padding: EdgeInsets.all(16.0),
              color: LIGHT_BLUE,
              child:
                  Text('Submit', style: TextStyle(color: WHITE, fontSize: 16)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  addData(widget.school, widget.kelas);
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
