using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PaymentGateway.Models
{
    public class SendOTPRequest
    {
        public string pp_BankID { get; set; }
        public string pp_Amount { get; set; }
        public string pp_TxnDateTime { get; set; } //GEN Done
        public string pp_TxnExpiryDateTime { get; set; } //GEN Done
        public string pp_BillReference { get; set; }
        public string pp_Description { get; set; }
        public string pp_AccountNo { get; set; }
        public string pp_CNIC { get; set; }
        public string pp_TxnRefNo { get; set; }//GEN Done
        public string pp_SecureHash { get; set; }//GEN
        
        //Getting Data From Appsetting.json
        #region
        public string pp_Language { get; set; }
        public string pp_ProductID { get; set; }
        public string pp_TxnCurrency { get; set; }
        public string pp_ReturnURL { get; set; }
        public string pp_MerchantID { get; set; }
        public string pp_Password { get; set; }
        public string pp_SubMerchantID { get; set; }
        public string pp_TxnType { get; set; }
        public string pp_Version { get; set; }
        #endregion
    }
}
