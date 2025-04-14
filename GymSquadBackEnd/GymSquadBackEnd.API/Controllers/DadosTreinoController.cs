using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GymSquadBackEnd.API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class DadosTreinoController : ControllerBase
    {
        public IDadosTreinoService _service { get; set; }

        public DadosTreinoController(IDadosTreinoService service)
        {
            _service = service;
        }

        [Authorize]
        [HttpPost]
        public ActionResult<UsuarioTreinoDto> Post([FromBody] DadosTreinoForm form)
        {
            var usuarioTreinoDtos = _service.Post(form);

            return Ok(usuarioTreinoDtos);
        }
    }
}
