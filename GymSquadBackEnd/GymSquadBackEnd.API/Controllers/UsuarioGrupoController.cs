using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GymSquadBackEnd.API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class UsuarioGrupoController : ControllerBase
    {
        public IUsuarioGrupoService _service { get; set; }

        public UsuarioGrupoController(IUsuarioGrupoService service)
        {
            _service = service;
        }

        [Authorize]
        [HttpGet("{userId}")]
        public ActionResult<List<UsuarioGrupoDto>> GetByUserId(int userId)
        {
            var dtos = _service.GetByUserId(userId);
            
            return Ok(dtos);
        }

        [Authorize]
        [HttpPost]
        public ActionResult<List<UsuarioGrupoDto>> Post(UsuarioGrupoForm form)
        {
            var dto = _service.Post(form);

            return Ok(dto);
        }

        [Authorize]
        [HttpDelete("{userId}/{grupoId}")]
        public ActionResult Post(int grupoId, int userId)
        {
            _service.DeleteByGrupoIdAndUserId(grupoId, userId);

            return Ok();
        }
    }
}
