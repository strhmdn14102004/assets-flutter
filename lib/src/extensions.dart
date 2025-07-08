// ignore_for_file: prefer_collection_literals, cascade_invocations

import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:jiffy/jiffy.dart";

extension StringExtension on String {
  String truncateTo(int maxLength) => (length <= maxLength) ? this : '${substring(0, maxLength)}...';
}

extension TimeOfDayExtension on TimeOfDay {
  int compareTo(TimeOfDay other) {
    if (hour < other.hour) {
      return -1;
    }

    if (hour > other.hour) {
      return 1;
    }

    if (minute < other.minute) {
      return -1;
    }

    if (minute > other.minute) {
      return 1;
    }

    return 0;
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

extension JiffyExtension on Jiffy {
  static Jiffy min = Jiffy.parseFromDateTime(DateTime(1900, 1, 1));
  static Jiffy max = Jiffy.parseFromDateTime(DateTime(2099, 12, 31));

  String dateFormat() {
    return format(pattern: "yyyy-MM-dd");
  }

  String dateTimeFormat() {
    return format(pattern: "yyyy-MM-dd HH:mm");
  }
}

extension NumberExtension on num {
  String currency() {
    NumberFormat numberFormat = NumberFormat("#,###.##", "id");

    return numberFormat.format(this);
  }

  String shortHand() {
    if (this >= 1000000000) {
      return '${(this / 1000000000).toStringAsFixed(1).replaceAll(RegExp(r"\.0$"), '')}B';
    } else if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1).replaceAll(RegExp(r"\.0$"), '')}M';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1).replaceAll(RegExp(r"\.0$"), '')}K';
    } else {
      return currency();
    }
  }
}

extension BoolParsing on String {
  bool parseBool() {
    return toLowerCase() == "true";
  }
}

extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> append(Map<K, V> map) {
    addAll(map);

    return this;
  }
}

extension ColorExtension on Color {
  Color darken([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.from(
        alpha: a,
        red: r * f,
        green: g  * f,
        blue: b * f,
    );
  }

  Color lighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100);

    var p = percent / 100;

    return Color.from(
        alpha: a,
        red: r + ((255 - r) * p),
        green: g + ((255 - g) * p),
        blue: b + ((255 - b) * p),
    );
  }
}
