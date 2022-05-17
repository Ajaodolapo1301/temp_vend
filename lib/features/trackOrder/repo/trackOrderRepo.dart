import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/error/failures.dart';
import '../dataSource/api.dart';
import '../model/trackOrderModel.dart';

abstract class AbstractTrackOrderRepo {
  Future<Either<Failure, TrackOrderModel>> trackOrder({id, token});
}

class TrackOrderRepoImpl implements AbstractTrackOrderRepo {
  @override
  Future<Either<Failure, TrackOrderModel>> trackOrder({id, token}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await TrackOrderApi().trackOrder(id: id, token: token);

        if (res["error"] == false) {
          return Right(res["trackModel"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    } else {
      return Left(ServerFailure("No internet access"));
    }
  }
}
