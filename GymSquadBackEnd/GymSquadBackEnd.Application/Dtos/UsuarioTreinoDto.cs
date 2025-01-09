using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Dtos
{
    public class UsuarioTreinoDto
    {
        public int UsuarioId { get; set; }

        public int TreinoId { get; set; }

        public string NomeTreino { get; set; }

        public List<TreinoExercicioDto> Exercicios { get; set; }

    }
}
