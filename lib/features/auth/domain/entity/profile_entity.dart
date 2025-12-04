// lib/features/auth/domain/entity/profile_entity.dart

import 'package:equatable/equatable.dart';

// Berdasarkan model TenantTrustProfile
class TenantProfileEntity extends Equatable {
  final String id;
  final double ttiScore; // Float di Prisma = double di Dart
  final String kycStatus;
  final int paymentFaults;

  const TenantProfileEntity({
    required this.id,
    required this.ttiScore,
    required this.kycStatus,
    required this.paymentFaults,
  });

  @override
  List<Object?> get props => [id, ttiScore, kycStatus, paymentFaults];
}

// Berdasarkan model LandlordTrustProfile [cite: 31]
class LandlordProfileEntity extends Equatable {
  final String id;
  final double lrsScore;
  final double responseRate;
  final String kycStatus;

  const LandlordProfileEntity({
    required this.id,
    required this.lrsScore,
    required this.responseRate,
    required this.kycStatus,
  });

  @override
  List<Object?> get props => [id, lrsScore, responseRate, kycStatus];
}
