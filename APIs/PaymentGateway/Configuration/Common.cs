using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace PaymentGateway.Configuration
{
    public class Common
    {
        public readonly static string Salt = "L4Fp3zqybe4=";
        public static string sha256(string randomString)
        {
            var crypt = new HMACSHA256(Encoding.ASCII.GetBytes(Salt));
            string hash = String.Empty;
            byte[] crypto = crypt.ComputeHash(Encoding.ASCII.GetBytes(randomString));
            foreach (byte theByte in crypto)
            {
                hash += theByte.ToString("x2");
            }
            return hash.ToUpper();
        }

        public static string yyyymmdd(DateTime date)
        {
            return string.Join(date.Year.ToString(), Pad2(date.Month), Pad2(DateTime.Now.Day), Pad2(date.Hour)
                , Pad2(date.Minute), Pad2(date.Second));
        }

        public static string Pad2(int n)
        {
            return (n < 10 ? "0" : "") + n;
        }
    }
}
