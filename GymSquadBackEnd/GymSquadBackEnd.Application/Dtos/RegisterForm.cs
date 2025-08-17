using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Dtos
{
    public class RegisterForm
    {
        public string Nome { get; set; }

        public string Email { get; set; }

        public string Senha { get; set; }

        public byte[]? Foto { get; set; }

    }
}
