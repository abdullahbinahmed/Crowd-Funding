using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PaymentGateway.Models
{
    public class DoAccountTransaction
    {
        public string pp_Language { get; set; }
        public string pp_MerchantID { get; set; }
        public string pp_Password { get; set; }
        public string pp_SubMerchantID { get; set; }
        public string pp_OTP { get; set; }
        public string pp_TxnType { get; set; }
        public string pp_BankID { get; set; }
        public string pp_Version { get; set; }
        public string pp_TxnRefNo { get; set; }
        public string pp_RetreivalReferenceNo { get; set; }
        public string pp_SecureHash { get; set; }
    }
}
