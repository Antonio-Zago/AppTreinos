using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Interfaces;
using GymSquadBackEnd.Domain.Requests;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GymSquadBackEnd.API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class PublicacaoController : ControllerBase
    {
        public IPublicacaoService _service { get; set; }

        public PublicacaoController(IPublicacaoService service)
        {
            _service = service;
        }

        [Authorize]
        [HttpPost]
        public ActionResult<PublicacaoDto> Post(PublicacaoForm form)
        {
            var dto = _service.Post(form);

            return Ok(dto);
        }

        [Authorize]
        [HttpGet("{codigo}")]
        public ActionResult<List<PublicacaoDto>> GetByCodigoGrupo(int codigo, [FromQuery] PagedBaseRequests request)
        {
            var dtos = _service.GetByCodigoGrupoPaged(codigo, request);

            return Ok(dtos);
        }
    }
}
