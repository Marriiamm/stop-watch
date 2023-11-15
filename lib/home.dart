import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int seconds= 0, minutes = 0 ,hours = 0;
  String digitSeconds ="00",digitMinutes ="00", digitHours ="00";
  Timer? timer;
  bool started =false;
  List laps =[];

  void stop(){
    timer!.cancel();
    setState(() {
      started =false;
    }); 
  }

  void reset(){
    timer!.cancel();
    setState(() {
      seconds =0;
      minutes =0;
      hours =0;

      digitSeconds ="00";
      digitMinutes ="00";
      digitHours ="00";

      started =false;
      laps =[];
    });
  }

  void addLaps(){
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  void start(){
    started =true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) { 
      int localSecods = seconds+1;
      int localMinutes = minutes;
      int localHours = hours;

      if(localSecods >59){
        localMinutes ++;
        localSecods =0;
        if(localMinutes > 59){
          localHours ++;
          localMinutes=0;
        }
      }
    setState(() {
      hours =localHours;
      minutes =localMinutes;
      seconds =localSecods;
      digitSeconds =(seconds >=10)? "$seconds" :"0$seconds";
      digitHours =(hours >=10)? "$hours" :"0$hours";
      digitMinutes =(minutes >=10)? "$minutes" :"0$minutes";
    });
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 229, 214),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text("Stop Watch",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffA75D5D)
                ),),
              ),
              const SizedBox(height: 20.0,),
               Center(
                child: Text("$digitHours:$digitMinutes:$digitSeconds",
                style: const TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffA75D5D)
                ),)),
                const SizedBox(height: 10.0,),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xffA75D5D).withOpacity(0.7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                      itemCount: laps.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.only(bottom:10.0),
                          child: Container(
                            width: 120,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding:  const EdgeInsets.only(bottom:10.0, left: 10),
                              child: ListTile(
                                title: Text("Lap Number : ${index+1}",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),),
                                subtitle:Text("${laps[index]}",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete,color: Colors.white,), 
                                  onPressed: () { 
                                    laps.remove(index);
                                   },)
                              ),
                            ),
                          ),
                        );
                      }
                      ),
                  ),
                ),
              ),
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RawMaterialButton(
                    onPressed: (){
                      (!started)? start(): stop();
                    },
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Color(0xffA75D5D),
                      ),
                    ),
                    child:  Text((!started)? "Start": "pause",
                    style: const TextStyle(
                      color: Color(0xffA75D5D),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),),)),
                IconButton(
                  onPressed: (){
                    addLaps();
                  }, 
                  icon: Icon(Icons.flag_rounded,color: Colors.black.withOpacity(0.5),size: 28,)),
                Expanded(
                  child: RawMaterialButton(
                    onPressed: (){
                      reset();
                    },
                    fillColor: const Color(0xffA75D5D),
                    shape: const StadiumBorder(),
                    child: const Text("Reset",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),),)),
              ],
            ),
            ],
          ),
        )),
    );
  }
}