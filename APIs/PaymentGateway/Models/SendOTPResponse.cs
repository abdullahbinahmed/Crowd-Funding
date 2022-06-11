using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PaymentGateway.Models
{
    public class SendOTPResponse
    {
        public string pp_Version { get; set; }
        public string pp_TxnType { get; set; }
        public string pp_Language { get; set; }
        public string pp_MerchantID { get; set; }
        public string pp_TxnRefNo { get; set; }
        public string pp_Amount { get; set; }
        public string pp_TxnCurrency { get; set; }
        public string pp_TxnDateTime { get; set; }
        public string pp_BillReference { get; set; }
        public string pp_ResponseCode { get; set; }
        public string pp_ResponseMessage { get; set; }
        public string pp_RetreivalReferenceNo { get; set; }
        public string pp_AuthCode { get; set; }
        public string pp_BankID { get; set; }
        public string pp_ProductID { get; set; }
        public string pp_CNIC { get; set; }
        public string pp_SecureHash { get; set; }
        public string statusCode { get; set; }

    }
}
