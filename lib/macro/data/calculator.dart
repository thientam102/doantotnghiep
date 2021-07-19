import 'dart:math';

import 'package:appoint/macro/utils/enums.dart';

class Calculator {
  final double weight;
  final double height;
  final int age;
  final ActivityLevel activityLevel;
  final Goal goal;
  final Gender gender;

  Calculator({
    this.activityLevel,
    this.goal,
    this.gender,
    this.weight,
    this.height,
    this.age,
  });

  double bmi() {
    return (weight / pow(height / 100, 2));
  }

  String bmiScale() {
    if (bmi() < 18.5)
      return 'THIẾU CÂN';
    else if (bmi() >= 18.5 && bmi() <= 24.9)
      return 'BÌNH THƯỜNG';
    else if (bmi() >= 25 && bmi() <= 29.9)
      return 'THỪA CÂN';
    else if (bmi() >= 30 && bmi() <= 34.9)
      return 'BÉO PHÌ';
    else if (bmi() >= 35)
      return 'BÉO PHÌ NẶNG';
    else
      return 'BMI';
  }

  double bmr() {
    if (gender == Gender.male) {
      return 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      return 10 * weight + 6.25 * height - 5 * age - 161;
    }
  }

  double tdee() {
    if (activityLevel == ActivityLevel.rat_thap)
      return bmr() * 1.2;
    else if (activityLevel == ActivityLevel.nhe_nhang)
      return bmr() * 1.375;
    else if (activityLevel == ActivityLevel.vua_phai)
      return bmr() * 1.55;
    else if (activityLevel == ActivityLevel.nang)
      return bmr() * 1.725;
    else if (activityLevel == ActivityLevel.rat_nang)
      return bmr() * 1.9;
    else
      return null;
  }

  double totalCalories() {
    if (goal == Goal.giam_can) {
      return (tdee() - 500);
    } else if (goal == Goal.duy_tri_can_nang) {
      return tdee();
    } else if (goal == Goal.tang_can) {
      return tdee() + 400;
    } else
      return null;
  }

  //protein
  double protein() {
    if (goal == Goal.giam_can) {
      return ((1.1 * (weight * 2.2)) * 4) / 4;
    } else if (goal == Goal.duy_tri_can_nang) {
      return ((weight * 2.2) * 4) / 4;
    } else if (goal == Goal.tang_can) {
      return ((0.9 * (weight * 2.2)) * 4) / 4;
    }
    return 0;
  }

  //fats
  double fat() {
    if (goal == Goal.giam_can) {
      return (0.20 * totalCalories()) / 9;
    } else if (goal == Goal.duy_tri_can_nang) {
      return (0.20 * totalCalories()) / 9;
    } else if (goal == Goal.tang_can) {
      return (0.25 * totalCalories()) / 9;
    }
    return 0;
  }

  //carbs
  double carb() {
    if (goal == Goal.giam_can) {
      return (totalCalories() - (fat() * 9 + protein() * 4)) / 4;
    } else if (goal == Goal.duy_tri_can_nang) {
      return totalCalories() - (protein() * 4 + fat() * 9) / 4;
    } else if (goal == Goal.tang_can) {
      return totalCalories() - (fat() * 9 + protein() * 4) / 4;
    }
    return 0;
  }
}
