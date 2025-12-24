import '../../../../../core/models/user_model.dart';
import '../post_model.dart';

extension FakePost on PostModel {
  static PostModel fake() {
    return PostModel(
      content: "Loading content ...",
      user: User(
        firstName: "Loading",
        lastName: "User",
        email: "loading@email.com",
        avatar:
        "https://media.licdn.com/media/AAYQAQSOAAgAAQAAAAAAAB-zrMZEDXI2T62PSuT6kpB6qg.png",
        id: "123",
      ),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      id: "123",
      version: 0,
      isLiked: false,
      category: "",
      commentsCount: 1,
      likesCount: 1,
      mediaType: "",
      media: "https://scontent.faly8-1.fna.fbcdn.net/v/t39.30808-6/597213283_1427420052086235_5308060918472048206_n.jpg?stp=cp6_dst-jpg_tt6&_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_ohc=DHu2BimQmnwQ7kNvwGW1KWh&_nc_oc=Adnubvb6hwz0oQC-f4NLLLNMj924JPKji2pAHrqQkU6VKOKm78Ypd_v0XrSaLD9t2g8&_nc_zt=23&_nc_ht=scontent.faly8-1.fna&_nc_gid=DOTkSCrjYaGD0ou9HzFl_g&oh=00_AfmUc3eeFP2AcAHx4yrTOMIrYPkBzKhUytETfYwXFy4OcA&oe=694EBCB0",
    );
  }
}
