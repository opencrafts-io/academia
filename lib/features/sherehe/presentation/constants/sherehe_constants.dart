import 'package:flutter/material.dart';

enum TicketStubMode {
  purchasingTicket,
  allTicketsPurchased,
  eventTicketPurchased,
}

enum PaymentTypes { paybill, till, sendMoney, pochi }

final List<String> availableGenres = [
  'Meetup',
  'Party',
  'Official',
  'Physical',
  'Social',
  'Sports',
  'Conference',
  'Workshop',
  'Seminar',
  'Webinar',
  'Festival',
  'Exhibition',
  'Charity',
  'Gaming',
  'Music',
  'Arts & Culture',
  'Food & Drink',
  'Networking',
  'Education',
  'Technology',
  'Health & Wellness',
  'Other',
];

enum TicketGroupTypes {
  individual,
  groupOfTwo,
  groupOfThree,
  groupOfFour,
  groupOfFive,
  groupOfSix,
  groupOfSeven,
  groupOfEight,
  groupOfNine,
  groupOfTen,
}

extension TicketGroupTypesX on TicketGroupTypes {
  String get label {
    switch (this) {
      case TicketGroupTypes.individual:
        return "Individual";
      case TicketGroupTypes.groupOfTwo:
        return "Group of 2";
      case TicketGroupTypes.groupOfThree:
        return "Group of 3";
      case TicketGroupTypes.groupOfFour:
        return "Group of 4";
      case TicketGroupTypes.groupOfFive:
        return "Group of 5";
      case TicketGroupTypes.groupOfSix:
        return "Group of 6";
      case TicketGroupTypes.groupOfSeven:
        return "Group of 7";
      case TicketGroupTypes.groupOfEight:
        return "Group of 8";
      case TicketGroupTypes.groupOfNine:
        return "Group of 9";
      case TicketGroupTypes.groupOfTen:
        return "Group of 10";
    }
  }

  IconData get icon {
    switch (this) {
      case TicketGroupTypes.individual:
        return Icons.person_outline;

      case TicketGroupTypes.groupOfTwo:
      case TicketGroupTypes.groupOfThree:
        return Icons.people_outline;

      case TicketGroupTypes.groupOfFour:
      case TicketGroupTypes.groupOfFive:
      case TicketGroupTypes.groupOfSix:
      case TicketGroupTypes.groupOfSeven:
      case TicketGroupTypes.groupOfEight:
      case TicketGroupTypes.groupOfNine:
      case TicketGroupTypes.groupOfTen:
        return Icons.groups_2_outlined;
    }
  }

  int get toBackend {
    switch (this) {
      case TicketGroupTypes.individual:
        return 1;
      case TicketGroupTypes.groupOfTwo:
        return 2;
      case TicketGroupTypes.groupOfThree:
        return 3;
      case TicketGroupTypes.groupOfFour:
        return 4;
      case TicketGroupTypes.groupOfFive:
        return 5;
      case TicketGroupTypes.groupOfSix:
        return 6;
      case TicketGroupTypes.groupOfSeven:
        return 7;
      case TicketGroupTypes.groupOfEight:
        return 8;
      case TicketGroupTypes.groupOfNine:
        return 9;
      case TicketGroupTypes.groupOfTen:
        return 10;
    }
  }

  static TicketGroupTypes fromBackend(String value) {
    switch (value) {
      case "INDIVIDUAL":
        return TicketGroupTypes.individual;
      case "GROUP_OF_TWO":
        return TicketGroupTypes.groupOfTwo;
      case "GROUP_OF_THREE":
        return TicketGroupTypes.groupOfThree;
      case "GROUP_OF_FOUR":
        return TicketGroupTypes.groupOfFour;
      case "GROUP_OF_FIVE":
        return TicketGroupTypes.groupOfFive;
      case "GROUP_OF_SIX":
        return TicketGroupTypes.groupOfSix;
      case "GROUP_OF_SEVEN":
        return TicketGroupTypes.groupOfSeven;
      case "GROUP_OF_EIGHT":
        return TicketGroupTypes.groupOfEight;
      case "GROUP_OF_NINE":
        return TicketGroupTypes.groupOfNine;
      case "GROUP_OF_TEN":
        return TicketGroupTypes.groupOfTen;
      default:
        throw Exception("Unknown TicketGroupTypes: $value");
    }
  }
}

enum ScopeTypes { public, institution, private }

extension ScopeTypesX on ScopeTypes {
  // UI Label
  String get label {
    switch (this) {
      case ScopeTypes.public:
        return "Public";
      case ScopeTypes.institution:
        return "Institution";
      case ScopeTypes.private:
        return "Private";
    }
  }

  IconData get icon {
    switch (this) {
      case ScopeTypes.public:
        return Icons.public;
      case ScopeTypes.institution:
        return Icons.school;
      case ScopeTypes.private:
        return Icons.lock;
    }
  }

  String get toBackend {
    switch (this) {
      case ScopeTypes.public:
        return "public";
      case ScopeTypes.institution:
        return "institution";
      case ScopeTypes.private:
        return "private";
    }
  }

  static ScopeTypes fromBackend(String value) {
    switch (value) {
      case "public":
        return ScopeTypes.public;
      case "institution":
        return ScopeTypes.institution;
      case "private":
        return ScopeTypes.private;
      default:
        throw Exception("Unknown ScopeTypes: $value");
    }
  }
}

enum AttendeeStatus { valid, wrongEvent, alreadyScanned, invalid }

extension AttendeeStatusMapper on String {
  AttendeeStatus toAttendeeStatus() {
    switch (toUpperCase()) {
      case 'VALID':
        return AttendeeStatus.valid;
      case 'ALREADY_SCANNED':
        return AttendeeStatus.alreadyScanned;
      case 'WRONG_EVENT':
        return AttendeeStatus.wrongEvent;
      case 'INVALID':
      default:
        return AttendeeStatus.invalid;
    }
  }
}
