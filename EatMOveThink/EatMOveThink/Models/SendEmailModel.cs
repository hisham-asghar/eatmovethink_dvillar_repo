using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EatMOveThink.Models
{
    public class SendEmailModel
    {
        public String To { get; set; }
        public String Subject { get; set; }
        public String Body { get; set; }
    }
}