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
    public class ExerciciosService : IExerciciosService
    {
        public IExerciciosRepository _exerciciosRepository { get; set; }

        public ExerciciosService(IExerciciosRepository exerciciosRepository)
        {
            _exerciciosRepository = exerciciosRepository;
        }

        public List<Exercicio> GetAll()
        {
            return _exerciciosRepository.GetAll();
        }

        public void Post(ExercicioForm form)
        {
            var exercicio = ExercicioMapper.DtoToEntity(form);

            _exerciciosRepository.Post(exercicio);
        }
    }
}
