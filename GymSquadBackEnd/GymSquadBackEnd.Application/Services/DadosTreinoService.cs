using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Interfaces;
using GymSquadBackEnd.Domain.Entities;
using GymSquadBackEnd.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Services
{
    public class DadosTreinoService : IDadosTreinoService
    {
        private readonly IDadosTreinoRepository _repository;


        private readonly IDadosTreinoExerciciosRepository _repositoryExercicios;

        private readonly IDadosTreinoExercicioSeriesRepository _repositoryExerciciosSeries;

        private readonly IExerciciosRepository _exerciciosRepository;
        public DadosTreinoService(IDadosTreinoRepository repository, IDadosTreinoExerciciosRepository repositoryExercicios, IDadosTreinoExercicioSeriesRepository repositoryExerciciosSeries, IExerciciosRepository exerciciosRepository)
        {
            _repository = repository;
            _repositoryExercicios = repositoryExercicios;
            _repositoryExerciciosSeries = repositoryExerciciosSeries;
            _exerciciosRepository = exerciciosRepository;
        }

        public DadosTreinoDto Post(DadosTreinoForm form)
        {
            var dadosTreino = new DadosTreino();
            List<DadosTreinoExercicioDto> exerciciosDto = new List<DadosTreinoExercicioDto>();
         
            var dto = new DadosTreinoDto();

            dadosTreino.UsuarioId = form.UsuarioId;
            dadosTreino.TreinoId = form.TreinoId;
            dadosTreino.DataAtual = DateTime.Now;

            var dadoTreino = _repository.Post(dadosTreino);

            foreach (var exercicio in form.Exercicios)
            {
                List<DadosTreinoExercicioSerieDto> exerciciosSerieDto = new List<DadosTreinoExercicioSerieDto>();

                var exercicioEntidad = _exerciciosRepository.GetById(exercicio.ExercicioId);

                var dadosTreinoExercicioEntidade = new DadosTreinoExercicios();
                dadosTreinoExercicioEntidade.DadosTreinoId = dadoTreino.Id;
                dadosTreinoExercicioEntidade.ExercicioId = exercicio.ExercicioId;

                var dadosTreinoExercicio = _repositoryExercicios.Post(dadosTreinoExercicioEntidade);

                foreach (var serie in exercicio.DadosTreinoExercicioSeries)
                {
                    
                    var serieEntidade = new DadosTreinoExerciciosSerie();
                    serieEntidade.Repeticoes = serie.Repeticoes;
                    serieEntidade.DadoTreinoExercicioId = dadosTreinoExercicio.Id;
                    serieEntidade.Carga = serie.Carga;

                    var dadosTreinoExercicioSerie = _repositoryExerciciosSeries.Post(serieEntidade);

                    var exercicioSerieDto = new DadosTreinoExercicioSerieDto();
                    exercicioSerieDto.Id = dadosTreinoExercicioSerie.Id;
                    exercicioSerieDto.Repeticoes = dadosTreinoExercicioSerie.Repeticoes;
                    exercicioSerieDto.Carga = dadosTreinoExercicioSerie.Carga;

                    exerciciosSerieDto.Add(exercicioSerieDto);
                }

                var exercicioDto = new DadosTreinoExercicioDto();
                exercicioDto.Id = dadosTreinoExercicio.Id;
                exercicioDto.ExercicioId = dadosTreinoExercicio.ExercicioId;
                exercicioDto.DadosTreinoExercicioSeries = exerciciosSerieDto;
                exercicioDto.ExercicioNome = exercicioEntidad.Nome;
                exerciciosDto.Add(exercicioDto);

            }

            dto.UsuarioId = dadoTreino.UsuarioId;
            dto.TreinoId = dadosTreino.TreinoId;
            dto.DataAtual = dadosTreino.DataAtual;
            dto.Id = dadosTreino.Id;
            dto.Exercicios = exerciciosDto;

            return dto;
        }
    }
}
