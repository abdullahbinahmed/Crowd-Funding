using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace PaymentGateway.Models
{
    public class AccountTransactionRequest
    {
        public string pp_Language { get; set; }
        public string pp_MerchantID { get; set; }
        public string pp_Password { get; set; }
        public string pp_SubMerchantID { get; set; }
        [Required]
        public string pp_OTP { get; set; }
        public string pp_TxnType { get; set; }
        [Required]
        public string pp_BankID { get; set; }
        public string pp_Version { get; set; }
        public string pp_TxnRefNo { get; set; }
        public string pp_RetreivalReferenceNo { get; set; }
        public string pp_SecureHash { get; set; }

    }
}
