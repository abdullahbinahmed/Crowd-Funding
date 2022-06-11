using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PaymentGateway.Models
{
    public class BankResponseModel
    {
        public List<BankResponse> values { get; set; }
    }

    public class BankResponse
    {
        public string imd { get; set; }
        public string name { get; set; }
        public string bankCode { get; set; }
        public string category { get; set; }
        public string accountNumberLength { get; set; }
        public string accountNumberMessage { get; set; }
        public string swiftCode { get; set; }
    }
}
