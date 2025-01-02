using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Mappings
{
    public static class ExerciciosMapping
    {
        public static Exercicio DtoToEntity(ExercicioForm form)
        {
            return new Exercicio() 
            { 
                Nome = form.Nome,
                Foto = form.Foto,
            };
        }
    }
}
