using GymSquadBackEnd.Domain.Requests;
using GymSquadBackEnd.Domain.Responses;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Infraestructure.Repositories
{
    public static class PagedBaseResponseHelper
    {
        public static TResponse GetResponse<TResponse, T>(IQueryable<T> query, PagedBaseRequests request) where TResponse : PagedBaseResponse<T>, new()
        {
            var resposne = new TResponse();

            var count = query.Count();

            resposne.TotalPages = (int)Math.Abs((double)count/request.PageSized);

            resposne.TotalRegisters = count;

            if (string.IsNullOrEmpty(request.OrderByProperty))
            {
                resposne.Data = query.ToList();
            }
            else
            {
                resposne.Data = query.OrderByDynamic(request.OrderByProperty,request.Desc).Skip((request.Page-1) * request.PageSized).Take(request.PageSized).ToList();
            }

            return resposne;
        }

        private static IEnumerable<T> OrderByDynamic<T>(this IEnumerable<T> query, string propertyName, bool desc)
        {
            if (desc)
            {
                return query.OrderByDescending(a => a.GetType().GetProperty(propertyName).GetValue(a, null));
            }
            return query.OrderBy(a => a.GetType().GetProperty(propertyName).GetValue(a, null));
        }
    }
}
