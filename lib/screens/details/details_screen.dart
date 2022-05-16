import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/components/app_text.dart';
import '../../components/custom_card.dart';
import '../../shared/helper/mangers/size_config.dart';
import 'components/product_images.dart';
import 'components/top_rounded_container.dart';
import 'cubit/details_cubit.dart';

class DetailsScreen extends StatelessWidget {
  bool isDoctor;
  String examId;

  DetailsScreen(this.isDoctor, this.examId);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit()..getDetails(examId: examId),
      child: BlocConsumer<DetailsCubit, DetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xFFF5F6F9),
            body: state is GetDetailsLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: [
                      DetailsCubit.get(context)
                                  .historyModel
                                  .imageList
                                  .length != 0
                          ? ProductImages(
                              DetailsCubit.get(context).historyModel)
                          : Center(
                            child: Container(
                              padding: EdgeInsets.only(top: SizeConfigManger.bodyHeight*0.1),
                              height: SizeConfigManger.bodyHeight*0.3,
                                child: AppText(
                                text: 'No Examintion Images ',
                                isTitle: true,
                                color: Colors.grey,
                              )),
                          ),
                      TopRoundedContainer(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(20),
                            right: getProportionateScreenWidth(64),
                          ),
                          child: Column(
                            children: [
                              CustomCardInfo(
                                  title: 'Patient Name : ',
                                  detials:
                                      '${DetailsCubit.get(context).historyModel.name}'),
                              SizedBox(
                                height: 20.0,
                              ),
                              CustomCardInfo(
                                  title: 'Doctor Name : ',
                                  detials:
                                      '${DetailsCubit.get(context).historyModel.doctorName}'),
                              SizedBox(
                                height: 20.0,
                              ),
                              CustomCardInfo(
                                  title: 'Examination Date : ',
                                  detials:
                                      '${DetailsCubit.get(context).historyModel.date}'),
                              SizedBox(
                                height: 20.0,
                              ),
                              CustomCardInfo(
                                  title: 'Examination : ',
                                  detials:
                                      '${DetailsCubit.get(context).historyModel.examination}'),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
