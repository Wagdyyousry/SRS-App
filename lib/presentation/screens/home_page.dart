import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srs_system/data/controllers/user_controller.dart';
import 'signin_screen.dart';
import '../widgets/appBar_widget.dart';
import '../widgets/common/custom_dropdown_menu.dart';
import '../widgets/common/custom_listview.dart';
import '../widgets/common/custom_search_bar.dart';
import '../widgets/specialist_view.dart';
import '../../data/models/specialist_model.dart';
import '../../data/controllers/specialists_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RxList<SpecialistModel> specToShow = <SpecialistModel>[].obs;
  late final SpecialistsController controller;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpecialistsController());
    Get.put(UserController());
    specToShow.value = controller.allSpecialists;
    return Scaffold(
      appBar: AppBarWidget(
        title: "SRS-App",
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Get.offAll(() => SignInScreen());
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            // -- Search for specialists
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CustomSearchBar(
                    onChanged: (query) async {
                      await controller.filterSpecialists(query);
                      specToShow.value = controller.searchedSpecialists;
                    },
                  ),
                ),
                SizedBox(width: 8),
                // -- Filtering
                Expanded(
                  flex: 1,
                  child: CustomDropDownMenu(
                    onChanged: (filter) {
                      if (filter == "Name") {
                        specToShow.value =
                            List.from(controller.filterSpecialistsName);
                      } else if (filter == "Category") {
                        specToShow.value =
                            List.from(controller.filterSpecialistsCategory);
                      }
                    },
                    items: const ["Name", "Category"],
                    hint: "F",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // -- Specialists List
            Obx(
              () => specToShow.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : CustomListView(
                      scroll: false,
                      separatorBuilder: (context, index) => SizedBox(height: 5),
                      itemCount: specToShow.length,
                      itemBuilder: (context, index) {
                        final specialist = specToShow[index];
                        return SpecialistView(specialist: specialist);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void makeSomeSpecialist() async {
    List<SpecialistModel> list = [
      SpecialistModel(
        name: 'Dr.Ali',
        email: "ali@gmail.com",
        password: "ali2942000@",
        phoneNumber: "0112546889",
        specialistId: DateTime.now().millisecondsSinceEpoch.toString(),
        profileImageUri: "",
        specialization: "Doctor",
        bio: "Don`t Wait to ask as any thing",
        availability: {
          "Saturday": ["09:00", "12:00"],
          "Sunday": ["09:00", "12:00"],
          "Monday": ["11:00", "15:00"],
          "Tuesday": ["11:00", "15:00"],
          "Wednesday": ["11:00", "15:00"],
          "Thursday": ["15:00", "16:00"],
          "Friday": ["15:00", "16:00"],
        },
      ),
      SpecialistModel(
        name: 'Cap.Ahmed',
        email: "ahmed@gmail.com",
        password: "12345678",
        phoneNumber: "0112546889",
        specialistId: DateTime.now().millisecondsSinceEpoch.toString(),
        profileImageUri: "",
        specialization: "Captin",
        bio: "Don`t Wait to ask as any thing",
        availability: {
          "Sunday": ["09:00", "12:00"],
          "Monday": ["11:00", "15:00"],
          "Thursday": ["15:00", "16:00"]
        },
      ),
      SpecialistModel(
        name: 'Dr.Ahmed',
        email: "ahmed@gmail.com",
        password: "12345678",
        phoneNumber: "0112546889",
        specialistId: DateTime.now().millisecondsSinceEpoch.toString(),
        profileImageUri: "",
        specialization: "Doctor",
        bio: "Don`t Wait to ask as any thing",
        availability: {
          "Sunday": ["09:00", "12:00"],
          "Monday": ["11:00", "15:00"],
          "Thursday": ["15:00", "16:00"]
        },
      ),
      SpecialistModel(
        name: 'mr.Sayed Ali',
        email: "sayed@gmail.com",
        password: "12345678",
        phoneNumber: "0112546889",
        specialistId: DateTime.now().millisecondsSinceEpoch.toString(),
        profileImageUri: "",
        specialization: "Consultant",
        bio: "Don`t Wait to ask as any thing",
        availability: {
          "Sunday": ["09:00", "12:00"],
          "Monday": ["11:00", "15:00"],
          "Thursday": ["15:00", "16:00"]
        },
      ),
      SpecialistModel(
        name: 'Eng.Essam',
        email: "essam@gmail.com",
        password: "12345678",
        phoneNumber: "0112546889",
        specialistId: DateTime.now().millisecondsSinceEpoch.toString(),
        profileImageUri: "",
        specialization: "Engineer",
        bio: "Don`t Wait to ask as any thing",
        availability: {
          "Sunday": ["09:00", "12:00"],
          "Monday": ["11:00", "15:00"],
          "Thursday": ["15:00", "16:00"]
        },
      ),
      SpecialistModel(
        name: 'mr.Mohammad',
        email: "mohammad@gmail.com",
        password: "12345678",
        phoneNumber: "0112546889",
        specialistId: DateTime.now().millisecondsSinceEpoch.toString(),
        profileImageUri: "",
        specialization: "Lowyer",
        bio: "Don`t Wait to ask as any thing",
        availability: {
          "Sunday": ["09:00", "12:00"],
          "Monday": ["11:00", "15:00"],
          "Thursday": ["15:00", "16:00"]
        },
      ),
    ];

    final database = FirebaseFirestore.instance;
    for (var spec in list) {
      database
          .collection("Specialists")
          .doc(spec.specialistId)
          .set(spec.toMap());
    }
  }
}
