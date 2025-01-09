using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Dtos
{
    public class TreinoExercicioDto
    {
        public int Id { get; set; }

        public string Nome { get; set; }

        public byte[] Foto { get; set; }

        public List<SerieDto> Series { get; set; }
    }
}
