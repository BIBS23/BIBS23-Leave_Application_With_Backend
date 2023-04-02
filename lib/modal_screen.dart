import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sjcet_leave/icons.dart/icons.dart';
import 'package:sjcet_leave/provider/access_storage.dart';
import 'package:sjcet_leave/provider/detailsControllers.dart';
import 'package:sjcet_leave/utils/leave_tile.dart';
import 'package:sjcet_leave/utils/text_field.dart';

class ApplyLeave {
  static Future modalScreen(BuildContext context, bool needAccess) async {
    final TextEditingController name = TextEditingController();
    final TextEditingController rollno = TextEditingController();
    final TextEditingController branch = TextEditingController();
    final TextEditingController reason = TextEditingController();
    return showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Scaffold(
              primary: true,
              appBar: AppBar(
                title: const Text('Apply For Leave',
                    style: TextStyle(fontSize: 16, letterSpacing: 6)),
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();
                    },
                    icon: const Icon(Icons.close)),
              ),
              backgroundColor: Colors.grey.shade200,
              body: Consumer2<AccessStorage, DetailsController>(
                  builder: (context, access, details, child) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFields(
                            hint: 'Name',
                            maxlines: 1,
                            fieldheight: 50,
                            myController: name),
                        TextFields(
                          hint: 'Branch',
                          maxlines: 1,
                          fieldheight: 50,
                          myController: branch,
                        ),
                        TextFields(
                          hint: 'Rollno',
                          maxlines: 1,
                          fieldheight: 50,
                          myController: rollno,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.white,
                            child: TextFormField(
                              controller: reason,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 10, top: 10),
                                  hintText: 'Your Reason',
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        needAccess
                            ? Text('Upload Details',
                                style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 6,
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.bold))
                            : const SizedBox(),
                        const SizedBox(height: 20),
                        if (needAccess)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MyIcons(
                                  iconImage: 'assets/cam.png',
                                  onTap: () {
                                    access
                                        .chooseFromStorage(ImageSource.camera);
                                    access.getAccess(context);
                                  }),
                              MyIcons(
                                  iconImage: 'assets/upload.png',
                                  onTap: () {
                                    access
                                        .chooseFromStorage(ImageSource.gallery);
                                    access.getAccess(context);
                                  })
                            ],
                          ),
                        TextButton(
                            onPressed: () {
                              details.getDetails(name.text, branch.text,
                                  rollno.text, reason.text, '');
                              if (name.text =='' ||
                                  branch.text == '' ||
                                  reason.text == '' ||
                                  rollno.text == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Every field is required')));
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Apply')),
                      ],
                    ),
                  ),
                );
              }));
        });
  }
}
