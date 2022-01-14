import 'package:pref_dessert/pref_dessert.dart';
import 'package:can_i_go_out/model/profile.dart';
import 'package:can_i_go_out/globals/main.dart';
import 'package:uuid/uuid.dart';

Future<bool> addProfile(name, birthDate, hasWork, workDays) async {
  var repo =
      new FuturePreferencesRepository<ProfileModel>(new ProfileModelDesSer());

  ProfileModel profileModel =
      new ProfileModel(Uuid().v4(), name, birthDate, hasWork, workDays);

  globalProfileModel = profileModel;
  repo.save(profileModel);
  return true;
}
