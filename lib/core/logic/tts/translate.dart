String translateInstruction(String text) {
  return text
  // الاتجاهات الأساسية
      .replaceAll("Head north", "اتجه شمالًا")
      .replaceAll("Head south", "اتجه جنوبًا")
      .replaceAll("Head east", "اتجه شرقًا")
      .replaceAll("Head west", "اتجه غربًا")

  // الاستمرار
      .replaceAll("Continue straight", "استمر مستقيمًا")
      .replaceAll("Keep straight", "استمر مستقيمًا")
      .replaceAll("Continue", "استمر")
      .replaceAll("straight", "مستقيمًا")

  // الانعطاف
      .replaceAll("Turn slight right", "انعطف يمينًا قليلًا")
      .replaceAll("Turn slight left", "انعطف يسارًا قليلًا")
      .replaceAll("Turn sharp right", "انعطف يمينًا حادًا")
      .replaceAll("Turn sharp left", "انعطف يسارًا حادًا")
      .replaceAll("Turn right", "انعطف يمينًا")
      .replaceAll("Turn left", "انعطف يسارًا")

  // الالتزام بالمسار
      .replaceAll("Keep right", "الزم اليمين")
      .replaceAll("Keep left", "الزم اليسار")

  // الشوارع
      .replaceAll("onto", "إلى")
      .replaceAll("on", "على")

  // الدوارات
      .replaceAll("Enter the roundabout", "ادخل الدوار")
      .replaceAll("Exit the roundabout", "اخرج من الدوار")

  // الوصول
      .replaceAll("Arrive at your destination on the left", "لقد وصلت إلى وجهتك على اليسار")
      .replaceAll("Arrive at your destination on the right", "لقد وصلت إلى وجهتك على اليمين")
      .replaceAll("Arrive at your destination", "لقد وصلت إلى وجهتك")
      .replaceAll("Arrive at", "وصلت إلى")

  // المسافة
      .replaceAll("for", "لمسافة")
      .replaceAll("meters", "متر")
      .replaceAll("meter", "متر")
      .replaceAll("kilometers", "كيلومتر")
      .replaceAll("kilometer", "كيلومتر")

  // تنظيف النص من الفواصل والفراغات الزائدة
      .replaceAll(",", "")
      .trim();
}
