import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/features/home/data/models/category_item_model.dart';
import 'package:lawaen/features/home/data/models/claim_item_model.dart';
import 'package:lawaen/features/home/data/models/send_feed_back_model.dart';
import 'package:lawaen/features/home/data/models/toggle_model.dart';
import 'package:lawaen/features/home/presentation/params/claim_item.params.dart';
import 'package:lawaen/features/home/presentation/params/rate_item_params.dart';
import 'package:lawaen/features/home/presentation/params/report_item_params.dart';
import 'package:lawaen/features/home/presentation/params/send_feed_back_params.dart';

abstract class CategoryItemDetailsRepo {
  Future<Either<ErrorModel, ItemData>> getCategoryItems({required String secondCategoryId, required String itemId});
  Future<Either<ErrorModel, ToggleModel>> toggleFavorite({required String secondCategoryId, required String itemId});
  Future<Either<ErrorModel, Unit>> reateItem({
    required String secondCategoryId,
    required String itemId,
    required RateItemParams params,
  });
  Future<Either<ErrorModel, SendFeedBackModel>> sendFeedBack({
    required String secondCategoryId,
    required String itemId,
    required SendFeedBackParams params,
  });

  Future<Either<ErrorModel, ClaimItemModel?>> claimItem({
    required String secondCategoryId,
    required String itemId,
    required ClaimItemParams params,
  });

  Future<Either<ErrorModel, Unit>> reportItem({
    required String secondCategoryId,
    required String itemId,
    required ReportItemParams params,
  });
}
