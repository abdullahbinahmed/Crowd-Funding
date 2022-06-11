using Microsoft.AspNetCore.Mvc;
using PaymentGateway.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mime;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Text.Json;
using JsonSerializer = System.Text.Json.JsonSerializer;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Configuration;
using Microsoft.Extensions.Configuration;
using PaymentGateway.Configuration;
using System.Globalization;

namespace PaymentGateway.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PaymentController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        public PaymentController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        static HttpClient client = new HttpClient();
        
        [HttpGet]
        public async Task<BankResponseModel> GetBanks(string category, string MerchantID)
        {
            string Url = "https://uat-apis.niftepay.pk/IRISPGW2/api/v1/banks?category=" + category + "&MerchantID=" + MerchantID;
            
            var request = new HttpRequestMessage
            {
                Method = HttpMethod.Get,
                RequestUri = new Uri(Url),
                Content = new StringContent("{}", Encoding.UTF8, MediaTypeNames.Application.Json ),
            };


            Security security = new Security(_configuration);
            TokenResponse Token_Credentials = await security.Validation_Token();
            request.Headers.Authorization = new AuthenticationHeaderValue(Token_Credentials.token_type, Token_Credentials.access_token);
            
            var response = await client.SendAsync(request).ConfigureAwait(false);
            response.EnsureSuccessStatusCode();

            var responseBody = await response.Content.ReadAsStringAsync().ConfigureAwait(false);

            return JsonConvert.DeserializeObject<BankResponseModel>(responseBody);
        }

        [HttpPost("SendOTP")]
        public async Task<SendOTPResponse> SendOTP(SendOTPRequest otp)
        {
            string Url = "https://uat-apis.niftepay.pk/IRISPGW2Core/v2/transaction/otp";

            var formattedDtm = DateTime.ParseExact(DateTime.Now.ToString("yyyyMMddHHmmss"), "yyyyMMddHHmmss", CultureInfo.InvariantCulture);
            var specifiedDtm = DateTime.SpecifyKind(formattedDtm, DateTimeKind.Utc);

            _configuration.GetSection("OTP_Credentials").Bind(otp);
            otp.pp_TxnDateTime = DateTime.UtcNow.ToString("yyyyMMddHHmmss");
            otp.pp_TxnRefNo = "T"+ DateTime.UtcNow.ToString("yyyyMMddHHmmss");
            otp.pp_TxnExpiryDateTime = DateTime.UtcNow.AddDays(2).ToString("yyyyMMddHHmmss");
            var json = JsonConvert.SerializeObject(otp);
            var keyValuePairs = JsonConvert.DeserializeObject <Dictionary<string,string>>(json);
            string message = string.Empty;
            foreach (var item in keyValuePairs.Keys)
            {
                message += keyValuePairs[item] != null ? keyValuePairs[item]+"&"  : "";
            }

            message = message.Substring(0, message.Length - 1);
            message = string.Join("&","L4Fp3zqybe4=", message);
            var hash = Common.sha256(message);
            otp.pp_SecureHash = hash;

            var request = new HttpRequestMessage
            {
                Method = HttpMethod.Post,
                RequestUri = new Uri(Url),
                Content = new StringContent(JsonConvert.SerializeObject(otp), Encoding.UTF8, MediaTypeNames.Application.Json)
            };


            Security security = new Security(_configuration);
            TokenResponse Token_Credentials = await security.Validation_Token();

            request.Headers.Authorization = new AuthenticationHeaderValue("Content-Type", "application/json");
            request.Headers.Authorization = new AuthenticationHeaderValue(Token_Credentials.token_type, Token_Credentials.access_token);

            var response = await client.SendAsync(request).ConfigureAwait(false);
            response.EnsureSuccessStatusCode();

            var responseBody = await response.Content.ReadAsStringAsync().ConfigureAwait(false);

            return JsonConvert.DeserializeObject<SendOTPResponse>(responseBody);
        }

        [HttpPost("DoTransaction")]
        public async Task<AccountTransactionResponse> DoTransaction(DoAccountTransaction transaction)
        {
            string Url = "https://uat-apis.niftepay.pk/IRISPGW2Core/v2/transaction/acc";

            _configuration.GetSection("OTP_Credentials").Bind(transaction);

            var json = JsonConvert.SerializeObject(transaction);
            var keyValuePairs = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);
            string message = string.Empty;
            foreach (var item in keyValuePairs.Keys)
            {
                message += keyValuePairs[item] != null ? keyValuePairs[item] + "&" : "";
            }

            message = message.Substring(0, message.Length - 1);
            message = string.Join("&", "L4Fp3zqybe4=", message);
            var hash = Common.sha256(message);
            transaction.pp_SecureHash = hash;

            var request = new HttpRequestMessage
            {
                Method = HttpMethod.Post,
                RequestUri = new Uri(Url),
                Content = new StringContent(JsonConvert.SerializeObject(transaction), Encoding.UTF8, MediaTypeNames.Application.Json)
            };


            Security security = new Security(_configuration);
            TokenResponse Token_Credentials = await security.Validation_Token();

            request.Headers.Authorization = new AuthenticationHeaderValue("Content-Type", "application/json");
            request.Headers.Authorization = new AuthenticationHeaderValue(Token_Credentials.token_type, Token_Credentials.access_token);

            var response = await client.SendAsync(request).ConfigureAwait(false);
            response.EnsureSuccessStatusCode();

            var responseBody = await response.Content.ReadAsStringAsync().ConfigureAwait(false);

            return JsonConvert.DeserializeObject<AccountTransactionResponse>(responseBody);
        }

        //[HttpPost]
        //public async Task<AccountTransactionResponse> AccountTransactionResponse(AccountTransactionRequest account)
        //{

        //    string Url = "https://uat-apis.niftepay.pk/IRISPGW2Core/v2/transaction/acc";
        //    var request = new HttpRequestMessage
        //    {
        //        Method = HttpMethod.Post,
        //        RequestUri = new Uri(Url),
        //    };

        //    Security security = new Security();
        //    TokenResponse Token_Credentials = await security.Validation_Token();

        //    request.Headers.Authorization = new AuthenticationHeaderValue("Content-Type", "application/json");
        //    request.Headers.Authorization = new AuthenticationHeaderValue(Token_Credentials.token_type, Token_Credentials.access_token);

        //    var response = await client.SendAsync(request).ConfigureAwait(false);
        //    response.EnsureSuccessStatusCode();

        //    var responsebody = await response.Content.ReadAsStringAsync().ConfigureAwait(false);

        //    return JsonConvert.DeserializeObject<AccountTransactionResponse>(responsebody);
        //}

    }
    


}
