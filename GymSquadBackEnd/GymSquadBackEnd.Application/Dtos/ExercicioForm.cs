using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Dtos
{
    public class ExercicioForm
    {
        public string Nome { get; set; }

        public byte[] Foto { get; set; }
    }
}
