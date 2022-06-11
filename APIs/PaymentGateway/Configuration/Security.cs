using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using PaymentGateway.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;

namespace PaymentGateway.Configuration
{
    public class Security
    {
        readonly static HttpClient client = new HttpClient();

        private readonly PrivateCredentials privateCredential;

        public Security() {}
        public Security(IConfiguration configuration)
        {
            privateCredential = new PrivateCredentials();
            configuration.GetSection("Private_Credentials").Bind(privateCredential);
        }
                
        public async Task<TokenResponse> Validation_Token() 
        {
            
            var credentials = JsonConvert.SerializeObject(privateCredential);
            var data = new StringContent(credentials, Encoding.UTF8, "application/json");

            string Url = "https://uat-apis.niftepay.pk/IRISPGW2/api/v1/oauth2/token";
            var request = new HttpRequestMessage
            {
                Method = HttpMethod.Post,
                RequestUri = new Uri(Url),
                Content = JsonContent.Create(new { credentials })
            };

            request.Headers.Authorization = new AuthenticationHeaderValue("Content-Type", "application/json");

            var response = await client.PostAsync(Url, data);
            response.EnsureSuccessStatusCode();

            var responsebody = await response.Content.ReadAsStringAsync().ConfigureAwait(false);

            var Token_Credentials = JsonConvert.DeserializeObject<TokenResponse>(responsebody);

            return (Token_Credentials);
        }

    }
}
