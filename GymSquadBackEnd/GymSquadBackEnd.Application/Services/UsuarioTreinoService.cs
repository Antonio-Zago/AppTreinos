using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Interfaces;
using GymSquadBackEnd.Application.Mappings;
using GymSquadBackEnd.Domain.Entities;
using GymSquadBackEnd.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Services
{
    public class UsuarioTreinoService : IUsuarioTreinoService
    {
        private readonly IUsuarioTreinoRepository _repository;

        private readonly ISerieRepository _serieRepository;

        private readonly ITreinoExercicioRepository _treinoExercicioRepository;

        private readonly ITreinoRepository _treinoRepository;

        private readonly IExerciciosRepository _exerciciosRepository;

        public UsuarioTreinoService(IUsuarioTreinoRepository repository,
                                    ITreinoExercicioRepository treinoExercicioRepository,
                                    ISerieRepository serieRepository,
                                    ITreinoRepository treinoRepository,
                                    IExerciciosRepository exerciciosRepository)
        {
            _repository = repository;
            _treinoExercicioRepository = treinoExercicioRepository;
            _serieRepository = serieRepository;
            _treinoRepository = treinoRepository;
            _exerciciosRepository = exerciciosRepository;
        }

        public List<UsuarioTreinoDto> getByUserId(int userId)
        {
            List<UsuarioTreinoDto> usuarioTreinoDtos = new List<UsuarioTreinoDto>();

            var listaUsuarioTreino = _repository.GetByUserId(userId).ToList();

            foreach (var usuarioTreino in listaUsuarioTreino)
            {
                List<TreinoExercicioDto> treinosExerciciosDto = new List<TreinoExercicioDto>();

                var dto = new UsuarioTreinoDto()
                {
                    TreinoId = usuarioTreino.TreinoId,
                    NomeTreino = usuarioTreino.Treino.Nome,
                    UsuarioId = usuarioTreino.UsuarioId,
                };

                var treinoExercicios = _treinoExercicioRepository.GetByTreinoId(usuarioTreino.TreinoId);

                foreach (var treinoExercicio in treinoExercicios)
                {
                    var treinoExercicioDto = new TreinoExercicioDto()
                    {
                        Id = treinoExercicio.ExercicioId,
                        Foto = treinoExercicio.Exercicio.Foto,
                        Nome = treinoExercicio.Exercicio.Nome,
                    };

                    var series = _serieRepository.GetByTreinoExercicioId(treinoExercicio.Id);

                    List<SerieDto> serieDtos = new List<SerieDto>();

                    foreach (var serie in series)
                    {
                        var serieDto = new SerieDto()
                        {
                            Carga = serie.Carga,
                            Repeticoes = serie.Repeticoes
                        };

                        serieDtos.Add(serieDto);
                    }

                    treinoExercicioDto.Series = serieDtos;

                    treinosExerciciosDto.Add(treinoExercicioDto);
                }

                dto.Exercicios = treinosExerciciosDto;
                usuarioTreinoDtos.Add(dto);
            }

            return usuarioTreinoDtos;
        }

        public UsuarioTreinoDto Post(UsuarioTreinoForm form)
        {
            var dto = new UsuarioTreinoDto();
            UsuarioTreino usuarioTreino;
            UsuarioTreino usuarioTreinoSalvo = null;
            Treino treino;            
    
            if (form.TreinoId != null)
            {
                ExcluirRegistros(form.TreinoId.Value, form.Exercicios);

                treino = _treinoRepository.GetById(form.TreinoId.Value);
                treino.Nome = form.NomeTreino;

                _treinoRepository.Update(treino);

            }
            else
            {
                treino = new Treino()
                {
                    Nome = form.NomeTreino
                };

                usuarioTreino = new UsuarioTreino()
                {
                    Treino = treino,
                    UsuarioId = form.UsuarioId,
                };

                usuarioTreinoSalvo = _repository.Post(usuarioTreino);
            }

            dto.NomeTreino = usuarioTreinoSalvo == null ? treino.Nome : usuarioTreinoSalvo.Treino.Nome;
            dto.TreinoId = usuarioTreinoSalvo == null ? form.TreinoId.Value : usuarioTreinoSalvo.TreinoId;
            dto.UsuarioId = usuarioTreinoSalvo == null ? form.UsuarioId : usuarioTreinoSalvo.UsuarioId;

            var idTreino = usuarioTreinoSalvo == null ? form.TreinoId.Value : usuarioTreinoSalvo.TreinoId;

            var dtoComExercicios = SalvarTreinoExercicio(form.Exercicios, idTreino, dto);

            
            return dtoComExercicios;
        }

        private void ExcluirRegistros(int treinoId, List<TreinoExercicioForm> treinoExercicioForms)
        {
            List<int> idSeriesJson = new List<int>();

            var treinosExerciciosBanco =  _treinoExercicioRepository.GetByTreinoId(treinoId);
           

            foreach (var treinoExercicioBanco in treinosExerciciosBanco)
            {
                var treinoExercicioJson = treinoExercicioForms.Where(a => a.ExercicioId == treinoExercicioBanco.ExercicioId).FirstOrDefault();

                var seriesBanco = _serieRepository.GetByTreinoExercicioId(treinoExercicioBanco.Id);

                if (treinoExercicioJson != null)
                {
                    foreach (var serieBanco in seriesBanco)
                    {
                        var seriesJson = treinoExercicioJson.Series.Where(a => a.SerieId == serieBanco.Id).FirstOrDefault();

                        if (seriesJson == null)
                        {
                            _serieRepository.DeleteById(serieBanco.Id);
                        }
                    }
 
                }
                else
                {                   

                    foreach (var serieBanco in seriesBanco)
                    {
                        _serieRepository.DeleteById(serieBanco.Id);
                    }

                    _treinoExercicioRepository.DeleteByExercicioIdAndTreinoId(treinoExercicioBanco.ExercicioId, treinoId);
                }
                
            }
                   
        }

        private UsuarioTreinoDto SalvarTreinoExercicio(List<TreinoExercicioForm> treinoExercicioForms, int treinoId, UsuarioTreinoDto dto)
        {
            List<TreinoExercicioDto> treinoExercicios = new List<TreinoExercicioDto>();

            foreach (var treinoExercicioForm in treinoExercicioForms)
            {
                Exercicio exercicio;
                TreinoExercicio treinoExercicio;
                TreinoExercicio treinoExercicioSalvo;   
                var treinoExercicioDto = new TreinoExercicioDto();
 
                exercicio = _exerciciosRepository.GetById(treinoExercicioForm.ExercicioId);

                treinoExercicioSalvo = _treinoExercicioRepository.GetByTreinoIdAndExercicioId(treinoId, treinoExercicioForm.ExercicioId);

                if (treinoExercicioSalvo == null)
                {
                    treinoExercicio = new TreinoExercicio()
                    {
                        TreinoId = treinoId,
                        Exercicio = exercicio
                    };

                    treinoExercicioSalvo = _treinoExercicioRepository.Post(treinoExercicio);
                }

                treinoExercicioDto.Nome = treinoExercicioSalvo.Exercicio.Nome;
                treinoExercicioDto.Foto = treinoExercicioSalvo.Exercicio.Foto;
                treinoExercicioDto.Id = treinoExercicioSalvo.Exercicio.Id;    

                var seriesSalvas = SalvarSeries(treinoExercicioForm.Series, treinoExercicioSalvo.Id);             

                treinoExercicioDto.Series = seriesSalvas;

                treinoExercicios.Add(treinoExercicioDto);
                
            }

            var treinoExerciciosBanco = _treinoExercicioRepository.GetByTreinoId(treinoId);

            dto.Exercicios = treinoExercicios;
            return dto;

        }

        private List<SerieDto> SalvarSeries(List<SeriesForm> seriesForm, int treinoExercicioId)
        {
            List<SerieDto> serieList = new List<SerieDto>(); 

            foreach (var serieForm in seriesForm)
            {
                Serie serie;
                Serie serieSalva;
                var serieDto = new SerieDto();

                if (serieForm.SerieId != null)
                {
                    serie = _serieRepository.GetById(serieForm.SerieId.Value);
                    serie.Repeticoes = serieForm.Repeticoes;
                    serie.Carga = serieForm.Carga;
                    serieSalva = _serieRepository.Update(serie);
                }
                else
                {
                    serie = new Serie()
                    {
                        Carga = serieForm.Carga,
                        Repeticoes = serieForm.Repeticoes,
                        TreinoExercicioId = treinoExercicioId,
                    };
                    serieSalva = _serieRepository.Post(serie);
                }       
                
                serieDto.Carga = serieSalva.Carga;
                serieDto.Repeticoes = serieSalva.Repeticoes;
                serieList.Add(serieDto);
            }
            return serieList;
        }
    }
}
