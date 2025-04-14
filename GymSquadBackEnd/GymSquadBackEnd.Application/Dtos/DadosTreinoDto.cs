using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Dtos
{
    public class DadosTreinoDto
    {
        public int Id { get; set; }
        public int UsuarioId { get; set; }

        public int TreinoId { get; set; }

        public DateTime DataAtual { get; set; }

        public List<DadosTreinoExercicioDto> Exercicios { get; set; }
    }
}
