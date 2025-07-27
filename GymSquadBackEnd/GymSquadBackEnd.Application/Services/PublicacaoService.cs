using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Interfaces;
using GymSquadBackEnd.Domain.Entities;
using GymSquadBackEnd.Domain.Interfaces;
using GymSquadBackEnd.Domain.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Services
{
    public class PublicacaoService : IPublicacaoService
    {
        private readonly IPublicacaoRepository _repository;

        private readonly IGrupoRepository _grupoRepository;

        public PublicacaoService(IPublicacaoRepository repository, IGrupoRepository grupoRepository)
        {
            _repository = repository;
            _grupoRepository = grupoRepository;
        }

        public PagedBaseResponseDto<PublicacaoDto> GetByCodigoGrupoPaged(int codigo, PagedBaseRequests request)
        {
            List<PublicacaoDto> dtos = new List<PublicacaoDto>();

            var entidades = _repository.GetByCodigoGrupoPaged(codigo, request);

            

            foreach (var entidade in entidades.Data)
            {
                var dto = new PublicacaoDto()
                {
                    CodigoGrupo = codigo,
                    Id = entidade.Id,
                    DataHora = entidade.DataHora,
                    Descricao = entidade.Descricao, 
                    Foto = entidade.Foto,
                    Titulo = entidade.Titulo,
                    UsuarioId = entidade.UsuarioId,
                    NomeUsuario = entidade.Usuario.NomeUsuario
                };

                dtos.Add(dto);
            }

            var result = new PagedBaseResponseDto<PublicacaoDto>(entidades.TotalRegisters, entidades.TotalPages, dtos);

            return result;
        }

        public PublicacaoDto Post(PublicacaoForm form)
        {
            var grupo = _grupoRepository.GetByCodigo(form.CodigoGrupo);

            if (grupo == null)
            {
                throw new Exception("Grupo não encontrado");
            }

            var entidade = new Publicacao()
            {
                Titulo = form.Titulo,
                Descricao = form.Descricao,
                Foto = form.Foto,  
                Grupo = grupo,
                UsuarioId = form.UsuarioId,
                DataHora = DateTime.Now
            };

            var publicacaoSalva = _repository.Post(entidade);

            var dto = new PublicacaoDto()
            {
                Id = publicacaoSalva.Id,
                Titulo = publicacaoSalva.Titulo,
                Descricao = publicacaoSalva.Descricao,
                CodigoGrupo = form.CodigoGrupo,
                Foto    =   publicacaoSalva.Foto,
                UsuarioId = publicacaoSalva.UsuarioId,
                DataHora = publicacaoSalva.DataHora
            };

            return dto;
        }
    }
}
