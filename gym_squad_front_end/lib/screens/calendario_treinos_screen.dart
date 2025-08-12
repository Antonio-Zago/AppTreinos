import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/treinos_inidividuais_business.dart';
import 'package:gym_squad_front_end/components/commum/alert_dialog_default.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/treino_iniciado_response.dart';
import 'package:gym_squad_front_end/models/memoria/treino_finalizado.dart';
import 'package:gym_squad_front_end/models/memoria/usuario_treinos_finalizados.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioTreinosScreen extends StatefulWidget {
  const CalendarioTreinosScreen({super.key});

  @override
  State<CalendarioTreinosScreen> createState() => _CalendarioTreinosScreenState();
}

class _CalendarioTreinosScreenState extends State<CalendarioTreinosScreen> {

  DateTime? _selectedDay; 
  DateTime _focusedDay = DateTime.now();
  UsuarioTreinosFinalizados? treinosUsuario;
  late TreinosInidividuaisBusiness treinosInidividuaisBusiness;
  bool _carregouTreinos = false;
  List<TreinoFinalizado> _listaTreinosDia = [];

  Widget _retornarMarcadores(List<Object?> listaEventos){
    
    List<Widget> listaMarcadores = [];

    for (int i = 0; i < listaEventos.length; i++){
      listaMarcadores.add(Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 1.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red, // cor do pontinho
          )
        )
      );
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: listaMarcadores
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: "Histórico de treinos",
      ),
      body: BackgroundCompletoDefault(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(ColorConstants.brancoPadrao),
            ),
            child: TableCalendar(
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isEmpty) return SizedBox();

                  return _retornarMarcadores(events);

                },

              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true
              ),
              locale: 'pt_BR',
              focusedDay: _focusedDay, 
              firstDay: DateTime.now().add(Duration(days: -365)), 
              lastDay: DateTime.now().add(Duration(days: 365)),
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                  _selectedDay = selectedDay;
                  _listaTreinosDia = _retornarTreinosDia(focusedDay);
                }); 
              },
              eventLoader: (day) {  
                
                return _retornarTreinosDia(day);
              },
              
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(top: 15),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _listaTreinosDia.length,
                itemBuilder: (context, index){

                  String dataFormatada = DateFormat("dd/MM/yyyy HH:mm").format(_listaTreinosDia[index].dataAtual!);

                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    color: Color(ColorConstants.linhasGrids),
                    child: ListTile(
                            title:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _listaTreinosDia[index].nomeTreino!,
                                    style: TextStyle(
                                        color: Color(ColorConstants.brancoPadrao),
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    dataFormatada,
                                    style: TextStyle(
                                        color: Color(ColorConstants.brancoPadrao),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            onTap: () {
                              Navigator.pushNamed(
                                    context,
                                    '/treino-individual-realizado',
                                    arguments: <String, dynamic>{
                                          'treinoRealizado': _listaTreinosDia[index],
                                        },
                                  ); 
                            },
                    ),
                  );
                }
              ),
          )
        ]
      ),
    );
  }

  List<TreinoFinalizado> _retornarTreinosDia(DateTime diaSelecionado){

    DateTime dataSelecionada = DateTime(diaSelecionado.year, diaSelecionado.month, diaSelecionado.day);

    if(treinosUsuario != null){
      return treinosUsuario!.treinos.where((a) => DateTime(a.dataAtual!.year, a.dataAtual!.month, a.dataAtual!.day).compareTo(dataSelecionada) == 0 ).toList();
    }
    return [];
  }

  @override
  void initState() {
    
     
    treinosInidividuaisBusiness = TreinosInidividuaisBusiness();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _carregouTreinos = false;
      });
      try{
        var response = await treinosInidividuaisBusiness.retornarTreinosFinalizadoNoDispositivo();

        setState(() {
          _carregouTreinos = true;
          treinosUsuario = response;
          _selectedDay = _focusedDay;
          _listaTreinosDia = _retornarTreinosDia(_selectedDay!);
        });
      }
      catch (e){
        setState(() {
          _carregouTreinos = true;
        });
        showDialog(
          context: context, 
          builder: (BuildContext context){
            return AlertDialogDefault(
              message: e.toString(),
              caminhoImagem: "assets/images/icones/erro.png",
            );
          });
      }
      
      
    });

    super.initState();
  }

}