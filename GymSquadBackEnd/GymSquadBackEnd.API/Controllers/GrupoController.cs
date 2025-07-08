using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GymSquadBackEnd.API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class GrupoController : ControllerBase
    {
        public IGrupoService _service { get; set; }

        public GrupoController(IGrupoService service)
        {
            _service = service;
        }

        [Authorize]
        [HttpGet("{codigo}")]
        public ActionResult<GrupoDto> GetByCodigo(int codigo)
        {
            var dto = _service.GetByCodigo(codigo);

            return Ok(dto);
        }
    }
}
