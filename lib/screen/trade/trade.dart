import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/screen/trade/trade_bloc/trade_cubit.dart';
import 'package:test_task/screen/trade/trade_bloc/trade_state.dart';
import 'package:test_task/utils/common.dart';

class TradePage extends StatelessWidget {
  const TradePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        iconTheme:const IconThemeData(
            color: Color(0xff36415F)
        ),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_outlined,color: Colors.white,)),
        title:const Text('Trade List',style: TextStyle(
            fontSize: 18,
            color: Colors.white
        )),
      ),
      body: BlocBuilder<TradeBloc, TradeState>(
        builder: (context, state) {

          if(state.loading){
            return const Center(child: CircularProgressIndicator(
              color: Color(0xff36415F),
            ));
          }
          if(state.errorMessage.isNotEmpty){
            return Center(
              child: Text(state.errorMessage),
            );
          }

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: ()async{
                    context.read<TradeBloc>().tradeData(context,false);
                  },
                  child: ListView.builder(
                    itemCount:  state.tradeList.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      itemBuilder: (context, index) {
                      var tradeItem = state.tradeList[index];
                      return Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Common.tradeTitle('currentPrice = ${tradeItem.currentPrice}'),
                                  const SizedBox(height: 2),
                                    tradeItem.comment == null ? Common.tradeTitle('No comment'): Common.tradeTitle('comment = ${tradeItem.comment}'),
                                    const SizedBox(height: 2),
                                    Common.tradeTitle('digits = ${tradeItem.digits}'),
                                    const SizedBox(height: 2),
                                    Common.tradeTitle('login = ${tradeItem.login}'),
                                    const SizedBox(height: 2),
                                    Common.tradeTitle('openPrice = ${tradeItem.openPrice}'),
                                    const SizedBox(height: 2),
                                    Common.tradeTitle('openTime = ${tradeItem.openTime}'),
                                    const SizedBox(height: 2),
                                    Common.tradeTitle('profit = ${tradeItem.profit}'),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Common.tradeTitle('sl = ${tradeItem.sl}'),
                                    const SizedBox(height: 2),
                                    Common.tradeTitle('swaps = ${tradeItem.swaps}'),
                                    const SizedBox(height: 2),
                                    Common.tradeTitle('symbol = ${tradeItem.symbol}'),
                                    const SizedBox(height: 2),
                                    Common.tradeTitle('tp = ${tradeItem.tp}'),
                                    const SizedBox(height: 2),
                                    Common.tradeTitle('ticket = ${tradeItem.ticket}'),
                                    const SizedBox(height: 2),
                                    Common.tradeTitle('type = ${tradeItem.type}'),
                                    const SizedBox(height: 2),
                                    Common.tradeTitle('volume = ${tradeItem.volume}'),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                      }),
                ),
              ),
              Container(
                height: 60,
                color: Colors.deepPurple,
                child: Center(
                  child: Text("Total Profit:  \$${state.totalProfit.toString()}",style: const TextStyle(color: Colors.white,fontSize: 20),),
                ),
              )

            ],
          );
        },
      ),
    );
  }
}
