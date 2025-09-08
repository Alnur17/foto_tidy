import '../../common/app_images/app_images.dart';

class DummyData {

  static final List<Map<String, String>> activityHome = [
    {"type": "COPY", "title": "SAVE20 copied", "subtitle": "2 hours ago"},
    {"type": "VIEW", "title": "Checked Offer", "subtitle": "5 hours ago"},
    {"type": "COPY", "title": "WELCOME10 copied", "subtitle": "1 day ago"},
  ];

  static final List<Map<String, String>> notifications = [
    {
      "title": "New 20% off on Grofers!",
      "subtitle": "Use the code SAVE20 before 10 Aug",
      "time": "2h ago",
      "image": AppImages.giftBox,
    },
    {
      "title": "Flat 50% off on Zomato!",
      "subtitle": "Use the code ZOM50 today",
      "time": "5h ago",
      "image": AppImages.giftBox,
    },
    {
      "title": "Special Offer on Amazon",
      "subtitle": "Get ₹200 cashback on first order",
      "time": "1d ago",
      "image": AppImages.giftBox,
    },
  ];

  static final List<Map<String, String>> activityLogData = [
    {
      "storeName": "Amazon",
      "couponCode": "SAVE20NOW",
      "dateTime": "Aug 04, 3:12 PM",
      "status": "Viewed",
      "imagePath": AppImages.offerImage
    },
    {
      "storeName": "Nike",
      "couponCode": "SAVE20NOW",
      "dateTime": "Aug 04, 3:12 PM",
      "status": "Copied",
      "imagePath": AppImages.offerImage
    },
    {
      "storeName": "Myntra",
      "couponCode": "SAVE20NOW",
      "dateTime": "Aug 04, 3:12 PM",
      "status": "Viewed",
      "imagePath": AppImages.offerImage
    },
  ];


  static final List<Map<String, dynamic>> stores = [
    {
      "storeName": "Amazon",
      "couponCount": "12",
      "imagePath": AppImages.offerImage
    },
    {
      "storeName": "Uber Eats",
      "couponCount": "8",
      "imagePath": AppImages.offerImage
    },
    {
      "storeName": "Nike",
      "couponCount": "15",
      "imagePath": AppImages.offerImage
    },
    {
      "storeName": "Starbucks",
      "couponCount": "5",
      "imagePath": AppImages.offerImage
    },
    {
      "storeName": "Apple",
      "couponCount": "10",
      "imagePath": AppImages.offerImage
    }
  ];

  static final List<Map<String, dynamic>> offers = [
    {
      'title': '20% OFF Everything',
      'subtitle': 'Amazon',
      'image': AppImages.offerImage,
      'validTill': 'Aug 16, 2025',
      'usageCount': '2.3K',
      'isFavorite': true,
    },
    {
      'title': '50% OFF on Electronics',
      'subtitle': 'eBay',
      'image': AppImages.offerImage,
      'validTill': 'Sep 10, 2025',
      'usageCount': '1.5K',
      'isFavorite': false,
    },
    {
      'title': '10% OFF Grocery',
      'subtitle': 'Walmart',
      'image': AppImages.offerImage,
      'validTill': 'Oct 5, 2025',
      'usageCount': '3.1K',
      'isFavorite': false,
    },
  ];
  static final List<Map<String, String>> brands = [
    {'name': 'Nike', 'image': AppImages.offerImage},
    {'name': 'Adidas', 'image': AppImages.offerImage},
    {'name': 'Puma', 'image': AppImages.offerImage},
    {'name': 'Reebok', 'image': AppImages.offerImage},
    {'name': 'Zara', 'image': AppImages.offerImage},
    {'name': 'Zara', 'image': AppImages.offerImage},
    {'name': 'Zara', 'image': AppImages.offerImage},
    {'name': 'Zara', 'image': AppImages.offerImage},
  ];
}
