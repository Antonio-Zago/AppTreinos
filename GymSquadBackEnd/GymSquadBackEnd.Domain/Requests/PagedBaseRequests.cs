using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Requests
{
    public class PagedBaseRequests
    {
        public int Page { get; set; }

        public int PageSized { get; set; }

        public string OrderByProperty { get; set; }

        public bool Desc { get; set; }

        public PagedBaseRequests()
        {
            Page = 1;
            PageSized = 10;
            OrderByProperty = "Id";
            Desc = false;
        }
    }
}
