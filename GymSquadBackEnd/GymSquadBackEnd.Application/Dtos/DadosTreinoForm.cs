using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Dtos
{
    public class DadosTreinoForm
    {
        public int UsuarioId { get; set; }

        public int TreinoId { get; set; }

        public List<DadosTreinoExerciciosForm> Exercicios { get; set; }
    }
}
