// ignore: camel_case_types
import 'package:patient_observing/Repositrys/bed_repository.dart';

class listner {
  final BedRepository bedRepository;
  listner({required this.bedRepository});

  startListner() {
    bedRepository.get_nurse_patients("").listen((event) {
      
    });
  }
}
