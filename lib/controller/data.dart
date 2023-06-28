class DummyData {
  String name;
  String image;
  String deliveryTime;
  String price;
  String phone;
  String tag;

  DummyData(
      {required this.name,
      required this.image,
      required this.phone,
      required this.deliveryTime,
      required this.price,
      required this.tag});
}

List<DummyData> datas = [
  DummyData(
      name: "Pick",
      image: "lib/assets/001.jpg",
      phone: '155226688',
      deliveryTime: "24",
      price: "free",
      tag: "FOOD"),
  DummyData(
      name: "McDonald's",
      image: "lib/assets/002.jpg",
      phone: '188956546',
      deliveryTime: "32",
      price: "1.000",
      tag: "FOOD"),
  DummyData(
      name: "Pizza ",
      image: "lib/assets/003.jpg",
      phone: '188956546',
      deliveryTime: "32",
      price: "1.350",
      tag: "FOOD"),
];
