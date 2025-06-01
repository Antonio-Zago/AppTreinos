using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Exceptions
{
    public class ApiException
    {

        public ApiException(string statusCode, string message, string details)
        {
            StatusCode = statusCode;
            Message = message;
            Details = details;
        }

        public string StatusCode { get; set; }

        public string Message { get; set; }

        public string Details { get; set; }
    }
}
