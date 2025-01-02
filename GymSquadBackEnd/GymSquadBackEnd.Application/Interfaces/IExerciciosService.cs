using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Interfaces
{
    public interface IExerciciosService
    {
        public List<Exercicio> GetAll();

        public void Post(ExercicioForm form);
    }
}
