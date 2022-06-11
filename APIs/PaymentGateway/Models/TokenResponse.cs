using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PaymentGateway.Models
{
    public class TokenResponse
    {
        public string token_type { get; set; }
        public string access_token { get; set; }      
    }
}
